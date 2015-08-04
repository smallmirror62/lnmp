#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install lnmp"
    exit 1
fi

yum -y install patch make cmake gcc gcc-c++ gcc-g77 bison flex file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel gmp-devel gettext gettext-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers vim-minimal nano fonts-chinese gmp-devel pspell-devel unzip libcap diffutils readline-devel libxslt libxslt-devel

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


