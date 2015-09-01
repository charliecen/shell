#!/bin/bash
 
dir_time=$(date +%Y%m%d_%H%M%S)
release_path="/data/deploy"
 
if [ ! -d $release_path/$dir_time ];then
        mkdir -p $release_path/$dir_time
fi
 
second_last_dir=$(ls -ltc $release_path |egrep '^d'|awk 'NR==2{print $9}')
cp -rf $release_path/$second_last_dir/* $release_path/$dir_time/ && echo "Copy directory successful." || echo "Copy directory failed."
