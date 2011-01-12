require 'formula'

class Ifuse <Formula
  url 'http://www.libimobiledevice.org/downloads/ifuse-1.1.1.tar.bz2'
  homepage 'http://www.libimobiledevice.org/'
  md5 '8d528a79de024b91f12f8ac67965c37c'

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'libimobiledevice'

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end

  def caveats
    <<-EOS.undent
    This depends on the MacFUSE installation from http://code.google.com/p/macfuse/
    MacFUSE must be installed prior to installing this formula.
    EOS
  end
end
