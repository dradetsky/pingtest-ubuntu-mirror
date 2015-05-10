#!/bin/bash

pingcount=4
if [ $# -ne 0 ]; then
    pingcount=$1
fi
echo 'pingcount' $pingcount

mkdir -p .calcout
for m in $(cat mirrors.txt) ; do
    echo $m
    mm=$(echo $m | sed 's/http:\/\///' | sed 's/\/$//' | sed 's/\/.*//' )
    (ping -c $pingcount $mm >.calcout/$mm) &
done

echo 'wait for ping tests'
wait
echo 'done'
