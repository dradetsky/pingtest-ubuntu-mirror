#!/bin/bash

# for r in $(ls .calcout/*) ; do
# for r in $(echo '') ; do
#     echo $r
#     # a=$(cat $r | grep 'bytes from' | sed 's/.*time=//')
#     n=$(cat $r | grep 'bytes from' | sed 's/.*time=//' | wc -l)
#     echo $n
#     # gives full
#     # cat $r | grep 'bytes from' | sed 's/.*time=//' | sed 's/ms//'
#     # gives rounded off floats
#     # cat $r | grep 'bytes from' | sed 's/.*time=//' | sed 's/\..*//'

#     # cat $r | grep 'bytes from' | sed 's/.*time=//' | sed 's/\..*//' | xargs
    
    
#     # cat $r | grep 'bytes from' | sed 's/.*time=//' | sed 's/\..*//' | xargs |
#     #     awk '{total = total + $0}END{print total}'

#     sumstr=$(cat $r | grep 'bytes from' | sed 's/.*time=//' | sed 's/ms//' | paste -sd+ )
#     echo $sumstr | bc
#     echo "($sumstr)/$n" | bc
# done

# proper version

outdir=.calcout2
m=$(ls $outdir | head -n 1 | sed 's/.*_n_//')

for r in $(ls $outdir/*) ; do
    n=$(cat $r | grep 'bytes from' | sed 's/.*time=//' | wc -l)
    # if [ $n -ne 0 ] ; then
    if [ $n -eq $m ] ; then
        sumstr=$(cat $r | grep 'bytes from' | sed 's/.*time=//' | sed 's/ms//' | paste -sd+ )
        # avgstr=$( echo "($sumstr)/$n" | bc -l)
        avgstr=$( echo "($sumstr)/$n" | bc)
        echo $avgstr $r
    fi
done
