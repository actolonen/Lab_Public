# Examine if clusters of genes (i.e. expression clusters) are enriched for functional categories

## Hypergenometric test

The [hypergeometric distribution](https://en.wikipedia.org/wiki/Hypergeometric_distribution) describes the probability of k successes in n draws WITHOUT replacement. The total population contains N objects, of which K objects belong to category c. For example, in a genome of 4000 genes, each gene is classified into one of 25 functional categories (COG) and one of 12 clusters. We can use the hypergeometric test to assess if the genes in any cluster are enriched in a given functional category.

This [code](phyper_test.qmd) shows the implementation of hypergeometric test in R using the phyper(q, m, n, k, lower.tail) function:

phyper is run for each COG in each cluster (number of tests = number of clusters \* number of COGS)

phyper arguments for a given COG in a given cluster:

-   q = number of genes in target cluster belonging to target COG

-   m = total genes in target COG

-   n = genes not in target COG in target cluster

-   k = total genes in target cluster

-   lower.tail = True if searching for P(X \<= q)