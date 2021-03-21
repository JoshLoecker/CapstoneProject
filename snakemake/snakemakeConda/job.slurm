#!/bin/bash

cores=$1

#SBATCH --job-name="snakemake.$cores"
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n $cores
#SBATCH -t 00:10:00
#SBATCH -o "slurm/$core.output"
#SBATCH -e "slurm/$core.output"
#SBATCH	--open-mode "append"

echo "Cores $cores"

# source ~/.bashrc
# conda activate ~/scratch/joshl/conda-envs/snakemake
#
# temp_dir="temp_$cores"
# mkdir -p "$temp_dir"
#
# cp Snakefile "$temp_dir"
# cp config.yaml "$temp_dir"
#
# cd "$temp_dir" || exit 1
#
# start=$(date +%s)
# snakemake -j "$cores" --use-conda
# end=$(date +%s)
# total_time=$((end-start))
# echo "$total_time" > "../results/timeit/run_one/snakemake.time.core.$cores"
#
# cd ../
# rm -rf "$temp_dir"
