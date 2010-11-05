require 'formula'

class Darkice <Formula
  # coreaudio brach of darkice:
  head 'http://darkice.googlecode.com/svn/darkice/branches/darkice-macosx'
  homepage 'http://code.google.com/p/darkice/'

  depends_on 'libvorbis'
  depends_on 'lame'
  depends_on 'two-lame'
  depends_on 'faac'
  # CoreAudio requires Jack headers to build.
  # Preference is JackOSX over Homebrew.
  depends_on 'jack' if ARGV.include? '--with-jack'

  def options
    [
        # disable following 2 options to keep it simple for users.
        #["--disable-coreaudio", "Disable CoreAudio support."],
        #["--with-jackosx", "Use JackOSX install. (implied with CoreAudio support)"],
        ["--with-jack", "Use Homebrew's Jack instead of JackOSX."],
    ]
  end

  def install
    inreplace 'autogen.sh', 'libtool', 'glibtool'
    args = ["./autogen.sh", "--disable-dependency-tracking", "--prefix=#{prefix}",
        "--with-lame-prefix=#{HOMEBREW_PREFIX}",
        "--with-vorbis-prefix=#{HOMEBREW_PREFIX}",
        "--with-twolame-prefix=#{HOMEBREW_PREFIX}",
        "--with-faac-prefix=#{HOMEBREW_PREFIX}"]
    args << "--with-core=yes" if !ARGV.include? '--disable-coreaudio'
    if ARGV.include? '--with-jack'
      # use Homebrew jack
      args << "--with-jack-prefix=#{HOMEBREW_PREFIX}"
    elsif !ARGV.include? '--disable-coreaudio' or ARGV.include? '--with-jackosx'
      # otherwise if coreaudio is left enabled or the --with-jackosx option is
      # specified then set the jack prefix to /usr/local
      args << "--with-jack-prefix=/usr/local"  # JackOSX install location
    end
    system *args
    system "make install"
  end

  def caveats; <<-EOS.undent
      CoreAudio support requires Jack Headers, this formula assumes JackOSX is installed.
      If Homebrew's Jack is required please provide the --with-jack option.
      EOS
  end
end
