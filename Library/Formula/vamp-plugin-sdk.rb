require 'formula'

class VampPluginSdk <Formula
  url 'http://downloads.sourceforge.net/project/vamp/vamp-plugin-sdk/2.2/vamp-plugin-sdk-2.2.tar.gz'
  homepage 'http://www.vamp-plugins.org/'
  md5 '037cdb83f20a331ff1fa07d54550c773'

  depends_on 'pkg-config'
  depends_on 'libsndfile'

  def install
    ENV.append 'CXXFLAGS', "-I#{HOMEBREW_PREFIX}/include -I."
    #ENV.deparallelize
    inreplace 'build/Makefile.osx', /^CXXFLAGS\s+=.+$/, "CXXFLAGS = #{ENV['CXXFLAGS']}"
    inreplace 'build/Makefile.osx', /^LDFLAGS\s+=.+$/, "LDFLAGS = #{ENV['LDFLAGS']}"
    inreplace 'build/Makefile.osx', /^DYNAMIC_LDFLAGS\s+= \$\(ARCHFLAGS\)/, 'DYNAMIC_LDFLAGS = $(LDFLAGS)'
    system "make -f build/Makefile.osx"
    lib.install ['libvamp-hostsdk.dylib',
                 'libvamp-sdk.dylib',
                 'libvamp-hostsdk.a',
                 'libvamp-sdk.a']
    include.install ['vamp', 'vamp-sdk', 'vamp-hostsdk']
    bin.install 'host/vamp-simple-host'
    (prefix + 'examples').install ['examples/vamp-example-plugins.dylib',
                                   'examples/vamp-example-plugins.cat']
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
