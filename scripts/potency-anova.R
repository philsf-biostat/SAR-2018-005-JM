source("scripts/input.R")

# analysis code -----------------------------------------------------------

# Levene
library(car)
leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Measles"]) # Measles
leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Mumps"]) # Mumps
leveneTest(Quantity ~ Sample, center = mean, data = virs.mono[Virus == "Rubella"]) # Rubella

# Welch ANOVA
oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Measles"]) # Measles
oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Mumps"]) # Mumps
oneway.test(Quantity ~ Sample, var.equal = F, data = virs.mono[Virus == "Rubella"]) # Rubella

# UserFriendlyScience
library(userfriendlyscience)
with(virs.mono[Virus == "Measles"], oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Measles
with(virs.mono[Virus == "Mumps"], oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Mumps
with(virs.mono[Virus == "Rubella"], oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Rubella

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
