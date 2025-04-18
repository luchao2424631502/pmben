
for i in `seq 1 4`
do
    mem_range=$(echo "2^$i*16" | bc)

    seq_file_name="seq_write_${mem_range}G.yaml"
    seq_res_dir="seq_write_${mem_range}G_results"


    ~/pmben/perma-bench/build/perma-bench --path ~/pmben/pm/bench -c $seq_file_name -r $seq_res_dir
done

for i in `seq 1 4`
do
    mem_range=$(echo "2^$i*16" | bc)
    random_file_name="random_write_${mem_range}G.yaml"
    random_res_dir="random_write_${mem_range}G_results"

    ~/pmben/perma-bench/build/perma-bench --path ~/pmben/pm/bench -c $random_file_name -r $random_res_dir
done