#!/bin/bash

rm -rf .snakemake

run_one="results/timeit/run_one"
run_two="results/timeit/run_two"

mkdir -p "$run_one"
mkdir -p "$run_two"

# run one
for core in {01..12}; do
    printf "Run 1 - %02d core started" "$core"

    start=$(date +%s)
    snakemake --use-conda --cores "$core" --quiet > /dev/null 2>&1
    end=$(date +%s)
    total_time=$((end-start))

    printf " - %d seconds\n" "$total_time"
    echo "$total_time" > "$run_one/snakemake.time.core.$core"

    rm -rf temp_results

    if [[ "$core" != 12 ]]; then
        rm -rf .snakemake
    fi

done

echo ""

# run two
for core in {01..12}; do
    printf "Run 2 - %02d core started" "$core"

    start=$(date +%s)
    snakemake --use-conda --cores "$core" --quiet > /dev/null 2>&1
    end=$(date +%s)
    total_time=$((end-start))

    printf " - %d seconds\n" "$total_time"
    echo "$total_time" > "$run_two/snakemake.time.core.$core"

    rm -rf temp_results

done
