#!/bin/bash

# ./ping.sh && ./calc.sh | sort -nr
./xping.sh 50 && ./ncalc.sh | sort -nr


# ./calc.sh | sort -nr
# ./ncalc.sh | sort -nr

# best=$(./calc.sh | sort -n | head -n 1 | sed 's/.*\///')
best=$(./ncalc.sh | sort -n | head -n 1 | sed 's/.*\///' | sed 's/_n_.*//')
echo $best
grep $best mirrors.txt
