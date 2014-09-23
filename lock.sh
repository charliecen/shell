#!/bin/bash
LOCKFILE=$(basename $0)_lock
echo $LOCKFILE
if [ -f $LOCKFILE ]
then
        MYPID=$(cat $LOCKFILE)
        ps -p $MYPID &> /dev/null
        [ $? -eq 0 ] && "already running" && exit 5
fi
echo $$ > $LOCKFILE
read
echo hello
rm -rf $LOCKFILE

echo finish
