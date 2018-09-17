source("scripts/input.R")

library(ggplot2)
fig.monoplex <- ggplot(virs.mono, aes(Sample, Quantity)) +
  # geom_boxplot() +
  geom_point(alpha = .25) +
  xlab("") + ylab("Copies/mL (log10)") +
  ylim(c(0,10)) +
  ggtitle("Monoplex") +
  # theme(legend.position = "bottom", legend.title = element_blank()) +
  facet_wrap(~ Virus)
ggsave("figures/monoplex.png", width = 7, height = 7)

fig.biplex <- ggplot(virs.bi, aes(Sample, Quantity)) +
  # geom_boxplot() +
  geom_point(alpha = .25) +
  xlab("") + ylab("Copies/mL (log10)") +
  ylim(c(0,10)) +
  ggtitle("Biplex") +
  # theme(legend.position = "bottom", legend.title = element_blank()) +
  facet_wrap( ~ Virus + Mixture, nrow = 1)
ggsave("figures/biplex.png", width = 7, height = 7)
