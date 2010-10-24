require 'formula'

class VampPluginTester <Formula
  url 'http://downloads.sourceforge.net/project/vamp/vamp-plugin-tester/1.0/vamp-plugin-tester-1.0.tar.gz'
  md5 '6a7c04557fa5673c0dc2fc54c0450533'
end

class VampPluginSdk <Formula
  url 'http://downloads.sourceforge.net/project/vamp/vamp-plugin-sdk/2.2/vamp-plugin-sdk-2.2.tar.gz'
  homepage 'http://www.vamp-plugins.org/'
  md5 '037cdb83f20a331ff1fa07d54550c773'

  depends_on 'pkg-config'
  depends_on 'libsndfile'

  def install
    ENV.append 'CXXFLAGS', "-I#{HOMEBREW_PREFIX}/include -I."
    inreplace 'build/Makefile.osx' do |s|
        s.gsub! /^CXXFLAGS\s+=.+$/, "CXXFLAGS = #{ENV['CXXFLAGS']}"
        s.gsub! /^LDFLAGS\s+=.+$/, "LDFLAGS = #{ENV['LDFLAGS']}"
        s.gsub! /^DYNAMIC_LDFLAGS\s+= \$\(ARCHFLAGS\)/, 'DYNAMIC_LDFLAGS = $(LDFLAGS)'
    end
    system "make -f build/Makefile.osx"
    lib.install ['libvamp-hostsdk.dylib',
                 'libvamp-sdk.dylib',
                 'libvamp-hostsdk.a',
                 'libvamp-sdk.a']
    include.install ['vamp', 'vamp-sdk', 'vamp-hostsdk']
    bin.install 'host/vamp-simple-host'
    (prefix + 'examples').install ['examples/vamp-example-plugins.dylib',
                                   'examples/vamp-example-plugins.cat']

    #pkg-config
    inreplace 'pkgconfig/vamp.pc.in', '%PREFIX%', "#{prefix}"
    inreplace 'pkgconfig/vamp-sdk.pc.in', '%PREFIX%', "#{prefix}"
    inreplace 'pkgconfig/vamp-hostsdk.pc.in', '%PREFIX%', "#{prefix}"
    (lib + 'pkgconfig').install 'pkgconfig/vamp.pc.in' => 'vamp.pc'
    (lib + 'pkgconfig').install 'pkgconfig/vamp-sdk.pc.in' => 'vamp-sdk.pc'
    (lib + 'pkgconfig').install 'pkgconfig/vamp-hostsdk.pc.in' => 'vamp-hostsdk.pc'

    # build vamp-plugin-tester
    VampPluginTester.new.brew do
        ENV.append 'CXXFLAGS', "-I#{include}"
        ENV.append 'LDFLAGS', "-L#{lib}"
        system 'make'
        bin.install 'vamp-plugin-tester'
    end
  end

  def caveats; <<-EOS
Installing the Example Plugins
------------------------------

To install the example plugins so you can load them in Vamp hosts,
copy the files

   examples/vamp-example-plugins.dylib
and
   examples/vamp-example-plugins.cat

to
   /Library/Audio/Plug-Ins/Vamp/
or 
   $HOME/Library/Audio/Plug-Ins/Vamp/

  EOS
  end
end
