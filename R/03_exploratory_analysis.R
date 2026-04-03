library(ggplot2)
source("R/utils.R")

plot_distribution <- function(df) {

  p <- ggplot(df, aes_string(x = DEPENDENT_VAR)) +
    geom_histogram(bins = 30) +
    theme_minimal() +
    ggtitle("Distribution of Dependent Variable")

  ensure_dir(OUTPUT_PLOTS_PATH)
  ggsave(paste0(OUTPUT_PLOTS_PATH, "distribution.png"), plot = p)

  log_message("Saved distribution plot")
}

plot_interaction <- function(df) {

  p <- ggplot(df, aes_string(x = FACTOR_1, y = DEPENDENT_VAR, color = FACTOR_2)) +
    stat_summary(fun = mean, geom = "line", aes(group = df[[FACTOR_2]])) +
    theme_minimal() +
    ggtitle("Interaction Plot")

  ggsave(paste0(OUTPUT_PLOTS_PATH, "interaction_plot.png"), plot = p)

  log_message("Saved interaction plot")
}
