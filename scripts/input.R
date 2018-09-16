library(readxl)
source("scripts/process.data.R")

mumps <- read_excel("dataset/FAST- teste bulk mono x for x liof CAX 19-12_data.xls", 3)
mumps <- process.data(mumps)

rubella <- read_excel("dataset/FAST- teste bulk mono x for x liof RUB 19-12_data.xls", 3)
rubella <- process.data(rubella)

measles <- read_excel("dataset/FAST- teste bulk mono x for x liof SAR 19-12_data.xls", 3)
measles <- process.data(measles)

mumps$Virus <- "Mumps"
rubella$Virus <- "Rubella"
measles$Virus <- "Measles"
virs <- rbind(mumps, rubella, measles)
