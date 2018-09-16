source("scripts/input.R")

library(ggplot2)
ggplot(virs, aes(Sample, Quantity)) +
  # geom_boxplot() +
  geom_point(alpha = .25) +
  xlab("") + ylab("Copies/mL (log10)") +
  ylim(c(0,10)) +
  ggtitle("Monoplex") +
  # theme(legend.position = "bottom", legend.title = element_blank()) +
  facet_wrap(~ Virus)
ggsave("figures/monoplex.png", width = 7, height = 7)
