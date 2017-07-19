library(DT)
library(shiny)
library(shinydashboard)
library(dplyr)
library(shiny)
library(googleVis)
library(plotly)
library(corrplot)


load('country_summary.Rda')
load('region_summary.Rda')
load('addl_info.Rda')
load('country_format.Rda')
load('corr_data.Rda')
load('corr_data_count.Rda')

regions_summ_mean$year <- as.numeric(regions_summ_mean$year)


corr_data_c <- cor(corr_data)


Region <- regions_summ_mean$Region


# create variable with colnames as choice
choice <- colnames(country_summ_mean)[c(-1, -2, -3, -4)]
choice2 <- colnames(regions_summ_mean)[c(-1, -2)]


# various choice inputs for user:
region_choice <- c('Cumulative drop-out rate to the last grade of primary education, both sexes (%)' = 'Cum_drop_both',
  'Cumulative drop-out rate to the last grade of primary education, female (%)' =  'Cum_drop_f', 
  'Cumulative drop-out rate to the last grade of primary education, male (%)' ='Cum_drop_m', 
  'Expenditure on education as % of total government expenditure (%)' = 'Exp_ed_tot_gov',
  'Expenditure on primary as % of government expenditure on education (%)' = 'Exp_prim_ed_tot_ed',
  'Expenditure on primary as % of total government expenditure (%)' = 'Exp_prim_ed_tot_govt', 
  'GNI per capita, Atlas method (current US$)' = 'GNI_per_capita_Atlas',
  'GNI per capita, PPP (current international $)' = 'GNI_per_capitaPPP', 
  'Government expenditure on education as % of GDP (%)' = 'Govt_exp_GDP', 
  'Government expenditure on primary education as % of GDP (%)' = 'Govt_exp_prim_ed_GDP',
  'Gross enrollment ratio (both sexes %)' = 'Gross_enr_ratio_both', 
  'Gross enrollment ratio (female %)' = 'Gross_enr_ratio_f', 
  'Gross enrollment ratio (gender parity index)' = 'Gross_enr_ratio_gpi', 
  'Gross enrollment ratio (male %)' = 'Gross_enr_ratio_m', 
  'Literacy rate, population 25-64 years, both sexes (%)'= 'Lit_rate_pop_25_64_both',
  'Literacy rate, population 25-64 years, female (%)'= 'Lit_rate_pop_25_64_f',
  'Literacy rate, population 25-64 years, gender parity index (GPI)' = 'Lit_rate_pop_25_64_GPI',
  'Literacy rate, pop 25-64 years, male (%)' = 'Lit_rate_pop_25_64_m',
  'Net enrollment rate, primary, both sexes (%)'  = 'Net_enr_ratio_both', 
  'Net enrollment rate, primary, female (%)'= 'Net_enr_ratio_f', 
  'Net enrollment rate, primary, gender parity index (GPI)' = 'Net_enr_ratio_gpi', 
  'Net enrollment rate, primary, male (%)' = 'Net_enr_ratio_m',
  'Pupil-teacher ratio (headcount)' = 'Pupil_teach_ratio', 
  'Pupil/qualified teacher ratio (headcount)' = 'Pupil_qual_teach_ratio',
  'Unemployment female (% of female labor force)' = 'Unem_f', 
  'Unemployment male (% of male labor force)' = 'Unem_m',
  'Unemployment total (% of total labor force)'= 'Unem_t')


graph_choice <- c('Cumulative drop-out rate to the last grade of primary education, both sexes (%)' = 'Cum_drop_both',
  'Cumulative drop-out rate to the last grade of primary education, female (%)' =  'Cum_drop_f', 
  'Cumulative drop-out rate to the last grade of primary education, male (%)' ='Cum_drop_m', 
  'Expenditure on education as % of total government expenditure (%)' = 'Exp_ed_tot_gov',
  'Expenditure on primary as % of government expenditure on education (%)' = 'Exp_prim_ed_tot_ed',
  'Expenditure on primary as % of total government expenditure (%)' = 'Exp_prim_ed_tot_govt', 
  'GNI per capita, Atlas method (current US$)' = 'GNI_per_capita_Atlas',
  'GNI per capita, PPP (current international $)' = 'GNI_per_capitaPPP', 
  'Government expenditure on education as % of GDP (%)' = 'Govt_exp_GDP', 
  'Government expenditure on primary education as % of GDP (%)' = 'Govt_exp_prim_ed_GDP',
  'Gross enrollment ratio (both sexes %)' = 'Gross_enr_ratio_both', 
  'Gross enrollment ratio (female %)' = 'Gross_enr_ratio_f', 
  'Gross enrollment ratio (gender parity index)' = 'Gross_enr_ratio_gpi', 
  'Gross enrollment ratio (male %)' = 'Gross_enr_ratio_m', 
  'Literacy rate, population 25-64 years, both sexes (%)'= 'Lit_rate_pop_25_64_both',
  'Literacy rate, population 25-64 years, female (%)'= 'Lit_rate_pop_25_64_f',
  'Literacy rate, population 25-64 years, gender parity index (GPI)' = 'Lit_rate_pop_25_64_GPI',
  'Literacy rate, pop 25-64 years, male (%)' = 'Lit_rate_pop_25_64_m',
  'Net enrollment rate, primary, both sexes (%)'  = 'Net_enr_ratio_both', 
  'Net enrollment rate, primary, female (%)'= 'Net_enr_ratio_f', 
  'Net enrollment rate, primary, gender parity index (GPI)' = 'Net_enr_ratio_gpi', 
  'Net enrollment rate, primary, male (%)' = 'Net_enr_ratio_m',
  'Pupil-teacher ratio (headcount)' = 'Pupil_teach_ratio', 
  'Pupil/qualified teacher ratio (headcount)' = 'Pupil_qual_teach_ratio',
  'Unemployment female (% of female labor force)' = 'Unem_f', 
  'Unemployment male (% of male labor force)' = 'Unem_m',
  'Unemployment total (% of total labor force)'= 'Unem_t')

info_choice <- c('Cumulative drop-out rate to the last grade of primary education'= 'cum_drop', 
       'Expenditure on education as % of total government expenditure (%)' =  'exp_ed',
       'Expenditure on primary as % of government expenditure on education (%)' = 'exp_prim',
       'GNI per capita, Atlas method (current US$)' = 'gni_atlas',
       'GNI per capita, PPP (current international $)' = 'gni_ppp',
       'Government expenditure on education, total (% of GDP)' = 'govt_exp',
       'Gross enrollment ratio' = 'gross_enr_rat',
       'Literacy rate, gender parity index (GPI)' = 'lit_gpi',
       'Net enrolment rate, primary, both sexes (%)' = 'net_enr',
       'Pupil-teacher ratio in primary education (headcount basis)' = 'pup_teach',
       'School enrollment, primary (gross), gender parity index (GPI)' = 'enr_prim_gpi',
       'Unemployment, total (% of total labor force)' = 'unem_tot')

x_cor_choice <- c('Cumulative drop out' = 'Cum_drop_both', 
  'Expenditure on ed' = 'Exp_ed_tot_gov', 
  'Expenditure prim ed' = 'Exp_ed_tot_gov', 
  'GNI Atlas' = 'GNI_per_capita_Atlas',
  'GNI PPP' = 'GNI_per_capitaPPP', 
  'Govt expenditure ed %GDP' = 'Govt_exp_GDP', 
  'Govt expenditure on prim ed %GDP' = 'Govt_exp_prim_ed_GDP', 
  'Gross enrollment ratio' = 'Gross_enr_ratio_both',
  'Gross enrollment ratio GPI' = 'Gross_enr_ratio_gpi', 
  'Literacy rate bt 25 and 64' = 'Lit_rate_pop_25_64_both', 
  'Net enrollment ratio' = 'Net_enr_ratio_both', 
  'Net enrollment ratio GPI' = 'Net_enr_ratio_gpi',
  'Pupil to teacher ratio' = 'Pupil_teach_ratio', 
  'Unemployment rate' = 'Unem_t')

y_cor_choice <- c('Cumulative drop out' = 'Cum_drop_both', 
  'Expenditure on ed' = 'Exp_ed_tot_gov', 
  'Expenditure prim ed' = 'Exp_ed_tot_gov', 
  'GNI Atlas' = 'GNI_per_capita_Atlas',
  'GNI PPP' = 'GNI_per_capitaPPP', 
  'Govt expenditure ed %GDP' = 'Govt_exp_GDP', 
  'Govt expenditure on prim ed %GDP' = 'Govt_exp_prim_ed_GDP', 
  'Gross enrollment ratio' = 'Gross_enr_ratio_both',
  'Gross enrollment ratio GPI' = 'Gross_enr_ratio_gpi', 
  'Literacy rate bt 25 and 64' = 'Lit_rate_pop_25_64_both', 
  'Net enrollment ratio' = 'Net_enr_ratio_both', 
  'Net enrollment ratio GPI' = 'Net_enr_ratio_gpi',
  'Pupil to teacher ratio' = 'Pupil_teach_ratio', 
  'Unemployment rate' = 'Unem_t')


