#!/usr/bin/bash

# Andrew Tolonen
# spt26

# Make a bowtie index for a reference

module load bowtie2/2.5.4;

# path to the nucleotide fasta file for the reference genome
genome_ref="./GCA_000018685.1_ASM1868v1_genomic.fna";

# base name for bowtie index files
base_name = "Lphy";

bowtie2-build $genome_ref $base_name
