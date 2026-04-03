source("R/utils.R")

run_two_way_anova <- function(df) {

  log_message("Running Two-Way ANOVA...")

  formula <- as.formula(
    paste(DEPENDENT_VAR, "~", FACTOR_1, "*", FACTOR_2)
  )

  model <- aov(formula, data = df)

  results <- summary(model)

  write.table(
    capture.output(results),
    file = paste0(OUTPUT_TABLES_PATH, "anova_results.txt"),
    row.names = FALSE
  )

  log_message("ANOVA results saved")

  return(model)
}
