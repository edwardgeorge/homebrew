require 'formula'

class Liblo <Formula
  url 'http://downloads.sourceforge.net/project/liblo/liblo/0.26/liblo-0.26.tar.gz'
  homepage 'http://liblo.sourceforge.net/'
  md5 ''

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
           "--enable-ipv6", "--prefix=#{prefix}"
    system "make install"
  end
end
