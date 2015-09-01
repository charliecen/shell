#!/bin/bash
#Author: Charlie.cen
#Email: cenhuqing@gmail.com
#Date: 2015/08/27
 
# Check if user is root
[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && exit 1
 
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
clear
 
# Define Var
Server_pre="10.19.21.241"
Server_online="10.19.21.242 10.19.21.243"
release_path="/data/deploy"
Web_dir="/app/server"
 
while :
do
	echo "请选择回滚服务器:"
	echo -e "\t\033[32m1\033[0m. 预发布"
	echo -e "\t\033[32m2\033[0m. 线上"
	read -p "请输入你服务器的编号: " Remote_server
	if [ $Remote_server != 1 -a $Remote_server != 2 ];then
		echo -e "\033[31m 输入错误,只能输入数字: 1 , 2\033[0m"
	else
		if [ $Remote_server == 1 ];then
			echo  "请选择回滚时间:"
			ssh root@$Server_pre "ls -l $release_path" |awk '{print $9}'
			read -p "请输入回滚时间目录: " Time_dir
			echo -e "\t\033[32m 预发布241,你将回滚到$Time_dir......\033[0m"
			ssh root@10.19.21.241 "rm -rf $Web_dir;ln -s $release_path/$Time_dir/server $Web_dir" && echo  -e "\t\033[32m 预发布241,你已经回滚到$Time_dir\033[0m" || echo -e "\t\033[31m 预发布241,回滚失败,请查看原因\033[0m"
			break
		else
			echo -e "请选择回滚时间:"
			for i in ${Server_online[@]};do
				if [ $i == "10.19.21.242" ];then
					ssh root@$i "ls -l $release_path" |awk '{print $9}'
					read -p "请输入线上242回滚时间目录: " Time_dir_242
					echo -e "\t\033[32m 线上242,你将回滚到$Time_dir_242......\033[0m"
					ssh root@$i "rm -rf $Web_dir;ln -s $release_path/$Time_dir_242/server $Web_dir" && echo -e "\t\033[32m 线上242,你已经回滚到$Time_dir_242\033[0m" || echo -e "\t\033[31m 线上242回滚失败,请查看原因\033[0m"
					echo
				else
					ssh root@$i "ls -l $release_path" |awk '{print $9}'
					read -p "请输入线上243回滚时间目录: " Time_dir_243
					echo -e "\t\033[32m 线上243,你将回滚到$Time_dir_243......\033[0m"
					ssh root@$i "rm -rf $Web_dir;ln -s $release_path/$Time_dir_243/server $Web_dir" && echo -e "\t\033[32m 线上243,你已经回滚到$Time_dir_242\033[0m" || echo -e "\t\033[31m 线上243回滚失败,请查看原因\033[0m"
					echo
				fi
			done
			break
		fi
	fi
done
