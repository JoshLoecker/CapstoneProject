#!/bin/bash

# USAGE: sh run_workflow_call_on_file.sh <fastq file>
# This script accepts the location of a fastq file and performs the following steps on it:
    ## starting with alignment using bwa
    ## convert the .sai to SAM -> BAM -> sorted BAM

# load the modules
source "$HOME/miniconda3/etc/profile.d/conda.sh"
conda activate capstone
output_folder="./temp_results"
# The first command is to change to our working directory
# make directories to store output
mkdir -p "$output_folder/sai"
mkdir -p "$output_folder/sam"
mkdir -p "$output_folder/bam"
mkdir -p "$output_folder/bam_sorted"

# Get input file and locations
fastq_input=$1

# Grab base of filename for future naming
base=$(basename "$fastq_input" .fastq)
echo "Starting analysis of" "$base"

# set up output filenames and locations
sai="$output_folder/sai/$base.aligned.sai"
sam="$output_folder/sam/$base.aligned.sam"
bam="$output_folder/bam/$base.aligned.bam"
sorted_bam="$output_folder/bam_sorted/$base.aligned.sorted.bam"

# location to genome reference FASTA file
genome="../testing_data/genome/zymogen_alignment.fasta"

### Alignment

# Align the reads to the reference genome
bwa aln $genome "$fastq_input" > "$sai"

# Convert the output to the SAM format
bwa samse $genome "$sai" "$fastq_input" > "$sam"

# Convert the SAM file to BAM format
samtools view -S -b "$sam" > "$bam"

# Sort the BAM file
samtools sort "$bam" -o "$sorted_bam"
