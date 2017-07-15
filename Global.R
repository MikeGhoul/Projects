# convert matrix to dataframe

regions_summ_mean


regions_summ_mean$year <- as.numeric(regions_summ_mean$year)


country_summ_mean

# create variable with colnames as choice
choice <- colnames(country_summ_mean)[c(-1, -2, -3, -4)]
choice2 <- colnames(regions_summ_mean)[c(-1, -2)]


#choice2 <- c("what is shown to user"= "column name",)


Region <- regions_summ_mean$Region


library(DT)
library(shiny)
library(shinydashboard)
library(DT)
library(shiny)
library(googleVis)
library(plotly)


colnames(regions_summ_mean) [3:25] <- c( 'Cum_drop_both',
                                          'Cum_drop_f', 
                                          'Cum_drop_m', 
                                          'Exp_ed_tot_gov',
                                          'Exp_prim_ed_tot_ed',
                                          'Exp_prim_ed_tot_govt', 
                                          'GNI_per_capita_Atlas',
                                          'GNI_per_capitaPPP', 
                                          'Govt_exp_%_GDP', 
                                          'Govt_exp_prim_ed_%_GDP',
                                          'Gross_enr_ratio_both%', 
                                          'Gross_enr_ratio_f%', 
                                          'Gross_enr_ratio_gpi', 
                                          'Gross_enr_ratio_m%)', 
                                          'Lit_rate_pop_25-64_both%',
                                          'Lit_rate_pop_25-64_f%',
                                          'Lit_rate_pop_25-64_GPI',
                                          'Lit_rate_pop_25-64_m%',
                                          'Pupil_teach_ratio', 
                                          'Pupil_qual_teach_ratio',
                                          'Unem_f', 
                                          'Unem_m',
                                          'Unem_t')
