library(DT)
library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
    dashboardHeader(title = "My Dashboard"),
    dashboardSidebar(
        
        sidebarUserPanel("Mike Ghoul",
                         image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
        sidebarMenu(
            menuItem('Graph by Region', tabName = 'graph', icon = icon('bar-chart')),
            menuItem("Country View", tabName = "region", icon = icon("map")),
            menuItem('Indicator Glossary', tabName = 'info', icon = icon('bookmark')),
            menuItem("Data", tabName = "data", icon = icon("database"))
            
        )),

    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
        ),
        tabItems(
            tabItem(tabName = "region",
                    fluidRow(box(title = 'Selections',
                                 
                                 selectizeInput("selected",
                                                "Select Item to Display",
                                                c('Cumulative drop-out rate to the last grade of primary education, both sexes (%)' = 'Cum_drop_both',
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
                                                  'Unemployment total (% of total labor force)'= 'Unem_t')),
                                 
                                 sliderInput("Year", "Year", 
                                             min = 1977, max = 2015, value = 1990, step= 1)
                                 
                                 )),
                    fluidRow(box(htmlOutput("region"), height = 300, width = 500))),
                             # box(htmlOutput("hist"), height = 300))),
            tabItem(tabName = "data",
                    fluidRow(DT::dataTableOutput("table"), width = '100%')),
            
            tabItem(tabName = 'graph',
                    fluidRow(title = 'Selections',
                                 selectizeInput("selected2",
                                                "Select Item to Display",
                                                c('Cumulative drop-out rate to the last grade of primary education, both sexes (%)' = 'Cum_drop_both',
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
                                                   'Unemployment total (% of total labor force)'= 'Unem_t')),
                                    
                                                
                    fluidRow(plotlyOutput('graph'), height = 800, width = "100%")
                                                                                          )),
            
            tabItem(tabName = "info",
                    fluidRow(box(title = 'Additional Indicator Information',
                             selectizeInput("selected3",
                                            "Select Item to Display",
                                            c('Cumulative drop-out rate to the last grade of primary education'= 'cum_drop', 
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
                                            
                                            
                    ))),
                             
                      fluidRow(box(textOutput('info')))
                                
                             )                       
       )
        )
    )
  )

  
    
     
      
     
    

