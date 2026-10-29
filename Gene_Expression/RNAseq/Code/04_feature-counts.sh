#!/usr/bin/bash

# Andrew Tolonen
# spt26

# calculate raw counts per gene using featureCounts

# load my micromamba environment
module load micromamba;
eval "$(micromamba shell hook --shell bash)"; # Initialize the shell hook for Bash
micromamba activate RNAseq; # Activate your desired environment

# File IO
gff_file="./genomic.gff"
bam_dir="./Bam"
path_out="./Output"

mkdir -p "$path_out"

samples=("AA" "AB" "AD" "AE" "AG" "AH")

# Verify annotation file exists before running loop
if [[ ! -f "$gff_file" ]]; then
    echo "Error: GFF file not found: $gff_file" >&2
    exit 1
fi

# get counts for each sample 

for sample in "${samples_but[@]}"; do
    bam_file="${bam_dir}/${sample}_alignment_sorted.bam"
    counts_file="${path_out_but}/${sample}_counts.txt"

    if [[ ! -f "$bam_file" ]]; then
        echo "Warning: BAM file not found for sample $sample ($bam_file). Skipping..."
        continue
    fi

    echo "Running featureCounts for sample: $sample"

featureCounts -T 8 \
-p \
-s 2 \
-t gene \
-g locus_tag \
-a "$gff_file" \
-o "$counts_file" \
"$bam_file"

done

