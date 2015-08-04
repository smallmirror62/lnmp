#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cd ~/Download
mkdir -p software
cd software

curl -o openssl-1.0.2d.tar.gz http://www.openssl.org/source/openssl-1.0.2d.tar.gz
curl -o wget-1.16.tar.gz http://ftp.gnu.org/gnu/wget/wget-1.16.tar.gz
curl-7.43.0.tar.gz

tar zxvf openssl-1.0.2d.tar.gz
cd openssl-1.0.2d/
./Configure darwin64-x86_64-cc
make && make install
cd ../

tar zxvf wget-1.16.tar.gz
cd wget-1.16/
./configure --with-ssl=openssl
make && make install
cd ../


wget -c http://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.gz
wget -c http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz
wget -c http://ftp.gnu.org/gnu/readline/readline-6.3.tar.gz

wget -c http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz

ctags-5.8.tar.gz
automake-1.15.tar.gz
bzip2-1.0.6.tar.gz
freetype-2.6.tar.gz
gettext-0.19.tar.gz
jpegsrc.v9a.tar.gz
libxslt-1.1.28.tar.gz
zlib-1.2.8.tar.gz
libgd-2.1.0.tar.gz

wget -c http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/luajit/LuaJIT-2.0.4.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/mcrypt/libmcrypt-2.5.8.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/mhash/mhash-0.9.9.9.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/mcrypt/mcrypt-2.6.8.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/php/php-5.6.11.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/tengine/tengine-2.1.0.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/nginx/nginx-1.8.0.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/nginx/nginx-1.9.3.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/pcre/pcre2-10.20.tar.gz
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/pcre/pcre-8.37.tar.gz

tar zxvf libiconv-1.14.tar.gz
cd libiconv-1.14/
./configure
make && make install
cd ../

tar zxvf libmcrypt-2.5.8.tar.gz 
cd libmcrypt-2.5.8/
./configure
make && make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make && make install
cd ../../

tar zxvf mhash-0.9.9.9.tar.gz
cd mhash-0.9.9.9/
./configure
make && make install
cd ../

tar zxvf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8/
export LD_LIBRARY_PATH=/usr/local/lib
export LDFLAGS="-L/usr/local/lib/ -I/usr/local/include/"
export CFLAGS="-I/usr/local/include/"
./configure
make && make install
cd ../

tar zxf LuaJIT-2.0.4.tar.gz
cd LuaJIT-2.0.4
make && make install
cd ../

tar zxf pcre-8.37.tar.gz
cd pcre-8.37
./configure
make && make install
cd ../

tar zxf php-5.6.11.tar.gz
cd php-5.6.11/
./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --sysconfdir=/private/etc --with-apxs2=/usr/sbin/apxs --with-config-file-path=/etc --with-config-file-scan-dir=/private/etc/php --with-libxml-dir --with-openssl --with-kerberos --with-zlib --enable-bcmath --with-bz2 --enable-calendar --with-curl --enable-exif --enable-fpm --enable-ftp --with-png-dir --with-gd --with-jpeg-dir --enable-gd-native-ttf --with-icu-dir --enable-mbstring --enable-mbregex --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --with-xmlrpc --with-readline --with-iconv-dir --with-xsl --enable-zip --with-pcre-regex --with-freetype-dir --enable-xml --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pdo-sqlite --with-sqlite3 --disable-rpath  --enable-inline-optimization --with-mcrypt  --with-mhash --enable-pcntl --enable-sockets  --without-pear --with-gettext --enable-fileinfo --enable-opcache --enable-cli
make ZEND_EXTRA_LIBS='-liconv'
make install

cp php.ini-production /private/etc/php.ini
cp /private/etc/php-fpm.conf.default /private/etc/php-fpm.conf


tar zxf tengine-2.1.0.tar.gz
cd tengine-2.1.0
./configure --prefix=/usr --sbin-path=/usr/sbin --dso-path=/usr/lib/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/private/var/log/nginx/access.log --error-log-path=/private/var/log/nginx/error.log --lock-path=/private/var/lock/nginx.lock --pid-path=/private/var/run/nginx.pid --http-client-body-temp-path=/private/var/lib/nginx/body --http-fastcgi-temp-path=/private/var/lib/nginx/fastcgi --http-proxy-temp-path=/private/var/lib/nginx/proxy --http-scgi-temp-path=/private/var/lib/nginx/scgi --http-uwsgi-temp-path=/private/var/lib/nginx/uwsgi --with-luajit-inc=/usr/local/include/luajit-2.0 --with-luajit-lib=/usr/local/lib --with-ipv6 --with-mail --with-pcre-jit --with-http_ssl_module --with-http_sub_module --with-http_flv_module --with-mail_ssl_module --with-http_dav_module --with-http_xslt_module --with-http_spdy_module --with-http_geoip_module --with-http_realip_module --with-http_addition_module --with-http_gzip_static_module --with-http_stub_status_module --with-http_image_filter_module --with-http_lua_module=shared --with-http_footer_filter_module=shared --with-http_sysguard_module=shared --with-http_limit_req_module=shared --with-http_trim_filter_module=shared --with-http_upstream_ip_hash_module=shared --with-http_upstream_least_conn_module=shared --with-http_upstream_session_sticky_module=shared --with-http_concat_module=shared --with-cc-opt="-Wno-deprecated-declarations"

make && make install
cd ../


chown root /Library/LaunchDaemons/org.php-fpm.plist

sudo launchctl load /Library/LaunchDaemons/org.php-fpm.plist
sudo launchctl load /Library/LaunchDaemons/org.nginx.plist


sudo launchctl unload /Library/LaunchDaemons/org.php-fpm.plist
sudo pkill php-fpm
sudo launchctl load /Library/LaunchDaemons/org.php-fpm.plist

sudo launchctl unload /Library/LaunchDaemons/org.nginx.plist
sudo launchctl load /Library/LaunchDaemons/org.nginx.plist






