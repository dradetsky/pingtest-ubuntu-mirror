#!/bin/bash

pingint=0.2

pingcount=4
if [ $# -ne 0 ]; then
    pingcount=$1
fi
echo 'pingcount' $pingcount

outdir=.calcout_$pingcount

get_mirrors() {
    if [ ! -f mirrors.txt ]; then
        echo "wget http://mirrors.ubuntu.com/mirrors.txt"
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

do_pings
calc | sort -nr
best=$(calc | sort -n | head -n 1 | sed 's/.*\///')
echo $best
grep $best mirrors.txt
