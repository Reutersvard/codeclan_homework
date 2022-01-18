# Libraries ---------------------------------------------------------------

library(tidyverse)
library(CodeClanData)


# Cleaning script ---------------------------------------------------------

games <- game_sales %>% 
  mutate(critic_score = critic_score /10,
         genre = as.factor(genre),
         rating = as.factor(rating),
         platform = as.factor(platform)) %>% 
  rename("year" = "year_of_release") %>% 
  select(-rating) %>% 
  filter(year > 1995)
