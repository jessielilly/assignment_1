
# Loaded tidyverse and lubridate packages
library(tidyverse)
library(lubridate)

# read in datafile
blpw.all <- readRDS("~/Desktop/r4ds//blpw.all.RDS")

# Check status of columns
sapply(blpw.all, class)

# Change year and month to intergers
blpw.all$year<-as.integer(blpw.all$year)
blpw.all$month<-as.integer(blpw.all$month)

# Combine year, month and day into one column (separated by a dash)
blpw.all$date<-with(blpw.all, ymd(paste(year,month,day,sep = "-")))

# Grouped by band number, arranged it by band and date, created column for the first mass relative to the recapture mass
blpw.band <- blpw.all %>%
  group_by(band) %>%
  arrange(band,date) %>%
  mutate(diff_mass=mass-first(mass)) %>% data.frame()

# Since we're looking for "Time of Year" as opposed to specific "Year", we can make all years 0. So create another column ("date") where the year was all changed to 0000
blpw.band2 <- blpw.band %>% 
  mutate(date = make_date(!year,month,day))

# Since we're observing the change in mass, we only need data for birds that have been recaptured. So filter "recap" column to only have recaps birds (R)
blpw.band3 <- filter(blpw.band2, recap == 'R')

# Created ggplot using filtered dataset 
ggplot(data = blpw.band3, mapping = aes(x = date, y = diff_mass, colour = band))+
  geom_point()+
  geom_line()+
  facet_wrap(~location, nrow = 1)+
  theme(legend.position = 'none')+
  ylab("Mass (in grams, relative to capture date)")+
  xlab("Time of Year")
