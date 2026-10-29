import pandas as pd

counts = pd.read_csv("counts.txt", sep="\t", skiprows=1, index_col=0)
gene_lengths_kb = counts["Length"] / 1000
read_counts = counts.iloc[:, 5:]  # sample count columns

rpk = read_counts.div(gene_lengths_kb, axis=0)
scaling_factor = rpk.sum(axis=0) / 1e6
tpm = rpk.div(scaling_factor, axis=1)
tpm.to_csv("TPM_matrix.csv")
