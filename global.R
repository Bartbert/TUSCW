library(scales)
library(reshape2)
library(data.table)
library(plyr)
library(dplyr)
library(ggplot2)

source("data_functions.R")
source("plot_functions.R")

# Read in data tables
crt.1 <- read.csv("data/crt_1_leader.csv")
crt.2 <- read.csv("data/crt_2_leaders.csv")
crt.3 <- read.csv("data/crt_3_leaders.csv")


