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

if [ "$1" != "--help" ]; then

	get_char()
	{
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
	stty echo
	stty $SAVEDSTTY
	}
	echo ""
	echo "Press any key to start..."
	char=`get_char`

#Set timezone
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

yum install -y ntp
ntpdate -u pool.ntp.org
date

rpm -qa|grep  httpd
rpm -e httpd
rpm -qa|grep mysql
rpm -e mysql
rpm -qa|grep php
rpm -e php

yum -y remove httpd*
yum -y remove php*
yum -y remove mysql-server mysql
yum -y remove php-mysql

yum -y install yum-fastestmirror
yum -y remove httpd
#yum -y update

#Disable SeLinux
if [ -s /etc/selinux/config ]; then
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
fi
for packages in patch make cmake gcc gcc-c++ gcc-g77 bison flex file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel gmp-devel gettext gettext-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers vim-minimal nano fonts-chinese gmp-devel pspell-devel unzip libcap diffutils readline-devel libxslt libxslt-devel
do yum -y install $packages; done

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

if [ -s p.tar.gz ]; then
  echo "phpinfo.tar.gz [found]"
  else
  echo "Error: p.tar.gz not found!!!download now......"
  wget -c wget -c http://7xk96f.com1.z0.glb.clouddn.com/software/php/phpinfo.tar.gz
fi

echo "============================check files=================================="

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
/sbin/ldconfig
./configure
make && make install
cd ../



function InstallMySQL55()
{
echo "============================Install MySQL 5.5.26=================================="
cd $cur_dir
rm -f /etc/my.cnf
tar zxvf mysql-5.5.28.tar.gz
cd mysql-5.5.28/
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_READLINE=1 -DWITH_SSL=system -DWITH_ZLIB=system -DWITH_EMBEDDED_SERVER=1 -DENABLED_LOCAL_INFILE=1
make && make install

groupadd mysql
useradd -s /sbin/nologin -M -g mysql mysql

cp support-files/my-medium.cnf /etc/my.cnf
sed '/skip-external-locking/i\datadir = /usr/local/mysql/var' -i /etc/my.cnf
if [ $installinnodb = "y" ]; then
sed -i 's:#innodb:innodb:g' /etc/my.cnf
sed -i 's:/usr/local/mysql/data:/usr/local/mysql/var:g' /etc/my.cnf
else
sed '/skip-external-locking/i\default-storage-engine=MyISAM\nloose-skip-innodb' -i /etc/my.cnf
fi

/usr/local/mysql/scripts/mysql_install_db --defaults-file=/etc/my.cnf --basedir=/usr/local/mysql --datadir=/usr/local/mysql/var --user=mysql
chown -R mysql /usr/local/mysql/var
chgrp -R mysql /usr/local/mysql/.
cp support-files/mysql.server /etc/init.d/mysql
chmod 755 /etc/init.d/mysql

cat > /etc/ld.so.conf.d/mysql.conf<<EOF
/usr/local/mysql/lib
/usr/local/lib
EOF
ldconfig

ln -s /usr/local/mysql/lib/mysql /usr/lib/mysql
ln -s /usr/local/mysql/include/mysql /usr/include/mysql
if [ -d "/proc/vz" ];then
ulimit -s unlimited
fi
/etc/init.d/mysql start

ln -s /usr/local/mysql/bin/mysql /usr/bin/mysql
ln -s /usr/local/mysql/bin/mysqldump /usr/bin/mysqldump
ln -s /usr/local/mysql/bin/myisamchk /usr/bin/myisamchk
ln -s /usr/local/mysql/bin/mysqld_safe /usr/bin/mysqld_safe

/usr/local/mysql/bin/mysqladmin -u root password $mysqlrootpwd

cat > /tmp/mysql_sec_script<<EOF
use mysql;
update user set password=password('$mysqlrootpwd') where user='root';
delete from user where not (user='root') ;
delete from user where user='root' and password=''; 
drop database test;
DROP USER ''@'%';
flush privileges;
EOF

/usr/local/mysql/bin/mysql -u root -p$mysqlrootpwd -h localhost < /tmp/mysql_sec_script

rm -f /tmp/mysql_sec_script

/etc/init.d/mysql restart
/etc/init.d/mysql stop
echo "============================MySQL 5.5.26 install completed========================="
}

function InstallPHP53()
{
echo "============================Install PHP 5.3.17================================"
cd $cur_dir
export PHP_AUTOCONF=/usr/local/autoconf-2.13/bin/autoconf
export PHP_AUTOHEADER=/usr/local/autoconf-2.13/bin/autoheader
tar zxvf php-5.3.17.tar.gz
cd php-5.3.17/
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --disable-fileinfo

make ZEND_EXTRA_LIBS='-liconv'
make install

rm -f /usr/bin/php
ln -s /usr/local/php/bin/php /usr/bin/php
ln -s /usr/local/php/bin/phpize /usr/bin/phpize
ln -s /usr/local/php/sbin/php-fpm /usr/bin/php-fpm

echo "Copy new php configure file."
mkdir -p /usr/local/php/etc
cp php.ini-production /usr/local/php/etc/php.ini

cd $cur_dir
# php extensions
echo "Modify php.ini......"
sed -i 's/post_max_size = 8M/post_max_size = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /usr/local/php/etc/php.ini
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=0/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /usr/local/php/etc/php.ini
sed -i 's/register_long_arrays = On/;register_long_arrays = On/g' /usr/local/php/etc/php.ini
sed -i 's/magic_quotes_gpc = On/;magic_quotes_gpc = On/g' /usr/local/php/etc/php.ini
sed -i 's/disable_functions =.*/disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_restore,dl,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server/g' /usr/local/php/etc/php.ini

echo "Install ZendGuardLoader for PHP 5.3"
if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
	wget -c http://downloads.zend.com/guard/5.5.0/ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz
	tar zxvf ZendGuardLoader-php-5.3-linux-glibc23-x86_64.tar.gz
	mkdir -p /usr/local/zend/
	cp ZendGuardLoader-php-5.3-linux-glibc23-x86_64/php-5.3.x/ZendGuardLoader.so /usr/local/zend/
else
	wget -c http://downloads.zend.com/guard/5.5.0/ZendGuardLoader-php-5.3-linux-glibc23-i386.tar.gz
	tar zxvf ZendGuardLoader-php-5.3-linux-glibc23-i386.tar.gz
	mkdir -p /usr/local/zend/
	cp ZendGuardLoader-php-5.3-linux-glibc23-i386/php-5.3.x/ZendGuardLoader.so /usr/local/zend/
fi

echo "Write ZendGuardLoader to php.ini......"
cat >>/usr/local/php/etc/php.ini<<EOF
;eaccelerator

;ionCube

[Zend Optimizer] 
zend_extension=/usr/local/zend/ZendGuardLoader.so
EOF

echo "Creating new php-fpm configure file......"
cat >/usr/local/php/etc/php-fpm.conf<<EOF
[global]
pid = /usr/local/php/var/run/php-fpm.pid
error_log = /usr/local/php/var/log/php-fpm.log
log_level = notice

[www]
listen = /tmp/php-cgi.sock
user = www
group = www
pm = dynamic
pm.max_children = 10
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 6
request_terminate_timeout = 100
EOF

echo "Copy php-fpm init.d file......"
cp $cur_dir/php-5.3.17/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm

cp $cur_dir/lnmp /root/lnmp
chmod +x /root/lnmp
sed -i 's:/usr/local/php/logs:/usr/local/php/var/run:g' /root/lnmp
echo "============================PHP 5.3.17 install completed======================"
}

function InstallNginx()
{
echo "============================Install Nginx================================="
groupadd www
useradd -s /sbin/nologin -g www www
cd $cur_dir
tar zxvf pcre-8.12.tar.gz
cd pcre-8.12/
./configure
make && make install
cd ../

ldconfig

tar zxvf nginx-1.2.7.tar.gz
cd nginx-1.2.7/
./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-ipv6
make && make install
cd ../

ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx

rm -f /usr/local/nginx/conf/nginx.conf
cd $cur_dir
cp conf/nginx.conf /usr/local/nginx/conf/nginx.conf
cp conf/dabr.conf /usr/local/nginx/conf/dabr.conf
cp conf/discuz.conf /usr/local/nginx/conf/discuz.conf
cp conf/sablog.conf /usr/local/nginx/conf/sablog.conf
cp conf/typecho.conf /usr/local/nginx/conf/typecho.conf
cp conf/wordpress.conf /usr/local/nginx/conf/wordpress.conf
cp conf/discuzx.conf /usr/local/nginx/conf/discuzx.conf
cp conf/none.conf /usr/local/nginx/conf/none.conf
cp conf/wp2.conf /usr/local/nginx/conf/wp2.conf
cp conf/phpwind.conf /usr/local/nginx/conf/phpwind.conf
cp conf/shopex.conf /usr/local/nginx/conf/shopex.conf
cp conf/dedecms.conf /usr/local/nginx/conf/dedecms.conf
cp conf/drupal.conf /usr/local/nginx/conf/drupal.conf
cp conf/ecshop.conf /usr/local/nginx/conf/ecshop.conf

rm -f /usr/local/nginx/conf/fcgi.conf
cp conf/fcgi.conf /usr/local/nginx/conf/fcgi.conf

cd $cur_dir
cp vhost.sh /root/vhost.sh
chmod +x /root/vhost.sh

mkdir -p /home/wwwroot/default
chmod +w /home/wwwroot/default
mkdir -p /home/wwwlogs
chmod 777 /home/wwwlogs

chown -R www:www /home/wwwroot/default
}

function CreatPHPTools()
{
	echo "Create PHP Info Tool..."
cat >/home/wwwroot/default/phpinfo.php<<eof
<?
phpinfo();
?>
eof

echo "Copy PHP Prober..."
cd $cur_dir
tar zxvf p.tar.gz
cp p.php /home/wwwroot/default/p.php

cp conf/index.html /home/wwwroot/default/index.html
echo "============================Install PHPMyAdmin================================="
tar zxf phpmyadmin-latest.tar.gz
mv phpMyAdmin-3.4.8-all-languages /home/wwwroot/default/phpmyadmin/
cp conf/config.inc.php /home/wwwroot/default/phpmyadmin/config.inc.php
sed -i 's/LNMPORG/LNMP.org'$RANDOM'VPSer.net/g' /home/wwwroot/default/phpmyadmin/config.inc.php
mkdir /home/wwwroot/default/phpmyadmin/upload/
mkdir /home/wwwroot/default/phpmyadmin/save/
chmod 755 -R /home/wwwroot/default/phpmyadmin/
chown www:www -R /home/wwwroot/default/phpmyadmin/
echo "============================phpMyAdmin install completed================================="
}

function AddAndStartup()
{
echo "============================add nginx and php-fpm on startup============================"
echo "Download new nginx init.d file......"
wget -c http://soft.vpser.net/lnmp/ext/init.d.nginx
cp init.d.nginx /etc/init.d/nginx
chmod +x /etc/init.d/nginx

chkconfig --level 345 php-fpm on
chkconfig --level 345 nginx on
chkconfig --level 345 mysql on
echo "===========================add nginx and php-fpm on startup completed===================="
echo "Starting LNMP..."
/etc/init.d/mysql start
/etc/init.d/php-fpm start
/etc/init.d/nginx start

#add 80 port to iptables
if [ -s /sbin/iptables ]; then
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables-save
fi
}

function CheckInstall()
{
echo "===================================== Check install ==================================="
clear
isnginx=""
ismysql=""
isphp=""
echo "Checking..."
if [ -s /usr/local/nginx ] && [ -s /usr/local/nginx/sbin/nginx ]; then
  echo "Nginx: OK"
  isnginx="ok"
  else
  echo "Error: /usr/local/nginx not found!!!Nginx install failed."
fi

if [ -s /usr/local/php/sbin/php-fpm ] && [ -s /usr/local/php/etc/php.ini ] && [ -s /usr/local/php/bin/php ]; then
  echo "PHP: OK"
  echo "PHP-FPM: OK"
  isphp="ok"
  else
  echo "Error: /usr/local/php not found!!!PHP install failed."
fi

if [ -s /usr/local/mysql ] && [ -s /usr/local/mysql/bin/mysql ]; then
  echo "MySQL: OK"
  ismysql="ok"
  else
  echo "Error: /usr/local/mysql not found!!!MySQL install failed."
fi
if [ "$isnginx" = "ok" ] && [ "$ismysql" = "ok" ] && [ "$isphp" = "ok" ]; then
echo "Install lnmp 1.0 completed! enjoy it."
echo "========================================================================="
echo "LNMP V1.0 for CentOS/RadHat Linux VPS  Written by Licess "
echo "========================================================================="
echo ""
echo "For more information please visit http://www.lnmp.org/"
echo ""
echo "lnmp status manage: /root/lnmp {start|stop|reload|restart|kill|status}"
echo "default mysql root password:$mysqlrootpwd"
echo "phpinfo : http://yourIP/phpinfo.php"
echo "phpMyAdmin : http://yourIP/phpmyadmin/"
echo "Prober : http://yourIP/p.php"
echo "Add VirtualHost : /root/vhost.sh"
echo ""
echo "The path of some dirs:"
echo "mysql dir:   /usr/local/mysql"
echo "php dir:     /usr/local/php"
echo "nginx dir:   /usr/local/nginx"
echo "web dir :     /home/wwwroot/default"
echo ""
echo "========================================================================="
/root/lnmp status
netstat -ntl
else
echo "Sorry,Failed to install LNMP!"
echo "Please visit http://bbs.vpser.net/forum-25-1.html feedback errors and logs."
echo "You can download /root/lnmp-install.log from your server,and upload lnmp-install.log to LNMP Forum."
fi
}

InitInstall 2>&1 | tee /root/lnmp-install.log
CheckAndDownloadFiles 2>&1 | tee -a /root/lnmp-install.log
InstallDependsAndOpt 2>&1 | tee -a /root/lnmp-install.log
if [ "$isinstallmysql55" = "n" ]; then
	InstallMySQL51 2>&1 | tee -a /root/lnmp-install.log
else
	InstallMySQL55 2>&1 | tee -a /root/lnmp-install.log
fi
if [ "$isinstallphp53" = "n" ]; then
	InstallPHP52 2>&1 | tee -a /root/lnmp-install.log
else
	InstallPHP53 2>&1 | tee -a /root/lnmp-install.log
fi
InstallNginx 2>&1 | tee -a /root/lnmp-install.log
CreatPHPTools 2>&1 | tee -a /root/lnmp-install.log
AddAndStartup 2>&1 | tee -a /root/lnmp-install.log
CheckInstall 2>&1 | tee -a /root/lnmp-install.log


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