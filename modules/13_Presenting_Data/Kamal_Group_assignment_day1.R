# Load necessary libraries
library(ggplot2)
library(tidyverse)
library(viridis)

#set the directory as working directory
setwd("C:/Users/kamal/OneDrive - Colostate/Classes/Spring 2024/CM515/Class_Repo/CM515-course-2024/modules/13_Presenting_Data")

# Load the dataset
mutation_data <- read.delim("MutationRate.txt", header = TRUE)

#check the file
str(mutation_data)


#########################
#create a subset of data for substitution mutation to create a graph
subs = mutation_data %>% filter(MutationType == "Substitutions")

#create multi-facet graph to show the rate of substitution among different genotype
#in mitrochondria and plastids
#mutation rate in log10 scale for better visualization

ggplot (data=subs, aes(x=Genotype, y=MutationRate, color = Genome)) + 
  geom_point() + scale_y_log10() + xlab("Genotype") + 
  ylab("Mutation Rate") + facet_grid (Genotype ~ Genome)

#now let's try the same graph for whole data set
ggplot (data=mutation_data, aes(x=Genotype, y=MutationRate, color = Genome)) + 
  geom_point() + scale_y_log10() + xlab("Genotype") + ylab("Mutation Rate") + 
  facet_grid (Genotype ~ Genome)

#That's great but let's give mutation type different shapes to distinguish better
ggplot (data=mutation_data, aes(x=Genotype, y=MutationRate, color = Genome, shape = MutationType)) + 
  geom_point() + scale_y_log10() + xlab("Genotype") + ylab("Mutation Rate") + 
  facet_grid (Genotype ~ Genome)

#Better but the data points are overlapped. So let's use geom_jitter to separate the data points.
ggplot (data=mutation_data, aes(x=Genotype, y=MutationRate, color = Genome)) + 
  geom_jitter() + scale_y_log10() + xlab("Genotype") + ylab("Mutation Rate") + 
  facet_grid (Genotype ~ Genome)

#now, let's change row to mutation types to show the objective of if genes MSH1 and RADA are involved in 
#maintaining mutation rates.

plot_mut = ggplot (data=mutation_data, aes(x=Genotype, y=MutationRate, color = Genome, 
                                shape = MutationType)) + geom_jitter() + 
  scale_y_log10() + xlab("Genotype") + ylab("Mutation Rate") + 
  facet_grid (rows = vars(mutation_data$MutationType), cols = vars(mutation_data$Genome))

#save the final graph
plot_mut
pdf ("plot_mut.pdf")
plot_mut
dev.off()



