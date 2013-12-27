#!/bin/bash
dat=$(date +%F)
tar zcvfP /var/solr_bak/solr_bak_$dat.tar.gz --exclude logs --exclude data /var/apache-tomcat-7.0.42/ &> /dev/null
if [ $? -eq 0 ];then
        echo "solr bak is successful in $dat." >> /tmp/solrbak.log
else
        echo "solr bak is not successful in $dat." >> /tmp/solrbak.log
fi
rsync -av /var/solr_bak/ 1.0.0.1::solrbak
if [ $? -eq 0 ];then
        echo "rsync to remote backup server is ok in $dat" >> /tmp/solrbak.log
else
        echo "rsync to remote backup server is failed $dat" >> /tmp/solrbak.log
fi

tail -n 2 /tmp/solrbak.log |sendEmail -u "solr_bak"  -f monitor@meihua.info -s mail.meihua.info -t charlie.cen@meihua.info -xu monitor -xp monitaA12
