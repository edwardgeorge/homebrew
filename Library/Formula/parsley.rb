require 'formula'

class Parsley <Formula
  head 'git://github.com/fizx/parsley.git'
  homepage 'http://github.com/fizx/parsley'

  depends_on 'json-c'
  depends_on 'argp-standalone'
  depends_on 'pcre'

  def install
    inreplace 'configure', '-L/opt/local/lib ', ''
    inreplace 'configure', '-I/opt/local/include ', ''
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
