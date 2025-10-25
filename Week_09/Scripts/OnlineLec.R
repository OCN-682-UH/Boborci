library(tidyverse)
library(here)
library(forcats)
income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')


#factor is specialized version of character
#values a factor takes are levels
#want to put things in order
#factors store everything as integers
#important for categorical data

glimpse(starwars)

starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE)


star_counts<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  mutate(species = fct_lump(species, n = 3)) %>%    #converts to factor and then lumps sp. less than 3 ind
  count(species)

star_counts %>%
  ggplot(aes(x = species, y = n))+
  geom_col()

#can reorder
star_counts %>%
ggplot(aes(x = fct_reorder(species, n), y = n))+ # reorder the factor of species by n (col name of counts per sp)
  geom_col()


#pretty
star_counts %>%
  ggplot(aes(x = fct_reorder(species, n, .desc = TRUE), y = n))+ # reorder the factor of species by n
  geom_col() +
  labs(x = "Species")

glimpse(income_mean)
#We will make a plot of the total income by year and quantile across all dollar types.

total_income<-income_mean %>%
  group_by(year, income_quintile)%>%
  summarise(income_dollars_sum = sum(income_dollars))%>%
  mutate(income_quintile = factor(income_quintile)) # make it a factor


total_income%>%
  ggplot(aes(x = year, y = income_dollars_sum, color = income_quintile))+
  geom_line()

#legend in alphabetical-doesnt make sense

total_income%>%
  ggplot(aes(x = year, y = income_dollars_sum, 
             color = fct_reorder2(income_quintile,year,income_dollars_sum)))+    #need factor reorder 2 because its year and income
  geom_line()+
  labs(color = "income quantile")


#how to do based on what order we want

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"))
x1

#vs what we want

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec"))
x1



#back to starwars 

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) # only keep species that have more than 3
starwars_clean


levels(starwars_clean$species)
#levels still all there

starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor 
  filter(n>3)  %>% # only keep species that have more than 3 
  droplevels() # drop extra levels

#always drop levels after doing factor work or use fct_drop


#rename factors
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor 
  filter(n>3)  %>% # only keep species that have more than 3 
  droplevels() %>% # drop extra levels 
  mutate(species = fct_recode(species, "Humanoid" = "Human"))  #new name = old name
starwars_clean














