#!/bin/bash
#Author: charlie.cen
#Email: cenhuqing@gmail.com
#Create_time: 2015-04-29

#定义安装的包
pkg="httpd subversion mod_dav_svn"
#定义仓库路径
repo_path=/opt/svn
#定义仓库名
read -p "Please enter your repo name: " repo
#定义日志文件
log="/tmp/install_svn.log"

#安装包
for i in ${pkg}
do
	rpm -qa |grep $i >> $log
	if [ $? -eq 0 ]
	then
		echo "$i was already installed." >> $log
	else
		yum install -y $i > /dev/null 2>&1
		echo "$i is now installed." >> $log
	fi
done


#创建仓库
if [ -e $repo_path -a -d $repo_path ]
then
	svnadmin create $repo_path/$repo && echo "$repo create successful" >> $log
else
	mkdir $repo_path && svnadmin create $repo_path/$repo && echo "$repo_path and $repo create successful." >> $log
fi

#修改svn配置
sed -i 's/^# anon-access = read/anon-access = none/' $repo_path/$repo/conf/svnserve.conf
sed -i 's/^# auth-access = write/auth-access = write/' $repo_path/$repo/conf/svnserve.conf
sed -i 's/^# password-db = passwd/password-db = passwd/' $repo_path/$repo/conf/svnserve.conf
sed -i 's/^# authz-db = authz/authz-db = authz/' $repo_path/$repo/conf/svnserve.conf
echo "svnserve conf file modify already." >> $log

#添加svn用户
echo -n "Enter your name access http svn: "
read name
echo -n "Enter your passwd access http svn: "
read passwd
	
echo "$name = $passwd" >> $repo_path/$repo/conf/passwd
echo "$name $passwd write on passwd file." >> $log
echo "admin = $name" >> $repo_path/$repo/conf/authz
echo -e  "[$repo:/]\n@admin = rw" >> $repo_path/$repo/conf/authz
echo "$name user write on authz file." >> $log

#密码文件生成httppasswd文件
#egrep -v '^#|^$|^\['  $repo_path/$repo/conf/passwd |while read line
#do
        #username=`echo $line |cut -d"=" -f1`
        #password=`echo $line |cut -d"=" -f1`
#        if [ -n p1 ] && [ -f p1 ]
#        then
#                htpasswd -b p1 ${username} ${password}
#        else
#                htpasswd -bc p1 ${username} ${password}
#        fi
#done
if [ -n $repo_path/$repo/conf/webpasswd ] && [ -f $repo_path/$repo/conf/webpasswd ]
then
	htpasswd -b $repo_path/$repo/conf/webpasswd $name $passwd
else
	htpasswd -bc $repo_path/$repo/conf/webpasswd $name $passwd
fi
echo "webpasswd file create already." >> $log


#配置apache
ip=`ifconfig eth0 |awk 'NR==2{print $2}' |awk -F: '{print $2}'`
httpd_conf="/etc/httpd/conf/httpd.conf"
grep "^ServerName $ip:80" $httpd_conf && echo "ServerName config in $httpd_conf" >> $log ||echo "ServerName $ip:80" >> $httpd_conf

http_conf="/etc/httpd/conf.d/subversion.conf"
http_dir="/etc/httpd/conf.d"
dir=`basename $repo_path`

if [ -e $http_conf -a -f $http_conf ]
then
	echo "$http_conf was exist" >> $log
	cat >> $http_conf << EOF
<Location /$dir>
DAV svn
SVNParentPath $repo_path
AuthType Basic
AuthName "Subversion repository"
AuthUserFile $repo_path/$repo/conf/webpasswd
Require valid-user
AuthzSVNAccessFile $repo_path/$repo/conf/authz
</Location>
EOF
else
	echo "$http_conf was not exist" >> $log
	cat >> $http_conf << EOF
LoadModule dav_svn_module     modules/mod_dav_svn.so
LoadModule authz_svn_module   modules/mod_authz_svn.so
<Location /$dir>
DAV svn
SVNParentPath $repo_path
AuthType Basic
AuthName "Subversion repository"
AuthUserFile $repo_path/$repo/conf/webpasswd
Require valid-user
AuthzSVNAccessFile $repo_path/$repo/conf/authz
</Location>
EOF
fi



#启动svn服务
num=`ps -ef |grep svnserve |grep -v grep |wc -l`
if [ ${num} == 1 ]
then
	pkill svnserve
else
	svnserve -d -r $repo_path && echo "svnserve service was started." >> $log || echo "svnserve  service not started." >> $log
fi

#启动httpd
/etc/init.d/httpd configtest && /etc/init.d/httpd restart || echo "httpd config file is problem." >> $log
