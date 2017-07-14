getwd()


setwd('/Users/mikeghoul/Desktop/Data Science Bootcamp/R Scripts/Shiny/Shiny Project_MG/')


Education <- fread('data.csv', header = T)


Country_lookup <- fread('EdStatsCountry.csv', header = T)


library(dplyr)

Consol <- left_join(Education, Country_lookup, by = 'Country Code')

Consol_2 <- Consol %>% select( -`Indicator Code`)


New_df <- Consol_2 %>% filter(., `Region` %in%  c('Latin America & Caribbean', 'South Asia', 'Sub-Saharan Africa',
                                              'Europe & Central Asia', 'Middle East & North Africa', 'East Asia & Pacific',
                                              'North America'))
                             
                             
New_df2 <- New_df %>% filter (., `Indicator Name` %in% c('Gross enrolment ratio, primary, both sexes (%)',
                                                         'Gross enrolment ratio, primary, female (%)',
                                                         'Gross enrolment ratio, primary, male (%)',
                                                         'Gross enrolment ratio, primary, gender parity index (GPI)',
                                                         'Expenditure on education as % of total government expenditure (%)',
                                                         'Expenditure on primary as % of government expenditure on education (%)',
                                                         'Expenditure on primary as % of total government expenditure (%)',
                                                         'Government expenditure on education as % of GDP (%)',
                                                         'Government expenditure on primary education as % of GDP (%)',
                                                         'Cumulative drop-out rate to the last grade of primary education, both sexes (%)',
                                                         'Cumulative drop-out rate to the last grade of primary education, female (%)',
                                                         'Cumulative drop-out rate to the last grade of primary education, male (%)',
                                                         'Pupil-teacher ratio in primary education (headcount basis)',
                                                         'Pupil/qualified teacher ratio in primary education (headcount basis)', 
                                                         'GNI per capita, Atlas method (current US$)',
                                                         'GNI per capita, PPP (current international $)',
                                                         'Unemployment, female (% of female labor force)',
                                                         'Unemployment, male (% of male labor force)',
                                                         'Unemployment, total (% of total labor force)',
                                                         'Literacy rate, population 25-64 years, both sexes (%)',
                                                         'Literacy rate, population 25-64 years, female (%)',
                                                         'Literacy rate, population 25-64 years, male (%)',
                                                         'Literacy rate, population 25-64 years, gender parity index (GPI)'))

                             
Consol_education <- New_df2 %>% select(., c(1, 3:42, 68:69, 82)) 

library(tidyr)

colnames(Consol_education) [2] <- 'Indicator'

Consol_education2 <- gather(Consol_education, key='year', value = 'Indicator Name', 3:41) 

Consol_education3 <- spread(Consol_education2, key= 'Indicator', value= 'Indicator Name')

  
class(Consol_education3)

final_ed <- Consol_education3

colnames(final_ed) [6:28] <- c( 'Cumulative drop-out rate (both sexes %)',
                                'Cumulative drop-out rate (female %)', 
                                'Cumulative drop-out rate (male %)', 
                                'Expenditure on education (% of total govt expenditure)',
                                'Expenditure on primary ed (% of total ed expenditure)',
                                'Expenditure on primary ed (% of total govt expenditure)', 
                                'GNI per capita (Atlas)',
                                'GNI per capita (PPP)', 
                                'Govt expenditure on ed (% of GDP)', 
                                'Govt expenditure on primary ed (% of GDP)',
                                'Gross enrollment ratio (both sexes %)', 
                                'Gross enrollment ratio (female %)', 
                                'Gross enrollment ratio (gender parity index)', 
                                'Gross enrollment ratio (male %)', 
                                'Literacy rate, pop 25-64 years, both sexes (%)',
                                'Literacy rate, pop 25-64 years, female (%)',
                                'Literacy rate, population 25-64 years, gender parity index (GPI)',
                                'Literacy rate, pop 25-64 years, male (%)',
                                'Pupil-teacher ratio (headcount)', 
                                'Pupil/qualified teacher ratio (headcount)',
                                'Unemployment female (% of female labor force)', 
                                'Unemployment male (% of male labor force)',
                                'Unemployment total (% of total labor force)')


# Converting columns to numeric: #
final_ed[col.name] <- sapply(final_ed[col.name],as.numeric)
sapply(final_ed, class)

col.name <- c('Cumulative drop-out rate (both sexes %)',
              'Cumulative drop-out rate (female %)', 
              'Cumulative drop-out rate (male %)', 
              'Expenditure on education (% of total govt expenditure)',
              'Expenditure on primary ed (% of total ed expenditure)',
              'Expenditure on primary ed (% of total govt expenditure)', 
              'GNI per capita (Atlas)',
              'GNI per capita (PPP)', 
              'Govt expenditure on ed (% of GDP)', 
              'Govt expenditure on primary ed (% of GDP)',
              'Gross enrollment ratio (both sexes %)', 
              'Gross enrollment ratio (female %)', 
              'Gross enrollment ratio (gender parity index)', 
              'Gross enrollment ratio (male %)', 
              'Literacy rate, pop 25-64 years, both sexes (%)',
              'Literacy rate, pop 25-64 years, female (%)',
              'Literacy rate, population 25-64 years, gender parity index (GPI)',
              'Literacy rate, pop 25-64 years, male (%)',
              'Pupil-teacher ratio (headcount)', 
              'Pupil/qualified teacher ratio (headcount)',
              'Unemployment female (% of female labor force)', 
              'Unemployment male (% of male labor force)',
              'Unemployment total (% of total labor force)')




# Plots:

final_ed2 <- final_ed[,-c(1, 3, 4),drop=FALSE]

regions_summ_mean <- final_ed2 %>% group_by(., year, Region) %>% 
                summarise_all(., funs(mean), na.rm= T)


# 
# final <- as.data.table(final_ed)
# 
# class(final)
# 
# final <- final[,
#           lapply(.SD, function(x) c(median(x), sd(x), mean (x))), by=.(Region, year),
#           .SDcols = -c("Country Name", 'Income Group', 'Government Accounting concept')]

final_ed3 <- final_ed[,- 4,drop=FALSE]
        
country_summ_mean <- final_ed3 %>% group_by(., year, `Country Name`, Region, `Income Group`) %>% 
  summarise_all(., funs(mean), na.rm= T)

install.packages('ggplot2')
library(ggplot2)

ggplot(data=regions_summ_mean, aes(x=year, y = `GNI per capita (Atlas)`, color = Region, group = Region)) + 
  geom_line() +
  geom_point() +
  scale_x_discrete(breaks = seq(1975, 2015, by = 5))



plot_ly(regions_summ_mean, x = ~ year, y = ~ `GNI per capita (Atlas)`, color = Region)


plot_ly(regions_summ_mean, type = 'scatter', mode = 'lines+markers', x = ~year,
        y = ~`GNI per capita (Atlas)`, color = ~ Region) 


p <- ggplot(regions_summ_mean, aes(x = year, y = `GNI per capita (Atlas)`, color = Region)) +
  geom_point()

ggplotly(p)

remove.packages(c("ggplot2", "data.table"))
install.packages('ggplot2', dep = TRUE)
install.packages('data.table', dep = TRUE)



ggplot(data = region_summ, aes(x= Region, y= Cumulative_drop_both)) +
  geom_boxplot(aes(fill= Region))

map(database = 'world', fill = T )

# map example

Geo=gvisGeoChart(region_summ, locationvar="Country Name",
                 hovervar="Region")
plot(Geo)


