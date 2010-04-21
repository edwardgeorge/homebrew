require 'formula'

class Libnids <Formula
  url 'http://downloads.sourceforge.net/project/libnids/libnids/1.24/libnids-1.24.tar.gz'
  homepage 'http://libnids.sourceforge.net/'
  md5 '72d37c79c85615ffe158aa524d649610'

  depends_on 'libnet'
  depends_on 'pkg-config'
  depends_on 'glib'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
