require 'formula'

class Rubberband <Formula
  url 'http://code.breakfastquay.com/attachments/download/1/rubberband-1.5.0.tar.bz2'
  homepage 'http://breakfastquay.com/rubberband/'
  md5 'c5f288d644fcd46bd159e187bcc33f25'

  depends_on 'pkg-config' => :build
  depends_on 'vamp-plugin-sdk' => :optional if ARGV.include? "--vamp-plugin"
  depends_on 'fftw'
  depends_on 'libsamplerate'
  depends_on 'libsndfile'

  def options
    [['--vamp-plugin', 'Build Vamp Plugin.']]
  end

  def install
    # the OSX makefile in the current release is incorrect.
    # http://www.breakfastquay.com/forum/comments.php?DiscussionID=16
    system 'curl -LO http://code.breakfastquay.com/projects/rubberband/repository/raw/misc/Makefile.osx'
    inreplace 'Makefile.osx' do |s|
        # remove some flags
        s.gsub! '-isysroot /Developer/SDKs/MacOSX10.4u.sdk', ''
        s.gsub! '-arch i386 -arch ppc', ''
        # remove relative includes (assumes you build in same dir as vamp)
        s.gsub! '-I../include -I../vamp-plugin-sdk', ''
        s.gsub! '-L../lib', ''
        s.gsub! '-L../vamp-plugin-sdk/vamp-sdk', ''
        # change dynamic lib extension
        s.gsub! /^DYNAMIC_EXTENSION\s+:= .so$/, 'DYNAMIC_EXTENSION = .dylib'
        # remove LADSPA plugin target to avoid dependency
        s.gsub! /^(all: bin lib .+)\$\(LADSPA_TARGET\)/, '\1'
    end

    if !ARGV.include? '--vamp-plugin'
        inreplace 'Makefile.osx', /^(all: bin lib .+)\$\(VAMP_TARGET\)/, '\1'
    end

    system "make -f Makefile.osx"
    bin.install 'bin/rubberband'
    lib.install ['lib/librubberband.dylib', 'lib/librubberband.a']
    include.install 'rubberband'

    if ARGV.include? '--vamp-plugin'
        lib.install 'lib/vamp-rubberband.dylib'
    end

    # pkg-config files
    inreplace 'rubberband.pc.in', '%PREFIX%', "#{prefix}"
    (lib + 'pkgconfig').install 'rubberband.pc.in' => 'rubberband.pc'
  end
end
