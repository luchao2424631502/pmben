#!/bin/bash

main_script="viz/main.py"

cd ../

for i in `seq 1 4`
do
    mem_range=$(echo "2^$i*16"|bc)

    res_dir="./build/seq_write_${mem_range}G_results"
    fig_dir="./build/seq_write_${mem_range}G_fig"
 
    python3 $main_script $res_dir $fig_dir
done

for i in `seq 1 4`
do
    mem_range=$(echo "2^$i*16"|bc)

    res_dir="build/random_write_${mem_range}G_results"
    fig_dir="build/random_write_${mem_range}G_fig"

    python3 $main_script $res_dir $fig_dir
done