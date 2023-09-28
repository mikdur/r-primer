library(tidyverse)

##Read the file
data <- read_tsv('example_dataset.txt', comment='#', na = c("NAN", "nan"))
## 1: Replace NAs in the Taxonomy column with "Fungi".
data <- replace_na(data, list(Taxonomy = 'Fungi'))

## 2: Find out the median genome size in the dataset
## Separate genes and genomes columns
data <- separate(data, "Genes and genome_Mb", sep = "_", into = c("Genes", "Genome_Mb"), convert = TRUE)
## Do the analysis
Median <- data %>% summarize(Median = median(Genome_Mb)) %>% pull()
## It is 33.6 Mb!

## 3: Find out which organism has the median genome size in the dataset.
data %>% filter(Genome_Mb == Median)
## It is Heterobasidion annosum

## 4: Find out what is the average gene number in the Fusarium species?
##Make a genus column
data <- separate(data, "Organism", sep = " ", into = c("Genus", "Descriptor"), convert = TRUE)
##Use the genome column to find out the answer
data %>% filter(Genus == 'Fusarium') %>% summarize(Average = mean(Genes))
##It is 14334!
