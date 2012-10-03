require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Geoip < AbstractPhp53Extension
  homepage 'http://pecl.php.net/package/geoip'
  url 'http://pecl.php.net/get/geoip-1.0.8.tgz'
  sha1 'f8d17da3e192002332ab54b9b4ab0f5deeaf9f15'
  head 'https://svn.php.net/repository/pecl/geoip/trunk/', :using => :svn
  version '1.0.8'

  depends_on 'autoconf' => :build
  depends_on 'geoip'
  depends_on 'php53' if build.include?('with-homebrew-php') && !Formula.factory('php53').installed?

  def install
    Dir.chdir "geoip-#{version}" unless build.head?

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-geoip=#{Formula.factory('geoip').prefix}"
    system "make"
    prefix.install "modules/geoip.so"
    write_config_file unless build.include? "without-config-file"
  end
end
