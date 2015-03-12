#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install"
    exit 1
fi

clear
echo "========================================================================="
cur_dir=$(pwd)
# php: http://php.net/downloads.php
php_ver="php-5.6.6.tar.gz"
php_url="http://cn2.php.net/distributions/php-5.6.6.tar.gz"
# openresty: http://openresty.org/
openresty_ver="ngx_openresty-1.7.10.1.tar.gz"
openresty_url="http://openresty.org/download/ngx_openresty-1.7.10.1.tar.gz"
# pcre: http://sourceforge.net/projects/pcre/files/pcre2/
pcre_ver="pcre2-10.00.tar.gz"
pcre_url="http://sourceforge.net/projects/pcre/files/pcre2/10.00/pcre2-10.00.tar.gz/download"
# mysql: http://dev.mysql.com/get/Downloads/MySQL-5.5/mysql-5.5.25.tar.gz/from/http://mysql.llarian.net/
mysql_ver="mysql-5.6.23.tar.gz"
mysql_url="http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.23.tar.gz/from/http://mysql.llarian.net/"
# libiconv: http://ftp.gnu.org/pub/gnu/libiconv/
libiconv_ver="libiconv-1.14.tar.gz"
libiconv_url="http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz"
# libmcrypt: http://sourceforge.net/projects/mcrypt/files/Libmcrypt/
libmcrypt_ver="libmcrypt-2.5.8.tar.gz"
libmcrypt_url="http://sourceforge.net/projects/mcrypt/files/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz/download"
# memcache: http://memcached.org/
memcached_ver="memcached-1.4.22.tar.gz"
memcached_url="http://www.memcached.org/files/memcached-1.4.22.tar.gz"

#set main domain name

	domain="localhost"
	echo "Please input domain:"
	read -p "(Default domain: localhost):" domain
	if [ "$domain" = "" ]; then
		domain="localhost"
	fi
	echo "==========================="
	echo "domain=$domain"
	echo "==========================="

#set mysql root password

	mysqlrootpwd="root"
	echo "Please input the root password of mysql:"
	read -p "(Default password: root):" mysqlrootpwd
	if [ "$mysqlrootpwd" = "" ]; then
		mysqlrootpwd="root"
	fi
	echo "==========================="
	echo "mysqlrootpwd=$mysqlrootpwd"
	echo "==========================="

#do you want to install the InnoDB Storage Engine?

echo "==========================="
	echo "Press any key to start..."
	char=`get_char`

dpkg -l |grep mysql 
dpkg -P libmysqlclient15off libmysqlclient15-dev mysql-common 
dpkg -l |grep apache 
dpkg -P apache2 apache2-doc apache2-mpm-prefork apache2-utils apache2.2-common
dpkg -l |grep php 
dpkg -P php 

#Synchronization time
#rm -rf /etc/localtime
#ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

apt-get install -y ntpdate
ntpdate -u pool.ntp.org
date

#Disable SeLinux
if [ -s /etc/selinux/config ]; then
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
fi

if [ -s /etc/ld.so.conf.d/libc6-xen.conf ]; then
sed -i 's/hwcap 1 nosegneg/hwcap 0 nosegneg/g' /etc/ld.so.conf.d/libc6-xen.conf
fi

apt-get update
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker mysql-client mysql-server mysql-common php
killall apache2

apt-get update
apt-get autoremove -y
apt-get -fy install
apt-get install -y build-essential gcc g++ make cmake 
for packages in build-essential gcc g++ make automake autoconf re2c wget cron bzip2 libzip-dev libc6-dev file rcconf flex vim nano bison m4 gawk less make cpp binutils diffutils unzip tar bzip2 libbz2-dev unrar p7zip libncurses5-dev libncurses5 libtool libevent-dev libpcre3 libpcre3-dev libpcrecpp0 zlibc openssl libsasl2-dev libxml2 libxml2-dev libltdl3-dev libltdl-dev libmcrypt-dev libmysqlclient15-dev zlib1g zlib1g-dev libbz2-1.0 libbz2-dev libglib2.0-0 libglib2.0-dev libpng3 libfreetype6 libfreetype6-dev libjpeg62 libjpeg62-dev libjpeg-dev libpng-dev libpng12-0 libpng12-dev curl libcurl3 libmhash2 libmhash-dev libpq-dev libpq5 gettext libcurl4-gnutls-dev libjpeg-dev libpng12-dev libxml2-dev zlib1g-dev libfreetype6 libfreetype6-dev libssl-dev libcurl3 libcurl4-openssl-dev libcurl4-gnutls-dev mcrypt libcap-dev cmake bar python-dev python-pip libreadline-dev ;
do apt-get install -y $packages --force-yes;apt-get -fy install;apt-get -y autoremove; done

echo "============================check files=================================="
if [ -s php.tar.gz ]; then
  echo "php.tar.gz [found]"
  else
  echo "Error: php.tar.gz not found!!!download now......"
  wget -c $php_url -O php.tar.gz
fi

if [ -s pcre.tar.gz ]; then
  echo "pcre.tar.gz [found]"
  else
  echo "Error: pcre.tar.gz not found!!!download now......"
  wget -c $pcre_url -O pcre.tar.gz
fi

if [ -s openresty.tar.gz ]; then
  echo "openresty.tar.gz [found]"
  else
  echo "Error: openresty.tar.gz not found!!!download now......"
  wget -c $openresty_url -O openresty.tar.gz
fi

if [ -s mysql.tar.gz ]; then
  echo "mysql.tar.gz [found]"
  else
  echo "Error: mysql.tar.gz not found!!!download now......"
  wget -c $mysql_url -O mysql.tar.gz
fi

if [ -s libiconv.tar.gz ]; then
  echo "libiconv.tar.gz [found]"
  else
  echo "Error: libiconv.tar.gz not found!!!download now......"
  wget -c $libiconv_tar -O libiconv.tar.gz
fi

if [ -s libmcrypt.tar.gz ]; then
  echo "libmcrypt.tar.gz [found]"
  else
  echo "Error: libmcrypt.tar.gz not found!!!download now......"
  wget -c $libmcrypt_url -O libmcrypt.tar.gz
fi

if [ -s autoconf-lastest.tar.gz ]; then
  echo "autoconf-lastest.tar.gz [found]"
  else
  echo "Error: autoconf-lastest.tar.gz not found!!!download now......"
  wget -c http://ftp.gnu.org/gnu/autoconf/autoconf-latest.tar.gz
fi

if [ -s memcached.tar.gz ]; then
  echo "memcached.tar.gz [found]"
  else
  echo "Error: memcached.tar.gz not found!!!download now......"
  wget -c $memcached_url -O memcached.tar.gz
fi

echo "============================check files=================================="

cd $cur_dir

# autoconf
mkdir autoconf && tar zxvf autoconf-latest.tar.gz -C autoconf --strip-components 1
cd autoconf/
./configure --prefix=/usr/local/autoconf
make && make install
cd ../

# libiconv
cd $cur_dir
mkdir libiconv && tar zxvf libiconv.tar.gz -C libiconv --strip-components 1
cd libiconv/
./configure
make && make install
cd ../

# libmcrypt
cd $cur_dir
mkdir libmcrypt && tar zxvf libmcrypt.tar.gz -C libmcrypt --strip-components 1
cd libmcrypt/
./configure
make && make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make && make install
cd ../../

cd $cur_dir
ln -s /usr/local/lib/libmcrypt.la /usr/lib/libmcrypt.la
ln -s /usr/local/lib/libmcrypt.so /usr/lib/libmcrypt.so
ln -s /usr/local/lib/libmcrypt.so.4 /usr/lib/libmcrypt.so.4
ln -s /usr/local/lib/libmcrypt.so.4.4.8 /usr/lib/libmcrypt.so.4.4.8

if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
        ln -s /usr/lib/x86_64-linux-gnu/libpng* /usr/lib/
        ln -s /usr/lib/x86_64-linux-gnu/libjpeg* /usr/lib/
else
        ln -s /usr/lib/i386-linux-gnu/libpng* /usr/lib/
        ln -s /usr/lib/i386-linux-gnu/libjpeg* /usr/lib/
fi

ulimit -v unlimited

if [ ! `grep -l "/lib"    '/etc/ld.so.conf'` ]; then
	echo "/lib" >> /etc/ld.so.conf
fi

if [ ! `grep -l '/usr/lib'    '/etc/ld.so.conf'` ]; then
	echo "/usr/lib" >> /etc/ld.so.conf
fi

if [ -d "/usr/lib64" ] && [ ! `grep -l '/usr/lib64'    '/etc/ld.so.conf'` ]; then
	echo "/usr/lib64" >> /etc/ld.so.conf
fi

if [ ! `grep -l '/usr/local/lib'    '/etc/ld.so.conf'` ]; then
	echo "/usr/local/lib" >> /etc/ld.so.conf
fi

ldconfig

cat >>/etc/security/limits.conf<<eof
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535
eof

cat >>/etc/sysctl.conf<<eof
fs.file-max=65535
eof
echo "============================mysql install================================="
cd $cur_dir
rm /etc/my.cnf
rm /etc/mysql/my.cnf
rm -rf /etc/mysql/
apt-get remove -y mysql-server
apt-get remove -y mysql-common mysql-client

groupadd mysql
useradd -s /sbin/nologin -g mysql mysql
cd $cur_dir
mkdir mysql && tar zxvf mysql.tar.gz -C mysql --strip-components 1
cd mysql/
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/mysql/ -DSYSCONFDIR=/usr/local/mysql/etc/ -DMYSQL_DATADIR=/usr/local/mysql/data -DMYSQL_UNIX_ADDR=/tmp/mysql.sock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_READLINE=1 -DWITH_EMBEDDED_SERVER=1 -DWITH_SSL=bundled -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -LH
make
make install

chgrp -R mysql /usr/local/mysql
chown -R mysql /usr/local/mysql
cd /usr/local/mysql
install -m644 /usr/local/mysql/support-files/my-medium.cnf /etc/my.cnf
/usr/local/mysql/scripts/mysql_install_db --user=root --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data
install -m755 /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql

ln -s /usr/local/mysql/bin/mysql /usr/bin/
ln -s /usr/local/mysql/bin/mysqladmin /usr/bin/
ln -s /usr/local/mysql/bin/mysqld_safe /usr/bin/
ln -s /usr/local/mysql/bin/mysql_conf /usr/bin/
ln -s /usr/local/mysql/share/mysql/mysql.server /usr/bin/
sed -i '29i\datadir = /usr/local/mysql/data' /etc/my.cnf
#sed -i '30i\language= /usr/local/mysql/share/english' /etc/my.cnf

cat > /etc/ld.so.conf.d/mysql.conf<<EOF
/usr/local/mysql/lib
/usr/local/lib
EOF
ldconfig

chgrp -R mysql /usr/local/mysql/data
chown -R mysql /usr/local/mysql/data
/etc/init.d/mysql start
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
echo "=========================== mysql intall completed ========================"

echo "========================= php + php extensions install ==================="
cd $cur_dir
export PHP_AUTOCONF=/usr/local/autoconf/bin/autoconf
export PHP_AUTOHEADER=/usr/local/autoconf/bin/autoheader
mkdir php && tar zxvf php.tar.gz -C php --strip-components 1
cd php/
./buildconf --force > testbuildconf
if grep -q "autoconf-latest" testbuildconf; 
then 
export PHP_AUTOCONF=/usr/local/autoconf/bin/autoconf
export PHP_AUTOHEADER=/usr/local/autoconf/bin/autoheader
./buildconf --force
else 
echo "It looks like working.";
cat testbuildconf
fi
./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-magic-quotes --enable-safe-mode --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --disable-fileinfo

make ZEND_EXTRA_LIBS='-libconv'
make install

mkdir -p /usr/local/php/etc
cp php.ini-production /usr/local/php/etc/php.ini

ln -s /usr/local/php/bin/php /usr/bin/php
ln -s /usr/local/php/bin/phpize /usr/bin/phpize
ln -s /usr/local/php/sbin/php-fpm /usr/bin/php-fpm

# php extensions
sed -i 's#extension_dir = "./"#extension_dir = "/usr/local/php/lib/php/extensions/no-debug-non-zts-20060613/"\n#' /usr/local/php/etc/php.ini
sed -i 's#output_buffering = Off#output_buffering = On#' /usr/local/php/etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 50M/g' /usr/local/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = PRC/g' /usr/local/php/etc/php.ini
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/; cgi.fix_pathinfo=0/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /usr/local/php/etc/php.ini
sed -i 's/disable_functions =.*/disable_functions = passthru,exec,system,chroot,scandir,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_alter,ini_restore,dl,pfsockopen,openlog,syslog,readlink,symlink,popepassthru,stream_socket_server,fsocket,fsockopen/g' /usr/local/php/etc/php.ini

echo "Creating new php-fpm configure file......"
cat >/usr/local/php/etc/php-fpm.conf<<EOF
[global]
pid = /usr/local/php/var/run/php-fpm.pid
error_log = /usr/local/php/var/log/php-fpm.log
log_level = notice

[www]
listen = 127.0.0.1:9000
user = www
group = www
pm = dynamic
pm.max_children = 20
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
EOF

echo "Copy php-fpm init.d file......"
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
cd ../
echo "======================== php + php extensions install =================="

echo "========================== nginx install ==============================="
groupadd www
useradd -s /sbin/nologin -g www www

# nginx
cd $cur_dir
mkdir pcre && tar zxvf pcre.tar.gz -C pcre --strip-components 1
cd pcre/
./configure --prefix=/usr/local
make && make install
cd ../

ldconfig

mkdir openresty && tar zxvf openresty.tar.gz -C openresty --strip-components 1
cd openresty/
./configure --user=www --group=www --prefix=/usr/local/openresty --with-cc-opt="-I/usr/local/include" --with-ld-opt="-L/usr/local/lib" --with-pcre-jit --with-ipv6 --without-http_redis2_module --with-http_iconv_module --with-http_postgres_module -j2 
make -j2
make install

cd $cur_dir
echo "==================== openresty install completed ==========================="

echo "==================== Install Memcached start ==============================="
cd $cur_dir
mkdir memcached && tar zxvf memcached.tar.gz -C memcached --strip-components 1
cd memcached/
./configure
make
make install
echo "==================== Install Memcached complated ============================"

echo "============================add nginx and php-fpm on startup============================"
#start up
echo "Create new nginx init.d file......"
cd `dirname $0`
cp init.d.nginx /etc/init.d/nginx
cp init.d.memcached /etc/init.d/memcached
chmod +x /etc/init.d/nginx
update-rc.d -f mysql defaults
update-rc.d -f nginx defaults
update-rc.d -f php-fpm defaults
update-rc.d -f memcached defaults
cd $cur_dir
echo "===========================add nginx and php-fpm on startup completed===================="

echo "===========================startup===================="
echo "Starting NMP..."
/etc/init.d/mysql start
/etc/init.d/php-fpm start
/etc/init.d/nginx start
/etc/init.d/memcached start
echo "===========================startup completed===================="

#add 80 port to iptables
if [ -s /sbin/iptables ]; then
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables-save
fi
echo "===================================== Check install ==================================="
clear
if [ -s /usr/local/openresty ]; then
  echo "/usr/local/openresty [found]"
  else
  echo "Error: /usr/local/openrety not found!!!"
fi

if [ -s /usr/local/php ]; then
  echo "/usr/local/php [found]"
  else
  echo "Error: /usr/local/php not found!!!"
fi

if [ -s /usr/local/mysql ]; then
  echo "/usr/local/mysql [found]"
  else
  echo "Error: /usr/local/mysql not found!!!"
fi

echo "========================== Check install ================================"
if [ -s /usr/local/openresty ] && [ -s /usr/local/php ] && [ -s /usr/local/mysql ]; then

    echo "Install completed!"
    echo "default mysql root password:$mysqlrootpwd"
    #echo "phpMyAdmin : http://$domain/phpmyadmin/"
    echo "The path of some dirs:"
    echo "mysql dir:   /usr/local/mysql"
    echo "php dir:     /usr/local/php"
    echo "nginx dir:   /usr/local/nginx"
    echo "web dir :     /home/wwwroot"
    echo "port:"
    netstat -ntl
fi
echo "========================================================================="
fi
