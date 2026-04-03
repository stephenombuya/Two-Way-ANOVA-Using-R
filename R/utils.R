library(dplyr)

log_message <- function(message) {
  cat(paste0("[", Sys.time(), "] ", message, "\n"))
}

check_missing <- function(df) {
  colSums(is.na(df))
}

convert_to_factor <- function(df, cols) {
  df %>%
    mutate(across(all_of(cols), as.factor))
}

ensure_dir <- function(path) {
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }
}
