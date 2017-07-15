
load('country_summary.Rda')
load('region_summary.Rda')


regions_summ_mean


regions_summ_mean$year <- as.numeric(regions_summ_mean$year)


country_summ_mean

# create variable with colnames as choice
choice <- colnames(country_summ_mean)[c(-1, -2, -3, -4)]
choice2 <- colnames(regions_summ_mean)[c(-1, -2)]


Region <- regions_summ_mean$Region

library(DT)
library(shiny)
library(shinydashboard)
library(DT)
library(shiny)
library(googleVis)
library(plotly)



