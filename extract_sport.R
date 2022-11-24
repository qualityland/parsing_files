library(readr)
library(dplyr)
library(stringr)


# read in rednotebook data
df <- read_csv("~/tmp/rednotebook/rednotebook.csv")

laufen <- df %>%
  filter(str_detect(text, "Laufen")) %>% 
  mutate(across('text', str_replace, 'Laufen: St.Chrischona Runde', 'Laufen: 80 min St.Chrischona Runde')) %>% 
  mutate(across('text', str_replace, 'Laufen: Rheinrunde', 'Laufen: 60 min Rhein Runde')) %>% 
  mutate(sport=as.numeric(str_extract(text, "(?<=Laufen: ).*(?=min)"))) %>%
  select(date, sport)

write_csv(laufen, "~/tmp/rednotebook/laufen.csv")
