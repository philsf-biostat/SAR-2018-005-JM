library(readxl)
source("scripts/process.data.R")

# Monoplex ----------------------------------------------------------------

mumps.mono <- read_excel("dataset/FAST- teste bulk mono x for x liof CAX 19-12_data.xls", 3)
mumps.mono <- process.data(mumps.mono)

rubella.mono <- read_excel("dataset/FAST- teste bulk mono x for x liof RUB 19-12_data.xls", 3)
rubella.mono <- process.data(rubella.mono)

measles.mono <- read_excel("dataset/FAST- teste bulk mono x for x liof SAR 19-12_data.xls", 3)
measles.mono <- process.data(measles.mono)

mumps.mono$Virus <- "Mumps"
rubella.mono$Virus <- "Rubella"
measles.mono$Virus <- "Measles"
virs.mono <- rbind(mumps.mono, rubella.mono, measles.mono)
rm(mumps.mono, measles.mono, rubella.mono)
