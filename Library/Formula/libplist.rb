require 'formula'

class Libplist <Formula
  url 'http://cloud.github.com/downloads/JonathanBeck/libplist/libplist-1.3.tar.bz2'
  homepage 'http://github.com/JonathanBeck/libplist'
  md5 '0f48f4da8ddba5d7e186307622bf2c62'

  depends_on 'cmake'
  depends_on 'glib'
  depends_on 'libxml2'
  depends_on 'swig'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
