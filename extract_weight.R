library(readr)
library(dplyr)
library(stringr)


# read in rednotebook data
df <- read_csv("~/tmp/rednotebook/rednotebook.csv")

weight <- df %>%
  filter(str_detect(text, "Gewicht")) %>% 
  mutate(gewicht=as.numeric(str_extract(text, "(?<=Gewicht: ).*(?= kg)"))) %>% 
  select(date, gewicht)

write_csv(weight, "~/tmp/rednotebook/weight.csv")
