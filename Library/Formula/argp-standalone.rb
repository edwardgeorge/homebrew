require 'formula'

class ArgpStandalone <Formula
  url 'http://www.lysator.liu.se/~nisse/misc/argp-standalone-1.3.tar.gz'
  homepage 'http://www.freshports.org/devel/argp-standalone/?ref=darwinports.com'
  md5 '720704bac078d067111b32444e24ba69'


  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
    lib.install ["libargp.a"]
    include.install ["argp.h", "argp-fmtstream.h", "argp-namefrob.h"]
  end
end
