##安装依赖
````shell
sudo -s
LANG=C
yum -y install patch make cmake gcc gcc-c++ gcc-g77 bison flex file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel gmp-devel gettext gettext-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers vim-minimal nano fonts-chinese gmp-devel pspell-devel unzip libcap diffutils
````

##编译安装PHP所需的支持库
````shell
mkdir -p software
cd software
wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/luajit/LuaJIT-2.0.4.tar.gz
wget -c http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
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

ln -s /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la
ln -s /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so
ln -s /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4
ln -s /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8
ln -s /usr/local/lib/libmhash.a /usr/lib/libmhash.a
ln -s /usr/local/lib/libmhash.la /usr/lib/libmhash.la
ln -s /usr/local/lib/libmhash.so /usr/lib/libmhash.so
ln -s /usr/local/lib/libmhash.so.2 /usr/lib/libmhash.so.2
ln -s /usr/local/lib/libmhash.so.2.0.1 /usr/lib/libmhash.so.2.0.1
ln -s /usr/local/bin/libmcrypt-config /usr/bin/libmcrypt-config

/sbin/ldconfig

tar zxvf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8/
# For Mac
export LD_LIBRARY_PATH=/usr/local/lib
export LDFLAGS="-L/usr/local/lib/ -I/usr/local/include/"
export CFLAGS="-I/usr/local/include/"

./configure
make && make install
cd ../
````

##编译安装PHP
````shell
tar zxf php-5.6.11.tar.gz
cd php-5.6.11/
./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --sysconfdir=/private/etc --with-config-file-path=/etc --with-config-file-scan-dir=/private/etc/php --with-libxml-dir --with-openssl --with-kerberos --with-zlib --enable-bcmath --with-bz2 --enable-calendar --with-curl --enable-exif --enable-fpm --enable-ftp --with-png-dir --with-gd --with-jpeg-dir --enable-gd-native-ttf --with-icu-dir --enable-mbstring --enable-mbregex --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --with-xmlrpc --with-readline --with-iconv-dir --with-xsl --enable-zip --with-pcre-regex --with-freetype-dir --enable-xml --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pdo-sqlite --with-sqlite3 --disable-rpath  --enable-inline-optimization --with-mcrypt  --with-mhash --enable-pcntl --enable-sockets  --without-pear --with-gettext --enable-fileinfo --enable-opcache --enable-cli

#OS X
./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --sysconfdir=/private/etc --with-apxs2=/usr/sbin/apxs --with-config-file-path=/etc --with-config-file-scan-dir=/private/etc/php --with-libxml-dir --with-openssl --with-kerberos --with-zlib --enable-bcmath --with-bz2 --enable-calendar --with-curl --enable-exif --enable-fpm --enable-ftp --with-png-dir --with-gd --with-jpeg-dir --enable-gd-native-ttf --with-icu-dir --enable-mbstring --enable-mbregex --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --with-xmlrpc --with-readline --with-iconv-dir --with-xsl --enable-zip --with-pcre-regex --with-freetype-dir --enable-xml --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pdo-sqlite --with-sqlite3 --disable-rpath  --enable-inline-optimization --with-mcrypt  --with-mhash --enable-pcntl --enable-sockets  --without-pear --with-gettext --enable-fileinfo --enable-opcache --enable-cli

make ZEND_EXTRA_LIBS='-liconv'
make install

cp php.ini-production /usr/local/php/etc/php.ini
cp php.ini-production /usr/local/php/etc/php.ini-production 
cp php.ini-development /usr/local/php/etc/php.ini-development
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm

sed -i 's/post_max_size = 8M/post_max_size = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /usr/local/php/etc/php.ini
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=0/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/; extension_dir = "./"/extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20131226"/g' /usr/local/php/etc/php.ini
sed -i 's/;extension_dir = "./"/extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20131226"/g' /usr/local/php/etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /usr/local/php/etc/php.ini
sed -i 's/disable_functions =.*/disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,popen,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server/g' /usr/local/php/etc/php.ini

tar zxf zend-loader-php5.6-linux-x86_64.tar.gz
/usr/local/zend
cd zend-loader-php5.6-linux-x86_64
cp ZendGuardLoader.so /usr/local/zend/
cp opcache.so /usr/local/zend/
cp README.txt /usr/local/zend/

cat >>/usr/local/php/etc/php.ini<<EOF

;eaccelerator

;ionCube

[Zend ZendGuard Loader]
zend_extension=/usr/local/zend/ZendGuardLoader.so
zend_loader.enable=1
zend_loader.disable_licensing=0
zend_loader.obfuscation_level_support=3
zend_loader.license_path=

;opcache
[Zend Opcache]
zend_extension=opcache.so
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.revalidate_freq=60
opcache.fast_shutdown=1
opcache.enable_cli=1
;opcache end

;xcache
;xcache end
EOF

````
##编译安装Nginx依赖

````shell
tar zxf LuaJIT-2.0.4.tar.gz
cd LuaJIT-2.0.4
make && make install
cd ../

tar zxf pcre-8.37.tar.gz
cd pcre-8.37
./configure
make && make install
cd ../

````

##编译安装Nginx

````shell
#编译tengine（推荐）
tar zxf tengine-2.1.0.tar.gz
cd tengine-2.1.0
./configure  \
--user=www \
--group=www \
--prefix=/usr/local/nginx \
--conf-path=/etc/nginx/nginx.conf 
--error-log-path=/var/log/nginx/error.log
--http-client-body-temp-path=/var/lib/nginx/body 
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi 
--http-log-path=/var/log/nginx/access.log
--http-proxy-temp-path=/var/lib/nginx/proxy
--http-scgi-temp-path=/var/lib/nginx/scgi
--http-uwsgi-temp-path=/var/lib/nginx/uwsgi
--lock-path=/var/lock/nginx.lock 
--pid-path=/var/run/nginx.pid 
--with-ipv6 \
--with-pcre-jit \
--with-http_stub_status_module \
--with-http_ssl_module \
--with-http_gzip_static_module \
--with-http_spdy_module \
--with-http_stub_status_module \
--with-http_lua_module=shared \
--with-luajit-inc=/usr/local/include/luajit-2.0 \
--with-luajit-lib=/usr/local/lib \
--with-http_footer_filter_module=shared \
--with-http_sysguard_module=shared \
--with-http_limit_req_module=shared \
--with-http_trim_filter_module=shared \
--with-http_upstream_ip_hash_module=shared \
--with-http_upstream_least_conn_module=shared \
--with-http_upstream_session_sticky_module=shared \
--with-http_concat_module=shared
--dso-tool-path=
--dso-path=

make && make install
cd ../

#编译原版NGINX
tar zxvf nginx-0.8.46.tar.gz
cd nginx-0.8.46/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module
make && make install
cd ../

ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

````
##收尾工作
````shell

/usr/sbin/groupadd www
/usr/sbin/useradd -m -g www www

#设置自动启动
chkconfig nginx on
chkconfig php-fpm on


#创建网站和日志目录并赋予权限
mkdir /home/www/default
chown -R www:www /home/www/default
chmod -R 755 /home/www/default
