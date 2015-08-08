#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

clear
echo "========================================================================="
echo "LNMP V1.0 for CentOS/RadHat Linux Server, TintSoft by Licess"
echo "========================================================================="
echo "A tool to auto-compile & install Nginx+MySQL+PHP on Linux "
echo ""
echo "For more information please visit http://www.tintsoft.com/"
echo "========================================================================="
cur_dir=$(pwd)

function InitInstall()
{
	cat /etc/issue
	uname -a
	MemTotal=`free -m | grep Mem | awk '{print  $2}'`  
	echo -e "\n Memory is: ${MemTotal} MB "
	#Set timezone
	rm -rf /etc/localtime
	ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

	yum install -y ntp
	ntpdate -u pool.ntp.org
	date

	rpm -qa|grep httpd
	rpm -e httpd
	rpm -qa|grep mysql
	rpm -e mysql
	rpm -qa|grep php
	rpm -e php

	yum -y remove httpd*
	yum -y remove php*
	yum -y remove mysql-server mysql mysql-libs
	yum -y remove php-mysql

	yum -y install yum-fastestmirror
	yum -y remove httpd
	#yum -y update

	#Disable SeLinux
	if [ -s /etc/selinux/config ]; then
	sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
	fi

	cp /etc/yum.conf /etc/yum.conf.lnmp
	sed -i 's:exclude=.*:exclude=:g' /etc/yum.conf

	for packages in patch make cmake gcc gcc-c++ gcc-g77 bison flex file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel gmp-devel gettext gettext-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers vim-minimal nano fonts-chinese gmp-devel pspell-devel unzip libcap diffutils readline-devel libxslt libxslt-devel
	do yum -y install $packages; done

	#yum -y install patch make cmake gcc gcc-c++ gcc-g77 bison flex file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel gmp-devel gettext gettext-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers vim-minimal nano fonts-chinese gmp-devel pspell-devel unzip libcap diffutils readline-devel libxslt libxslt-devel


}
function CheckAndDownloadFiles()
{
	echo "============================check files=================================="
if [ -s libiconv-1.14.tar.gz ]; then
  echo "libiconv-1.14.tar.gz [found]"
  else
  echo "Error: libiconv-1.14.tar.gz not found!!!download now......"
  http://7xk96f.com1.z0.glb.clouddn.com/software/libiconv/libiconv-1.14.tar.gz
fi

if [ -s libmcrypt-2.5.8.tar.gz ]; then
  echo "libmcrypt-2.5.8.tar.gz [found]"
  else
  echo "Error: libmcrypt-2.5.8.tar.gz not found!!!download now......"
  wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/mcrypt/libmcrypt-2.5.8.tar.gz
fi

if [ -s mhash-0.9.9.9.tar.gz ]; then
  echo "mhash-0.9.9.9.tar.gz [found]"
  else
  echo "Error: mhash-0.9.9.9.tar.gz not found!!!download now......"
  wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/mhash/mhash-0.9.9.9.tar.gz
fi

if [ -s mcrypt-2.6.8.tar.gz ]; then
  echo "mcrypt-2.6.8.tar.gz [found]"
  else
  echo "Error: mcrypt-2.6.8.tar.gz not found!!!download now......"
  wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/mcrypt/mcrypt-2.6.8.tar.gz
fi

}

function InstallDependsAndOpt()
{
cd $cur_dir

tar zxvf libiconv-1.14.tar.gz
cd libiconv-1.14/
./configure
make && make install
cd ../

cd $cur_dir
tar zxf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8/
./configure
make && make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make && make install
cd ../../

cd $cur_dir
tar zxf mhash-0.9.9.9.tar.gz
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

cd $cur_dir
tar zxf mcrypt-2.6.8.tar.gz
cd mcrypt-2.6.8/
./configure
make && make install
cd ../

}

mkdir -p software
cd software

wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/php/php-5.6.12.tar.gz

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

#


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


/usr/sbin/groupadd www
/usr/sbin/useradd -m -g www www

tar zxf php-5.6.12.tar.gz
cd php-5.6.12/
./configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --sysconfdir=/etc --with-config-file-path=/etc --with-config-file-scan-dir=/etc/php --with-libxml-dir --with-openssl --with-kerberos --with-zlib --enable-bcmath --with-bz2 --enable-calendar --with-curl --enable-exif --enable-fpm --enable-ftp --with-png-dir --with-gd --with-jpeg-dir --enable-gd-native-ttf --with-icu-dir --enable-mbstring --enable-mbregex --enable-shmop --enable-soap --enable-sockets --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-wddx --with-xmlrpc --with-readline --with-iconv-dir --with-xsl --enable-zip --with-pcre-regex --with-freetype-dir --enable-xml --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pdo-sqlite --with-sqlite3 --disable-rpath  --enable-inline-optimization --with-mcrypt  --with-mhash --enable-pcntl --enable-sockets  --without-pear --with-gettext --enable-fileinfo --enable-opcache --enable-cli
make ZEND_EXTRA_LIBS='-liconv'
make install

cp php.ini-production /etc/php.ini
cp /etc/php-fpm.conf.default /etc/php-fpm.conf
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm

tar zxf tengine-2.1.0.tar.gz
cd tengine-2.1.0
./configure --prefix=/usr --sbin-path=/usr/sbin --dso-path=/usr/lib/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/var/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-luajit-inc=/usr/local/include/luajit-2.0 --with-luajit-lib=/usr/local/lib --with-ipv6 --with-mail --with-pcre-jit --with-http_ssl_module --with-http_sub_module  --with-mail_ssl_module --with-http_dav_module --with-http_xslt_module --with-http_spdy_module --with-http_realip_module --with-http_addition_module --with-http_gzip_static_module --with-http_stub_status_module --with-http_image_filter_module --with-http_lua_module=shared --with-http_footer_filter_module=shared --with-http_sysguard_module=shared --with-http_limit_req_module=shared --with-http_trim_filter_module=shared --with-http_upstream_ip_hash_module=shared --with-http_upstream_least_conn_module=shared --with-http_upstream_session_sticky_module=shared --with-http_concat_module=shared 

make && make install
cd ../

mkdir /var/lib/nginx
mkdir /var/log/nginx

cp nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx

chkconfig nginx on
chkconfig php-fpm on


tar zxf mysql-5.6.26.tar.gz
cd mysql-5.6.26
cmake -DCMAKE_INSTALL_PREFIX=/usr -DMYSQL_DATADIR=/var/lib/mysql/data -DSYSCONFDIR=/etc DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DWITH_SSL=system -DWITH_ZLIB=system -DWITH_EMBEDDED_SERVER=1 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci

make && make install

groupadd mysql
useradd -s /sbin/nologin -M -g mysql mysql

cp support-files/my-medium.cnf /etc/my.cnf
/usr/local/mysql/scripts/mysql_install_db --defaults-file=/etc/my.cnf --basedir=/usr/local/mysql --datadir=/usr/local/mysql/var --user=mysql
chown -R mysql /usr/local/mysql/var
chgrp -R mysql /usr/local/mysql/.
cp support-files/mysql.server /etc/init.d/mysql
chmod 755 /etc/init.d/mysql

#Centos 7
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=3306/tcp --permanent
firewall-cmd --zone=public --add-port=21/tcp --permanent
firewall-cmd --reload