source("scripts/input.R")

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
