library(tidyverse)

##Read the file
data <- read_tsv('F_graminearum.gff', comment="#", col_names = FALSE)
## 1: How many genes are in the genome? On how many scaffolds are the genes located?
data %>% filter(X3=='gene') %>% nrow()
data %>% filter(X3=='gene') %>% distinct(X1) %>% nrow()
## There are 13715 genes and 17 scaffolds

## 2: How many genes are on scaffold NC_026474.1?
data %>% filter(X1=='NC_026474.1' & X3=='gene') %>% nrow()
## 4252 genes

## 3:  Which scaffold has the most genes?
data %>% filter(X3=='gene') %>% group_by(X1) %>% count(X3) %>% arrange(desc(n)) %>% head(n=1)
## It is NC_026474.1

## 4: Which scaffold is the shortest?
## Suggestion: scaffolds are called "regions" in gff files.
##First I add a column indicanting length
data <- data %>% mutate(Length=X5 - X4)
##Now I do the analysis
data %>% filter(X3=='region') %>% select(X1,Length) %>% arrange(Length) %>% head(n=1)
##It is NW_001837897.1

## 6: What is the average number of exons per gene?
genes <- data %>% filter(X3=='gene') %>% nrow()
exons <- data %>% filter(X3=='exon') %>% nrow()
exons/genes
#It is 2.77

## 7: Can you export a dataset containing 1 row per gene and two columns?
## One column should have the gene ID and other one the transcript ID.
## Lines with the "mRNA" features contain both gene names and transcript names
data %>% filter(X3=='mRNA') %>% select(X9)
## Column 9 contains the information we seek
data %>% filter(X3=='mRNA') %>% select(X9)
## The fields in column 9 are separated by ";". We need the first two columns
IDs <- data %>% filter(X3=='mRNA') %>% select(X9) %>% separate(X9, sep = ";", into = c("Gene", "Transcript"))
write_tsv(IDs, 'result_LastExercise.txt')


