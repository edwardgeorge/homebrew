require 'formula'

class Ifuse <Formula
  url 'http://www.libimobiledevice.org/downloads/ifuse-1.0.0.tar.bz2'
  homepage 'http://www.libimobiledevice.org/'
  md5 '325d58abe182afa95187e6c55f2bba5f'

  depends_on 'libimobiledevice'
  depends_on 'glib'

  def caveats
    <<-EOS.undent
    This depends on the MacFUSE installation from http://code.google.com/p/macfuse/
    MacFUSE must be installed prior to installing this formula.
    EOS
  end


  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
