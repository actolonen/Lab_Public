#!/usr/bin/bash

# Andrew Tolonen
# spt26

# run bowtie alignments of RNAseq fastq files 

# load bowtie2 and samtools modules
module load bowtie2/2.5.4;
module load samtools;

# path to bowtie genome index
genome_index="./Lphy"

# path to list of fastq files to analyze
fastq_list="./list_fastq.txt"

# Read fastq files into lines array
mapfile -t lines < "$fastq_list"

# path to output directory for sam files
sam_dir="./Sam"
mkdir -p "$sam_dir"

# List of samples for analysis
samples=("AA" "AB" "AD" "AE" "AG" "AH");

for sample in "${samples[@]}"; do
    echo "aligning sample $sample"
    sam_file="${sam_dir}/${sample}_alignment.sam"

    # Reset variables for each sample
    fastq1=""
    fastq2=""

    # Identify each fastq file for analysis
    for my_file in "${lines[@]}"; do
        if [[ "$my_file" == *"${sample}OSRB"* && "$my_file" == *8_1* ]]; then
            fastq1="$my_file"  
        fi
        if [[ "$my_file" == *"${sample}OSRB"* && "$my_file" == *8_2* ]]; then
            fastq2="$my_file"  
        fi
    done

    echo "sample ${sample} fastq1 = $fastq1";
    echo "sample ${sample} fastq2 = $fastq2";

    bowtie2 -x "$genome_index" \
            -1 "$fastq1" \
            -2 "$fastq2" \
            -p 8 -S "$sam_file"
done
