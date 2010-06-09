require 'formula'

class Libgpod <Formula
  url 'git://gitorious.org/~teuf/libgpod/teuf-sandbox.git'
  version 'head'
  homepage ''
  md5 ''

  depends_on 'glib'
  depends_on 'gettext'
  depends_on 'gtk+'
  depends_on 'intltool'
  depends_on 'libimobiledevice'

  def patches
    # removes gtk-doc stuff...
    DATA
  end

  def install
    ENV.append "LIBTOOLIZE", "glibtoolize"
    ENV.append "ACLOCAL_FLAGS", "-I /usr/local/share/aclocal -I /usr/local/Cellar/gettext/0.17/share/aclocal/"
    inreplace 'autogen.sh', '--enable-gtk-doc ', ''
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--disable-debug", "--disable-dependency-tracking"
    inreplace 'Makefile', /SUBDIRS = (.*)docs/, 'SUBDIRS = \1'
    system "make install"
  end
end

__END__
diff --git a/configure.ac b/configure.ac
--- a/configure.ac
+++ b/configure.ac
@@ -312,7 +312,7 @@ AM_GLIB_GNU_GETTEXT
 dnl **************************************************
 dnl * gtk-doc
 dnl **************************************************
-GTK_DOC_CHECK(1.0)
+dnl GTK_DOC_CHECK(1.0)
 
 dnl **************************************************
 dnl * optional python bindings
@@ -382,8 +382,6 @@ bindings/python/Makefile
 bindings/python/examples/Makefile
 bindings/python/tests/Makefile
 docs/Makefile
-docs/reference/Makefile
-docs/reference/version.xml
 m4/Makefile
 po/Makefile.in
 src/Makefile

