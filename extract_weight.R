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



laufen <- df %>%
  filter(str_detect(text, "Laufen")) %>% 
  mutate(across('text', str_replace, 'Laufen: St.Chrischona Runde', 'Laufen: 80 min St.Chrischona Runde')) %>% 
  mutate(across('text', str_replace, 'Laufen: Rheinrunde', 'Laufen: 60 min Rhein Runde')) %>% 
  mutate(sport=as.numeric(str_extract(text, "(?<=Laufen: ).*(?=min)"))) %>%
  select(date, sport)

write_csv(laufen, "~/tmp/rednotebook/laufen.csv")

  # mutate(across('text', str_replace, '(St.Chrischona R|Rheinr)unde', '60 min')) %>%  # (St.Chrischona R|Rheinr)unde mit 60 min ersetzen
  # as.data.frame()
  # 
  # mutate(sport=as.numeric(str_extract(text, "(?<=Laufen: ).*(?=min)"))) %>%
  # select(date, sport)

# laufen <- df %>%
#   filter(str_detect(text, "Laufen:")) %>% 
#   mutate(sport=as.numeric(str_extract(text, "(?<=Laufen: ).*(?= min)"))) %>% 
#   select(date, sport)
# 
# as.data.frame(laufen)



