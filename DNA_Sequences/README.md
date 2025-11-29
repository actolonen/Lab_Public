# DNA sequence analysis

The Genbank genome is the original reference genome, whereas Refseq genomes have the most up-to-date annotations. Thus, we would like to use Refseq genomes in our analyses. However, the gene names are changed when NCBI releases a RefSeq annotation, which makes continuity across publications a nightmare. Thus, we use these mothods to use the Refseq annotations, but while translating the Refseq gene names to Genbank ones where possible.

-   [Get Refseq and Genbank gene names](get-gene-names_Refseq-Genbank.ipynb) read a Refseq .gff file and output list of Refseq and Genbank gene names.

-   [Translate Refseq to Genbank gene names](translate-gene-names_Refseq-Genbank.ipynb) translate gene names from Refseq to Genbank in a target file.

Common methods in DNA sequence analysis

-   [Clustering](https://github.com/actolonen/Analysis_Lab/tree/main/Genome_Sequences/Clustering) of sequences using hierarchial and K-means clustering.

-   [CRISPR site identification](https://github.com/actolonen/Analysis_Lab/tree/main/DNA_Sequences/CRISPR_Sites) in a genome sequence.

-   [Codon optimization](https://github.com/actolonen/Analysis_Lab/tree/main/DNA_Sequences/Codon_Optimization) of a DNA sequence for DNA synthesis and expression in a host of interest.