source("scripts/input.R")

# Monoplex ----------------------------------------------------------------

# Levene
library(car)
lev.measles.mono <- leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Measles"]) # Measles
lev.mumps.mono <- leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Mumps"]) # Mumps
lev.rubella.mono <- leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Rubella"]) # Rubella

# Welch ANOVA
welch.aov.measles.mono <- oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Measles"]) # Measles
welch.aov.mumps.mono <- oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Mumps"]) # Mumps
welch.aov.rubella.mono <- oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Rubella"]) # Rubella

# games-howell post-test
library(userfriendlyscience)
gh.measles.mono <- with(virs.mono[Virus == "Measles"], oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Measles
gh.mumps.mono <- with(virs.mono[Virus == "Mumps"], oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Mumps
gh.rubella.mono <- with(virs.mono[Virus == "Rubella"], oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Rubella

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
