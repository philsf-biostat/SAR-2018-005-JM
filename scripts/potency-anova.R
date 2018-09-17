source("scripts/input.R")
source('scripts/pval.R')
library(car)
library(Hmisc)
library(userfriendlyscience)

# Monoplex ----------------------------------------------------------------

# Levene
lev.measles.mono <- leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Measles"]) # Measles
lev.mumps.mono <- leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Mumps"]) # Mumps
lev.rubella.mono <- leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Rubella"]) # Rubella
lev.measles.mono.p <- pval(lev.measles.mono$`Pr(>F)`[1])
lev.mumps.mono.p <- pval(lev.mumps.mono$`Pr(>F)`[1])
lev.rubella.mono.p <- pval(lev.rubella.mono$`Pr(>F)`[1])

# Welch ANOVA
welch.aov.measles.mono <- oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Measles"]) # Measles
welch.aov.mumps.mono <- oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Mumps"]) # Mumps
welch.aov.rubella.mono <- oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Rubella"]) # Rubella
welch.aov.measles.mono.p <- pval(welch.aov.measles.mono$p.value)
welch.aov.mumps.mono.p <- pval(welch.aov.mumps.mono$p.value)
welch.aov.rubella.mono.p <- pval(welch.aov.rubella.mono$p.value)

# games-howell post-test
gh.measles.mono <- with(virs.mono[Virus == "Measles"], userfriendlyscience::oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Measles
gh.mumps.mono <- with(virs.mono[Virus == "Mumps"], userfriendlyscience::oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Mumps
gh.rubella.mono <- with(virs.mono[Virus == "Rubella"], userfriendlyscience::oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Rubella
gh.measles.mono.p <- pval(gh.measles.mono$output$dat[, "p"][1])
gh.mumps.mono.p <- pval(gh.mumps.mono$output$dat[, "p"][1])
gh.rubella.mono.p <- pval(gh.rubella.mono$output$dat[, "p"][1])

# Mean results table
means.mono <- cbind(
  virs.mono[Virus == "Measles", .("Measles" = mean(Quantity)), by = Sample],
  virs.mono[Virus == "Mumps", .("Mumps" = mean(Quantity)), by = Sample],
  virs.mono[Virus == "Rubella", .("Rubella" = mean(Quantity)), by = Sample]
)

# Final results table - creation
results_table <- data.table(
  "qPCR Mixture" = rep(NA, 3),
  "Virus Target" = rep(NA, 3),
  "Monovalent Bulk" = rep(as.numeric(NA), 3),
  "Final Vaccine Bulk" = rep(as.numeric(NA), 3),
  "Final Vaccine Batch" = rep(as.numeric(NA), 3)
  )
results_table$`qPCR Mixture` <- rep("Monoplex", 3)
results_table$`Virus Target` <- names(means.mono)[c(2,4,6)]
results_table[`Virus Target` == "Measles", 3:5 ] <- as.list(means.mono[, Measles])
results_table[`Virus Target` == "Mumps", 3:5 ] <- as.list(means.mono[, Mumps])
results_table[`Virus Target` == "Rubella", 3:5 ] <- as.list(means.mono[, Rubella])

# Biplex ------------------------------------------------------------------

means.bi <- cbind(
  virs.bi[Mixture == "Mumps+measles" & Virus== "Measles", .("MM Measles"=mean(Quantity)), by = Sample],
  virs.bi[Mixture == "Mumps+measles" & Virus== "Mumps", .("MM Mumps"=mean(Quantity)), by = Sample],
  virs.bi[Mixture == "Mumps+rubella" & Virus== "Mumps", .("MR Mumps"=mean(Quantity)), by = Sample],
  virs.bi[Mixture == "Mumps+rubella" & Virus== "Rubella", .("MR Rubella"=mean(Quantity)), by = Sample]
  )

results_table <- cbind(data.table(
  "qPCR Mixture" = c(rep("Mumps+measles", 2), rep("Mumps+rubella", 2)),
  "Virus Target" = c("Measles", "Mumps", "Mumps", "Rubella"),
  "Monovalent Bulk" = rep(as.numeric(NA), 4),
  "Final Vaccine Bulk" = rep(as.numeric(NA), 4),
  "Final Vaccine Batch" = rep(as.numeric(NA), 4)
))

results_table[`qPCR Mixture` == "Mumps+measles" & `Virus Target` == "Measles", 3:5] <- as.list(means.bi[, `MM Measles`])
results_table[`qPCR Mixture` == "Mumps+measles" & `Virus Target` == "Mumps", 3:5] <- as.list(means.bi[, `MM Mumps`])
results_table[`qPCR Mixture` == "Mumps+rubella" & `Virus Target` == "Mumps", 3:5] <- as.list(means.bi[, `MR Mumps`])
results_table[`qPCR Mixture` == "Mumps+rubella" & `Virus Target` == "Rubella", 3:5] <- as.list(means.bi[, `MR Rubella`])

# obsolete ----------------------------------------------------------------

# anova.mumps <- aov(data = virs.mono[Virus == "Mumps"], Quantity ~ Sample)
# anova.rubella <- aov(data = virs.mono[Virus == "Rubella"], Quantity ~ Sample)
# anova.measles <- aov(data = virs.mono[Virus == "Measles"], Quantity ~ Sample) # violação de normalidade
# kw.measles <- kruskal.test(data = virs.mono[Virus == "Measles"], 10^Quantity ~ factor(Sample))
# 
# # Residuals
# resid.mumps.p <- format.pval(shapiro.test(resid(anova.mumps))$p.value, digits = 2, eps = .001)
# resid.rubella.p <- format.pval(shapiro.test(resid(anova.rubella))$p.value, digits = 2, eps = .001)
# resid.measles.p <- format.pval(shapiro.test(resid(anova.measles))$p.value, digits = 2, eps = .001)
# 
# TukeyHSD(anova.mumps)
# TukeyHSD(anova.rubella)
# TukeyHSD(anova.measles)
# 
# with(virs.mono[Virus == "Mumps"], pairwise.t.test(Quantity, Sample, p.adjust.method = "bonf"))
# with(virs.mono[Virus == "Rubella"], pairwise.t.test(Quantity, Sample, p.adjust.method = "bonf"))
# with(virs.mono[Virus == "Measles"], pairwise.wilcox.test(10^Quantity, Sample, p.adjust.method = "bonf"))
# 
# # modelos mistos (failed attempt)
# library(nlme)
# lme(Quantity ~ Sample, data = virs.mono[Virus == "Mumps"], random = ~1 | Sample)
# lme(Quantity ~ Sample, data = virs.mono[Virus == "Rubella"], random = ~1 | Sample)
# lme(Quantity ~ Sample, data = virs.mono[Virus == "Measles"], random = ~1 | Sample)
