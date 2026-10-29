#!/usr/bin/bash

# Andrew Tolonen
# RNAseq initial QC

module load fastqc/0.12.1

path_out_base="./QC_reports"
fastq_list="./list_fastq.txt"

# Read fastq files into lines array
mapfile -t lines < "$fastq_list"

samples=("AA" "AB" "AD" "AE" "AG" "AH" "AJ" "AK" "AL" "AM" "AN" "AO" "AP" "AQ")

for sample in "${samples[@]}"; do
    echo "Processing sample: $sample"
    path_out="${path_out_base}/${sample}"
    
    # Ensure the output subdirectory exists before running FastQC
    mkdir -p "$path_out"

    # Iterate over 'lines' array, not the 'fastq_list' path
    for my_file in "${lines[@]}"; do
        if [[ "$my_file" == *"${sample}OSRB"* ]]; then
            fastqc "$my_file" -o "$path_out"
        fi
    done

    # Aggregate FastQC reports per sample directory
#    multiqc "$path_out" -o "$path_out"
done
