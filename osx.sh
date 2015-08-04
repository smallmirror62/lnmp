##安装依赖
````shell
sudo -s
LANG=C
yum -y install patch make cmake gcc gcc-c++ gcc-g77 bison flex file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel gmp-devel gettext gettext-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers vim-minimal nano fonts-chinese gmp-devel pspell-devel unzip libcap diffutils readline-devel libxslt libxslt-devel
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

````

##编译安装PHP
````shell
tar zxf php-5.6.11.tar.gz
cd php-5.6.11/
./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --sysconfdir=/private/etc --with-apxs2=/usr/sbin/apxs --with-config-file-path=/etc --with-config-file-scan-dir=/private/etc/php --with-libxml-dir --with-openssl --with-kerberos --with-zlib --enable-bcmath --with-bz2 --enable-calendar --with-curl --enable-exif --enable-fpm --enable-ftp --with-png-dir --with-gd --with-jpeg-dir --enable-gd-native-ttf --with-icu-dir --enable-mbstring --enable-mbregex --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --with-xmlrpc --with-readline --with-iconv-dir --with-xsl --enable-zip --with-pcre-regex --with-freetype-dir --enable-xml --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pdo-sqlite --with-sqlite3 --disable-rpath  --enable-inline-optimization --with-mcrypt  --with-mhash --enable-pcntl --enable-sockets  --without-pear --with-gettext --enable-fileinfo --enable-opcache --enable-cli
make ZEND_EXTRA_LIBS='-liconv'
make install

cp php.ini-production /etc/php.ini
cp /etc/php-fpm.conf.default /etc/php-fpm.conf

````
##编译安装Nginx

````shell
#编译tengine（推荐）
tar zxf tengine-2.1.0.tar.gz
cd tengine-2.1.0
./configure --prefix=/usr --sbin-path=/usr/sbin --dso-path=/usr/lib/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/private/var/log/nginx/access.log --error-log-path=/private/var/log/nginx/error.log --lock-path=/private/var/lock/nginx.lock --pid-path=/private/var/run/nginx.pid --http-client-body-temp-path=/private/var/lib/nginx/body --http-fastcgi-temp-path=/private/var/lib/nginx/fastcgi --http-proxy-temp-path=/private/var/lib/nginx/proxy --http-scgi-temp-path=/private/var/lib/nginx/scgi --http-uwsgi-temp-path=/private/var/lib/nginx/uwsgi --with-luajit-inc=/usr/local/include/luajit-2.0 --with-luajit-lib=/usr/local/lib --with-ipv6 --with-mail --with-pcre-jit --with-http_ssl_module --with-http_sub_module --with-http_flv_module --with-mail_ssl_module --with-http_dav_module --with-http_xslt_module --with-http_spdy_module --with-http_geoip_module --with-http_realip_module --with-http_addition_module --with-http_gzip_static_module --with-http_stub_status_module --with-http_image_filter_module --with-http_lua_module=shared --with-http_footer_filter_module=shared --with-http_sysguard_module=shared --with-http_limit_req_module=shared --with-http_trim_filter_module=shared --with-http_upstream_ip_hash_module=shared --with-http_upstream_least_conn_module=shared --with-http_upstream_session_sticky_module=shared --with-http_concat_module=shared --with-cc-opt="-Wno-deprecated-declarations"

#无GEOIP http_image_filter_module
./configure --prefix=/usr --sbin-path=/usr/sbin --dso-path=/usr/lib/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/private/var/log/nginx/access.log --error-log-path=/private/var/log/nginx/error.log --lock-path=/private/var/lock/nginx.lock --pid-path=/private/var/run/nginx.pid --http-client-body-temp-path=/private/var/lib/nginx/body --http-fastcgi-temp-path=/private/var/lib/nginx/fastcgi --http-proxy-temp-path=/private/var/lib/nginx/proxy --http-scgi-temp-path=/private/var/lib/nginx/scgi --http-uwsgi-temp-path=/private/var/lib/nginx/uwsgi --with-luajit-inc=/usr/local/include/luajit-2.0 --with-luajit-lib=/usr/local/lib --with-ipv6 --with-mail --with-pcre-jit --with-http_ssl_module --with-http_sub_module --with-http_flv_module --with-mail_ssl_module --with-http_dav_module --with-http_xslt_module --with-http_spdy_module --with-http_realip_module --with-http_addition_module --with-http_gzip_static_module --with-http_stub_status_module --with-http_lua_module=shared --with-http_footer_filter_module=shared --with-http_sysguard_module=shared --with-http_limit_req_module=shared --with-http_trim_filter_module=shared --with-http_upstream_ip_hash_module=shared --with-http_upstream_least_conn_module=shared --with-http_upstream_session_sticky_module=shared --with-http_concat_module=shared --with-cc-opt="-Wno-deprecated-declarations"

#增加第三方模块
--add-module=/root/software/ngx_http_substitutions_filter_module

make && make install
cd ../

#编译原版NGINX
tar zxvf nginx-0.8.46.tar.gz
cd nginx-0.8.46/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module
make && make install
cd ../

ln -s /etc/nginx/sites-available/localhost.conf /etc/nginx/sites-enabled/localhost.conf 
ln -s /etc/nginx/sites-available/pma.l68.net.conf /etc/nginx/sites-enabled/pma.l68.net.conf
ln -s /etc/nginx/sites-available/leaps.l68.net.conf /etc/nginx/sites-enabled/leaps.l68.net.conf
ln -s /etc/nginx/sites-available/yuncms.l68.net.conf /etc/nginx/sites-enabled/yuncms.l68.net.conf
ln -s /etc/nginx/sites-available/tintsoft.l68.net.conf /etc/nginx/sites-enabled/tintsoft.l68.net.conf

````
##收尾工作
````shell

/usr/sbin/groupadd www
/usr/sbin/useradd -m -g www www

#设置自动启动
chkconfig nginx on
chkconfig php-fpm on

#创建网站和日志目录并赋予权限
mkdir /home/www/htdocs
mkdir /home/www/logs
chown -R www:www /home/www/htdocs
chmod -R 755 /home/www/htdocs
chown -R www:www /home/www/logs
chmod -R 755 /home/www/logs

chown root /Library/LaunchDaemons/org.php-fpm.plist

sudo launchctl load /Library/LaunchDaemons/org.php-fpm.plist
sudo launchctl load /Library/LaunchDaemons/org.nginx.plist


sudo launchctl unload /Library/LaunchDaemons/org.php-fpm.plist
sudo pkill php-fpm
sudo launchctl load /Library/LaunchDaemons/org.php-fpm.plist

sudo launchctl unload /Library/LaunchDaemons/org.nginx.plist
sudo launchctl load /Library/LaunchDaemons/org.nginx.plist






