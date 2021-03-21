#!/bin/bash
source /Users/joshl/miniconda3/etc/profile.d/conda.sh
conda activate capstone

mkdir -p "../results/snakemake"


for core_count in {1..12}; do
    echo "Starting $core_count"
    # Time snakemake
    start=$(date +%s)
    snakemake --cores "$core_count" --quiet
    end=$(date +%s)
    total_time=$((end-start))
    mkdir -p "results/timeit"
    echo "$total_time" > "results/timeit/snakemake.core.$core_count"

    # Create md5 hashes of temp_results
    for item in "temp_results/"*; do
        folder_name=$(basename -- "$item")

        output_folder="results/md5/$folder_name"
        mkdir -p "$output_folder"

        echo "Generating MD5 of $folder_name $core_count"
        find -s "temp_results/$folder_name" -type f -exec md5 -r {} \; > "$output_folder/core.count.$core_count"
    done

    # Copy to real results
    cp -r "results/md5/" "../results/snakemake/md5"
    cp -r "results/timeit" "../results/snakemake/timeit"

    rm -rf results temp_results

    clear

done
clear
echo "Finished"
