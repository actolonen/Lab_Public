# Method to calculate gene expression from RNAseq FASTQ files

Here, we start with RNAseq FASTQ files and generate gene expression measurements as transcripts per million (TPM)

1.  [FastQC Bash script](./Code/01_quality-control.sh) for quality control of FASTQ file using FastQC. For each FASTQ, the output is an HTML file showing length and quality scores of the reads.
2.  Align reads to reference genome using Bowtie2.
    1.  [Bowtie index Bash script](./Code./02a_bowtie-index.sh) to generate a Bowtie reference using the nucleotide file of the reference genome.
    2.  [Bowtie alignment Bash script](./Code/02b_bowtie.sh) to map reads in each FASTQ file to the reference genome using Bowtie2. The output is a SAM file of reads mapped to the reference genome.
3.  [Make BAM Bash script](./Code/03_make-bam.sh) to convert the SAM file to a sorted BAM file
4.  [featureCounts Bash script](./Code/04_feature-counts.sh) to input aligned reads from a BAM file and uses featureCounts count how many of them map to specific genes or genomic features based on an annotation file (GFF). Output is a count table that can be used for differential expression analysis.
5.  [TPM R code](./Code/05_counts-TPM.py) to convert table of counts to Transcripts Per Million (TPM) for each gene.