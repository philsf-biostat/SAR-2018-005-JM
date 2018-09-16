source("scripts/input.R")

# analysis code -----------------------------------------------------------

# Levene
library(car)
leveneTest(Quantity ~ Sample, center = mean, data = measles) # Measles
leveneTest(Quantity ~ Sample, center = mean, data = mumps) # Mumps
leveneTest(Quantity ~ Sample, center = mean, data = rubella) # Rubella

# Welch ANOVA
oneway.test(Quantity ~ Sample, var.equal = F, data = measles) # Measles
oneway.test(Quantity ~ Sample, var.equal = F, data = mumps) # Mumps
oneway.test(Quantity ~ Sample, var.equal = F, data = rubella) # Rubella

# UserFriendlyScience
library(userfriendlyscience)
with(measles, oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Measles
with(mumps, oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Mumps
with(rubella, oneway(Quantity, Sample, levene = T, corrections = T, posthoc = "games-howell", etasq = F, digits = 4)) # Rubella

library(ggplot2)
ggplot(virs, aes(Sample, Quantity)) +
  # geom_boxplot() +
  geom_point(alpha = .25) +
  xlab("") + ylab("Copies/PCR (log10)") +
  ylim(c(0,10)) +
  # ggtitle("Potency") +
  # theme(legend.position = "bottom", legend.title = element_blank()) +
  facet_wrap(~ Virus)
ggsave("figures/potency.png", width = 7, height = 7)


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
