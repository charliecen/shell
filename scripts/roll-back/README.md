回滚脚本

脚本：roll_back.sh

1.运行脚本前查看之前的代码链接
[root@VM-249 scripts]# ansible online -m shell -a "ls -l /app/"
10.19.21.243 | success | rc=0 >>
total 0
lrwxrwxrwx 1 root root 35 Aug 27 15:06 server -> /data/deploy/20150826_181338/server
 
10.19.21.242 | success | rc=0 >>
total 0
lrwxrwxrwx 1 root root 35 Aug 27 15:06 server -> /data/deploy/20150826_181341/server



2.然后运行代码
结果在result.txt


3.最后再次查看
[root@VM-249 scripts]# ansible online -m shell -a "ls -l /app/"
10.19.21.243 | success | rc=0 >>
total 0
lrwxrwxrwx 1 root root 35 Aug 27 15:29 server -> /data/deploy/20150826_181143/server
 
10.19.21.242 | success | rc=0 >>
total 0
lrwxrwxrwx 1 root root 35 Aug 27 15:29 server -> /data/deploy/20150826_181146/server
