library(readr)
source("R/utils.R")

load_data <- function(file_name) {
  path <- paste0(DATA_RAW_PATH, file_name)
  log_message(paste("Loading data from:", path))

  df <- read_csv(path, show_col_types = FALSE)

  return(df)
}
