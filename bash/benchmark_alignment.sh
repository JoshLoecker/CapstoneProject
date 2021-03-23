# This is an adaptation of benchmark_alignment.sh to allow for multithreading


core_count=2
(
for file in "../data/input/"*; do

    if (( i % core_count == 0 )); then
        wait
    fi
    ((i++))
    start=$(date +%s)
    bash "./run_alignment.sh" "$file"
    end=$(date +%s)
    total_time=$((end-start))

    # bash "./md5Generation.sh" "$core_count"
done
)


# mkdir -p "../results/bash/timeit"
# echo "$total_time" > "../results/bash/timeit/bash.core.$core_count"
