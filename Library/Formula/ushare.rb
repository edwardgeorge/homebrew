require 'formula'

class Ushare <Formula
  url 'http://ushare.geexbox.org/releases/ushare-1.1a.tar.bz2'
  homepage 'http://ushare.geexbox.org/'
  md5 '5bbcdbf1ff85a9710fa3d4e82ccaa251'

  depends_on 'libupnp'
  depends_on 'libdlna'
  depends_on 'gettext'

  def patches
      { :p0 => "http://svn.macports.org/repository/macports/trunk/dports/net/ushare/files/patch-configure.diff" }
  end

  def install
    ENV.append 'LDFLAGS', "-L#{Formula.factory('gettext').prefix}/lib -lintl"
    ENV.append 'CFLAGS', "-I#{Formula.factory('gettext').prefix}/include"
    inreplace 'configure', /config.h/, 'src/config.h'
    system "./configure", "--prefix=#{prefix}", "--enable-dlna", "--disable-debug", "--with-libupnp-dir=#{HOMEBREW_PREFIX}",\
           "--with-libdlna-dir=#{HOMEBREW_PREFIX}", "--disable-strip"
    system "make install"
  end
end
