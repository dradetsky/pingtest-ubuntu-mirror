#!/bin/bash

pingcount=4
if [ $# -ne 0 ]; then
    pingcount=$1
fi
echo 'pingcount' $pingcount

outdir=.calcout2
rm -rf $outdir
mkdir -p $outdir
for m in $(cat mirrors.txt) ; do
    echo $m
    mm=$(echo $m | sed 's/http:\/\///' | sed 's/\/$//' | sed 's/\/.*//' )
    (ping -c $pingcount $mm > $outdir/${mm}_n_$pingcount) &
done

echo 'wait for ping tests'
wait
echo 'done'
