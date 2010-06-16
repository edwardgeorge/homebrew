require 'formula'

class Ntop <Formula
  url 'http://downloads.sourceforge.net/project/ntop/ntop/ntop-3.4-pre3/ntop-3.4-pre3.tar.gz'
  homepage 'http://www.ntop.org/'
  md5 '4b4977b6d5f78110d32af09bff7e4bfa'

 depends_on 'wget'
 depends_on 'gawk'
 depends_on 'rrdtool'
 depends_on 'geoip'
 depends_on 'gdbm'
 depends_on 'pcre'

  def install
    system "./autogen.sh", "--noconfig"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
        "--prefix=#{prefix}",
        "--with-localedir=#{prefix}/share/locale",
        "--mandir=#{prefix}/share/man"
    system "make install"
  end
end
