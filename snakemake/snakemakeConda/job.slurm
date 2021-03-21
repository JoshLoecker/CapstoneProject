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



module load guppy-cpu

# Source our bashrc so conda can be used
source ~/.bashrc
conda activate /project/brookings_minion/conda-envs/mapt_pipeline
module load guppy-cpu

cd $PIPELINE_DIR

snakemake -j 1 --unlock
start=$(date)
snakemake -j all --use-singularity --rerun-incomplete
end=$(date)

printf "Start - %s\n" "$start"
printf "End - %s\n" "$end"

printf "END OF CPU SLURM\n"
