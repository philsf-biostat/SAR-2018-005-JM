source("scripts/input.R")
library(car)
library(Hmisc)
library(userfriendlyscience)

format_digits <- 5
format_eps <- 10^(-format_digits)

# Monoplex ----------------------------------------------------------------

# Levene
lev.measles.mono <- leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Measles"]) # Measles
lev.mumps.mono <- leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Mumps"]) # Mumps
lev.rubella.mono <- leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Rubella"]) # Rubella
lev.measles.mono.p <- Hmisc::format.pval(lev.measles.mono$`Pr(>F)`[1], digits = format_digits, scientific = FALSE, eps = format_eps)
lev.mumps.mono.p <- Hmisc::format.pval(lev.mumps.mono$`Pr(>F)`[1], digits = format_digits, scientific = FALSE, eps = format_eps)
lev.rubella.mono.p <- Hmisc::format.pval(lev.rubella.mono$`Pr(>F)`[1], digits = format_digits, scientific = FALSE, eps = format_eps)

# Welch ANOVA
welch.aov.measles.mono <- oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Measles"]) # Measles
welch.aov.mumps.mono <- oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Mumps"]) # Mumps
welch.aov.rubella.mono <- oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Rubella"]) # Rubella
welch.aov.measles.mono.p <- Hmisc::format.pval(welch.aov.measles.mono$p.value, digits = format_digits, scientific = FALSE, eps = format_eps)
welch.aov.mumps.mono.p <- Hmisc::format.pval(welch.aov.mumps.mono$p.value, digits = format_digits, scientific = FALSE, eps = format_eps)
welch.aov.rubella.mono.p <- Hmisc::format.pval(welch.aov.rubella.mono$p.value, digits = format_digits, scientific = FALSE, eps = format_eps)

# games-howell post-test
gh.measles.mono <- with(virs.mono[Virus == "Measles"], oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Measles
gh.mumps.mono <- with(virs.mono[Virus == "Mumps"], oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Mumps
gh.rubella.mono <- with(virs.mono[Virus == "Rubella"], oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Rubella
gh.measles.mono.p <- Hmisc::format.pval(gh.measles.mono$output$dat[, "p"][1], digits = format_digits, scientific = FALSE, eps = format_eps)
gh.mumps.mono.p <- Hmisc::format.pval(gh.mumps.mono$output$dat[, "p"][1], digits = format_digits, scientific = FALSE, eps = format_eps)
gh.rubella.mono.p <- Hmisc::format.pval(gh.rubella.mono$output$dat[, "p"][1], digits = format_digits, scientific = FALSE, eps = format_eps)

# obsolete ----------------------------------------------------------------

# anova.mumps <- aov(data = mumps, Quantity ~ Sample)
# anova.rubella <- aov(data = rubella, Quantity ~ Sample)
# anova.measles <- aov(data = measles, Quantity ~ Sample) # violação de normalidade
# kw.measles <- kruskal.test(data = measles, 10^Quantity ~ factor(Sample))
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
# with(mumps, pairwise.t.test(Quantity, Sample, p.adjust.method = "bonf"))
# with(rubella, pairwise.t.test(Quantity, Sample, p.adjust.method = "bonf"))
# with(measles, pairwise.wilcox.test(10^Quantity, Sample, p.adjust.method = "bonf"))
# 
# # modelos mistos (failed attempt)
# library(nlme)
# lme(Quantity ~ Sample, data = mumps, random = ~1 | Sample)
# lme(Quantity ~ Sample, data = rubella, random = ~1 | Sample)
# lme(Quantity ~ Sample, data = measles, random = ~1 | Sample)
