library(tibble)
library(stringr)
library(yaml)

file_path = "~/tmp/rednotebook/"
# read files
file_names <- list.files(pattern = "*.txt", path = file_path)


all_entries <- data.frame()

for (file_name in file_names) {
  year_month <- str_sub(file_name, start = 1, end = 7)
  lst <- read_yaml(paste0(file_path, file_name))
  df <- do.call(rbind.data.frame, lst)
  df <- tibble::rownames_to_column(df, "date")
  df$date <- paste0(year_month, "-", str_pad(df$date, 2, pad = "0"))
  all_entries <- rbind(all_entries, df)
}

all_entries
write.csv(all_entries, file = paste0(file_path, "rednotebook.csv"))
