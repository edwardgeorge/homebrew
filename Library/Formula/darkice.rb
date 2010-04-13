require 'formula'

class Darkice <Formula
  # standard darkice:
  #url 'http://darkice.googlecode.com/files/darkice-0.20.1.tar.gz'
  #md5 'cf4b8f81b9e4a92a8cd57d15fcbb4969'
  # coreaudio brach of darkice:
  url 'http://darksnow.radiolivre.org/darkice-osx-0.20.tar.gz'
  md5 'c83f5b1210023a1cb1d0724edab601d8'
  homepage 'http://code.google.com/p/darkice/'

  depends_on 'libvorbis'
  depends_on 'lame'
  depends_on 'two-lame'
  depends_on 'faac'

  def options
    [
        ["--with-jackosx", "Use JackOSX install."],
        ["--with-core", "CoreAudio support. (needs JackOSX)"],
    ]
  end



  def install
    args = ["./configure", "--disable-dependency-tracking", "--prefix=#{prefix}", "--with-lame-prefix=#{HOMEBREW_PREFIX}",
        "--with-vorbis-prefix=#{HOMEBREW_PREFIX}", "--with-twolame-prefix=#{HOMEBREW_PREFIX}",
        "--with-faac-prefix=#{HOMEBREW_PREFIX}"]
    args << "--with-core=yes" if ARGV.include? '--with-core'
    if ARGV.include? '--with-jackosx' or ARGV.include? '--with-core'
      args << "--with-jack-prefix=/usr/local" # core requires jack
    end
    system *args
    system "make install"
  end
end
