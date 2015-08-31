#!/bin/bash
#Author: Charlie.cen
#Email: cenhuqing@gmail.com
#Date: 2015/08/25

# Check if user is root
[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && exit 1

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
clear

svn_user="charlie"
svn_pass="charlie_pwd"
checkout_path="/home/deploy/checkout"
release_path="/app/deploy"
svn_url="svn://localhost/server"
log="/var/log/apr_v1.log"
time_dir=`date +%Y%m%d_%H%M%S`

#Define checkout directory
if [ ! -d $checkout_path/$time_dir ];then
	mkdir -p $checkout_path/$time_dir
fi

#Chiose your svn project
while :
do
	echo
	echo "请选择你要打包的项目:"
	#echo "Please select your zip project:"
	echo -e "\t\033[32m1\033[0m.  admin"
	echo -e "\t\033[32m2\033[0m.  baiaimama"
	echo -e "\t\033[32m3\033[0m.  bi"
	echo -e "\t\033[32m4\033[0m.  html5"
	echo -e "\t\033[32m5\033[0m.  integration"
	echo -e "\t\033[32m6\033[0m.  school"
	echo -e "\t\033[32m7\033[0m.  site"
	echo -e "\t\033[32m8\033[0m.  server(全部)"
	#read -p "Please enter a number:" Num
	read -p "请输入你要打包的编号:" Num
	if [ $Num != 1 -a $Num != 2 -a $Num != 3 -a $Num != 4 -a $Num != 5 -a $Num != 6 -a $Num != 7 -a $Num != 8 ];then
		echo -e "\033[31m 输入错误,只能输入数字: 1,2,3,4,5,6,7,8\033[0m"
		#echo -e "\033[31minput error! Please only input number 1,2,3,4,5,6,7,8\033[0m"
	else
		if [ $Num == 1 ];then
			project=admin
			echo
			echo -e "\t\033[32m 正在打包 $project ...... \033[0m"
			echo
			svn export --non-interactive --trust-server-cert  --username $svn_user --password $svn_pass $svn_url/$project $checkout_path/$time_dir/$project > /dev/null && echo -e "\t\033[32m $project 打包成功 \033[0m" || echo "\t\033[31m $project 打包失败 \033[0m"
			echo
			break
		elif [ $Num == 2 ];then
			project=baiaimama
			echo
			echo -e "\t\033[32m 正在打包 $project ...... \033[0m"
			echo
			svn export --non-interactive --trust-server-cert  --username $svn_user --password $svn_pass $svn_url/$project $checkout_path/$time_dir/$project  > /dev/null && echo -e "\t\033[32m $project 打包成功 \033[0m" || echo "\t\033[31m $project 打包失败 \033[0m"
                        echo
			break
		elif [ $Num == 3 ];then
			project=bi
			echo
                        echo -e "\t\033[32m 正在打包 $project ...... \033[0m"
                        echo
			svn export --non-interactive --trust-server-cert  --username $svn_user --password $svn_pass $svn_url/$project $checkout_path/$time_dir/$project  > /dev/null && echo -e "\t\033[32m $project 打包成功 \033[0m" || echo "\t\033[31m $project 打包失败 \033[0m"
                        echo
			break
		elif [ $Num == 4 ];then
			project=html5
			echo
                        echo -e "\t\033[32m 正在打包 $project ...... \033[0m"
                        echo
                        svn export --non-interactive --trust-server-cert  --username $svn_user --password $svn_pass $svn_url/$project $checkout_path/$time_dir/$project > /dev/null && echo -e "\t\033[32m $project 打包成功 \033[0m" || echo "\t\033[31m $project 打包失败 \033[0m"
                        echo
			break
		elif [ $Num == 5 ];then
			project=integration
			echo
                        echo -e "\t\033[32m 正在打包 $project ...... \033[0m"
                        echo
                        svn export --non-interactive --trust-server-cert  --username $svn_user --password $svn_pass $svn_url/$project $checkout_path/$time_dir/$project > /dev/null && echo -e "\t\033[32m $project 打包成功 \033[0m" || echo "\t\033[31m $project 打包失败 \033[0m"
                        echo
			break
		elif [ $Num == 6 ];then
			project=school
			echo
                        echo -e "\t\033[32m 正在打包 $project ...... \033[0m"
                        echo
                        svn export --non-interactive --trust-server-cert  --username $svn_user --password $svn_pass $svn_url/$project $checkout_path/$time_dir/$project > /dev/null && echo -e "\t\033[32m $project 打包成功 \033[0m" || echo "\t\033[31m $project 打包失败 \033[0m"
                        echo
			break
		elif [ $Num == 7 ];then
			project=site
			echo
                        echo -e "\t\033[32m 正在打包 $project ...... \033[0m"
                        echo
                        svn export --non-interactive --trust-server-cert  --username $svn_user --password $svn_pass $svn_url/$project $checkout_path/$time_dir/$project > /dev/null && echo -e "\t\033[32m $project 打包成功 \033[0m" || echo "\t\033[31m $project 打包失败 \033[0m"
                        echo
			break
		elif [ $Num == 8 ];then
			project=server
			echo
                        echo -e "\t\033[32m 正在打包 $project ...... \033[0m"
                        echo
                        svn export --non-interactive --trust-server-cert  --username $svn_user --password $svn_pass $svn_url $checkout_path/$time_dir/$project > /dev/null && echo -e "\t\033[32m $project 打包成功 \033[0m" || echo "\t\033[31m $project 打包失败 \033[0m"
                        echo
			break
		else
			echo -e "\t\033[31m $project 打包失败 \033[0m" 
			break
		fi
	fi	
done


IP_249="10.19.21.249"
#Server_pre="10.19.21.241"
Server_pre="115.29.199.174"
Server_online="10.19.21.242 10.19.21.243"
Web_dir="/app/server"

#Choise Remote Server
while :
do	
	#echo "Please select rsync to server"
	echo "请选择要发布的到哪台服务器:"
	echo -e "\t\033[32m1\033[0m. 预发布"
        echo -e "\t\033[32m2\033[0m. 线上"
	#read -p "Please enter a number:" Remote_server
	read -p "请输入发布到服务器的编号:" Remote_server
	if [ $Remote_server != 1 -a $Remote_server != 2 ];then
		echo -e "\033[31m 输入错误,只能输入数字: 1,2 \033[0m"
		#echo -e "\033[31minput error! Please only input number 1,2 \033[0m"
	else
		if [ $Remote_server == 1 ];then
			echo
			echo -e "\t\033[32m 正在同步文件到预发布...... \033[0m"
			echo
			ansible pre -m copy -a "src=mk_dir_v1.sh dest=/usr/local/scripts/ mode=755"  >> $log || exit 1
			ansible pre -m shell -a "source /usr/local/scripts/mk_dir_v1.sh" >> $log  || exit 1
			last_dir=$(ssh root@$Server_pre "ls -ltr $release_path |tail -n 1" |awk '{print $9}')
			rsync -rlpgoDut --exclude-from=/opt/exclude.txt $checkout_path/$time_dir/$project root@$Server_pre:$release_path/$last_dir/server && echo -e  "\t\033[32m 同步到预发布成功\033[0m" || echo -e "\t\033[31m 同步到预发布失败. \033[0m"
			echo
			ssh root@$Server_pre "rm -f $Web_dir;ln -s $release_path/$last_dir/server $Web_dir" && echo -e "\t\033[32m 预发布发布成功 \033[0m" || echo -e "\t\033[31m 预发布发布失败\033[0m"
			break
		else
			echo
			echo -e "\t\033[32m 正在同步到线上...... \033[0m"
                        echo
			ansible online -m copy -a "src=mk_dir_v1.sh dest=/usr/local/scripts/ mode=755"  >> $log || exit 1
			ansible online -m shell -a "source /usr/local/scripts/mk_dir_v1.sh" >> $log || exit 1
			for i in ${Server_online[@]};do
				if [ $i == "10.19.21.242" ];then
					last_dir_242=$(ssh root@$i "ls -ltr $release_path |tail -n 1" |awk '{print $9}')
					rsync -rlpgoDut --exclude-from=/opt/exclude.txt $checkout_path/$time_dir/$project root@$i:$release_path/$last_dir_242/server && echo -e "\t\033[32m 同步到线上242成功 \033[0m" || echo -e "\t\033[31m 同步到线上242失败  \033[0m"
					echo
					ssh root@$i "rm -f $Web_dir;ln -s $release_path/$last_dir_242/server $Web_dir" && echo -e "\t\033[32m 线上242发布成功 \033[0m" || echo -e "\t\033[31m 线上242发布失败  \033[0m"
					echo
				else
					last_dir_243=$(ssh root@$i "ls -ltr /data/deploy |tail -n 1" |awk '{print $9}')
					rsync -rlpgoDut --exclude-from=/opt/exclude.txt $checkout_path/$time_dir/$project root@$i:$release_path/$last_dir_243/server && echo -e "\t\033[32m 同步到线上243成功 \033[0m" || echo -e "\t\033[31m 同步到线上243失败 \033[0m"
					echo
					ssh root@$i "rm -f $Web_dir;ln -s $release_path/$last_dir_242/server $Web_dir" &&  echo -e "\t\033[32m 线上243发布成功 \033[0m" || echo -e "\t\033[31m 线上243发布失败  \033[0m"
					echo
				fi
				echo
			done
			break
		fi
	fi
done


