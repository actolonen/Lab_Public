#!/usr/bin/bash

# Andrew Tolonen
# spt26

# make bam file 

# load modules
module load bowtie2/2.5.4;
module load samtools/1.23.1;

# bowtie genome index path
genome_index="./Lphy"

# path to SAM files
sam_dir="./Sam"
mkdir -p "$sam_dir"

# path to BAM files for output
bam_dir="/Bam"
mkdir -p "$bam_dir"

# Butanol samples
samples=("AA" "AB" "AD" "AE" "AG" "AH");

for sample in "${samples[@]}"; do
    echo "Processing BAM for sample: $sample"

    sam_file="${sam_dir}/${sample}_alignment.sam"
    bam_file_sorted="${bam_dir}/${sample}_alignment_sorted.bam"

    # Verify input SAM file exists
    if [[ ! -f "$sam_file" ]]; then
        echo "Error: SAM file not found: $sam_file. Skipping..."
        continue
    fi

    # Convert SAM to sorted BAM using 8 threads
    if samtools sort -@ 8 -o "$bam_file_sorted" "$sam_file"; then
        # Index the sorted BAM file only if sorting succeeded
        samtools index "$bam_file_sorted"

        # Optional: remove raw SAM file to save disk space
        rm "$sam_file"
    else
        echo "Error: samtools sort failed for $sample"
    fi
done
