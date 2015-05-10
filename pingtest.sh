#!/bin/bash

pingint=0.2

pingcount=10
if [ $# -ne 0 ]; then
    pingcount=$1
fi
echo 'pingcount' $pingcount

outdir=.pingout_$pingcount

get_mirrors() {
    if [ ! -f mirrors.txt ]; then
        wget http://mirrors.ubuntu.com/mirrors.txt
    else
        echo 'found mirrors.txt'
    fi

    # should have now, otherwise can't go on
    if [ ! -f mirrors.txt ]; then
        echo 'failed to get mirrors.txt'
        exit
    fi
}

do_pings() {
    rm -rf $outdir
    mkdir -p $outdir

    for m in $(cat mirrors.txt) ; do
        echo $m
        mm=$(echo $m | sed 's/http:\/\///' | sed 's/\/$//' | sed 's/\/.*//' )
        (ping -i $pingint -c $pingcount $mm > $outdir/$mm) &
    done

    echo 'wait for ping tests'
    wait
    echo 'done'
}

calc() {
    m=$pingcount
    for r in $(ls $outdir/*) ; do
        n=$(cat $r | grep 'bytes from' | sed 's/.*time=//' | wc -l)
        if [ $n -eq $m ] ; then
            sumstr=$(cat $r | grep 'bytes from' | sed 's/.*time=//' | sed 's/ms//' | paste -sd+ )
            avgstr=$( echo "($sumstr)/$n" | bc)
            echo $avgstr $r
        fi
    done
}

get_mirrors
do_pings
calc | sort -nr
best=$(calc | sort -n | head -n 1 | sed 's/.*\///')
echo $best
grep $best mirrors.txt
grep $best mirrors.txt > last-best-mirror.txt
