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
virs.mono <- virs.mono[, .(Virus, Sample, Quantity)]
rm(mumps.mono, measles.mono, rubella.mono)

# Biplex ------------------------------------------------------------------

mumps.m.bi <- read_excel("dataset/biplex-assay.xlsx", sheet = "Mumps+measles-mumps")
mumps.m.bi <- process.data(mumps.m.bi)
mumps.r.bi <- read_excel("dataset/biplex-assay.xlsx", sheet = "Mumps+rubella-mumps")
mumps.r.bi <- process.data(mumps.r.bi)
measles.bi <- read_excel("dataset/biplex-assay.xlsx", sheet = "Mumps+measles-measles")
measles.bi <- process.data(measles.bi)
rubella.bi <- read_excel("dataset/biplex-assay.xlsx", sheet = "Mumps+rubella-rubella")
rubella.bi <- process.data(rubella.bi)

mumps.m.bi$Mixture <- "Mumps+measles"
mumps.m.bi$Virus <- "Mumps"
mumps.r.bi$Mixture <- "Mumps+rubella"
mumps.r.bi$Virus <- "Mumps"
measles.bi$Mixture <- "Mumps+measles"
measles.bi$Virus <- "Measles"
rubella.bi$Mixture <- "Mumps+rubella"
rubella.bi$Virus <- "Rubella"
