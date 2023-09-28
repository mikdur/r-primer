library(tidyverse)

##Read the file
data <- read_tsv('dogs.txt', comment='#', na = c("", "NA", "na"))
##Remove NAs
data <- drop_na(data, Weight_kg)
## 1: Which dog breeds have only 1 representative?
data %>% group_by(Breed) %>% count(Breed) %>% filter(n==1)
## It's the lapponian herder!

## 2: What is the combined weight of all dalmatians present in the dataset?
data %>% filter(Breed=='Dalmatian') %>% select(Weight_kg) %>% sum()
## It is 45 kg!

## 3: Who is the person owning most dogs?
##Separate owners and cities
data <- separate(data, OwnerCity, sep = "_", into = c("Owner", "City"))
##Do the analysis
data %>% group_by(Owner) %>% count(Owner) %>% slice(which.max(n)) %>% arrange(desc(n)) %>% head(n=1) %>% select(Owner)
## It is Meredith

## 4: Mastiffs cannot be that big, make it so that every mastiff weighting more than 90 kg
## has their weight set to 75 kg.
data <- data %>% mutate(Weight_kg=ifelse(Weight_kg > 90 & Breed=='Mastiff', 75, data$Weight_kg))
