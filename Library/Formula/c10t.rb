require 'formula'

class C10t <Formula
  url 'http://github.com/udoprog/c10t/tarball/1.0'
  homepage 'http://github.com/udoprog/c10t'
  md5 '0c947c6befef79b040858c1ed308c0d6'

  depends_on 'cmake'
  depends_on 'libpng'
  depends_on 'boost'

  def install
    #system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          #"--prefix=#{prefix}"
    inreplace 'CMakeLists.txt', 'boost_thread', 'boost_thread-mt'
    inreplace 'test/CMakeLists.txt', 'boost_unit_test_framework', 'boost_unit_test_framework-mt'
    system "cmake . #{std_cmake_parameters}"
    system "make"
    bin.install "c10t"
  end
end
