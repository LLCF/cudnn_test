#!/usr/bin/bash
cuda=$1
export LD_LIBRARY_PATH=/usr/local/cuda-$cuda/lib64
cd cuda/_tests/cudnn_tests

perl cudnn_nightly.pl -config=L0 -binpath=.   2>&1 | tee L0.log
perl cudnn_nightly.pl -config=L1 -binpath=.   2>&1 | tee L1.log
python cudnn_perf.py -eris_tests -csv -binpath=. -libpath=/usr/lib/x86_64-linux-gnu 2>&1 | tee perf.log
./cudnnNegativeTest 2>&1 | tee cudnnNegativeTest.log

cp *.log  ../../../
