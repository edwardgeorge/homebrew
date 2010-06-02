require 'formula'

class Swig <Formula
  url 'http://downloads.sourceforge.net/project/swig/swig/swig-1.3.40/swig-1.3.40.tar.gz'
  homepage 'http://www.swig.org/'
  md5 '2df766c9e03e02811b1ab4bba1c7b9cc'

  def keg_only?
    :provided_by_osx
  end


  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
