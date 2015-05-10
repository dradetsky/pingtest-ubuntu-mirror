#!/bin/bash
# for m in $(cat mirrors.txt | sed 's/http:\/\///' | sed 's/\/$//') ; do
# for m in $(cat mirrors.txt | sed 's/http:\/\///' | sed 's/\/$//' | sed 's/\/.*//' ) ; do
for m in $(cat mirrors.txt) ; do
    echo $m
    mm=$(echo $m | sed 's/http:\/\///' | sed 's/\/$//' | sed 's/\/.*//' )
    # echo $mm
    # ping -c 4 -q $m &
    ping -c 4 -q $mm
done
