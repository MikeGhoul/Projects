library(DT)
library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
    dashboardHeader(
      title = "Primary Education Trends",
      titleWidth = 300),
    dashboardSidebar(
        width = 300,
        sidebarUserPanel("Mike Ghoul",
                         image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
        sidebarMenu(
            menuItem('Graph by Region', tabName = 'graph', icon = icon('bar-chart')),
            menuItem("Country View", tabName = "region", icon = icon("globe")),
            menuItem('Indicator Correlation', tabName = 'cor', icon = icon('line-chart')),
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
                                               region_choice),
                                 
                                 sliderInput("Year", "Year", 
                                             min = 1977, max = 2015, value = 1990, step= 1)
                                 
                                 )),
                    fluidRow(box(title = 'Individual Country View', htmlOutput("region"), width = '100%'))),
                             
            tabItem(tabName = "data",
                    fluidRow(DT::dataTableOutput("table"), width = '100%')),
            
            tabItem(tabName = 'graph',
                    fluidRow(box(title = 'Selections',
                                 selectizeInput("selected2",
                                                "Select Item to Display",
                                                graph_choice))),
                                    
                                                
                    fluidRow(box(plotlyOutput('graph'), height = 800, width = "100%"))
                                                                                          ),
            
            tabItem(tabName = "info",
                    fluidRow(box(title = 'Indicator Selection',
                             selectizeInput("selected3",
                                            "Select Item to Display",
                                            info_choice))
                                            
                    ),
                             
                      fluidRow(box(title= 'Additional Indicator Information:',
                                   textOutput('info')))
                    
                             ), 
            
            tabItem(tabName = "cor",
                    fluidRow(infoBoxOutput("corBox")),
                    fluidRow(box(title = 'Correlation between Indicators',
                                 selectizeInput('xvalue',
                                                'Choose an x variable',
                                               x_cor_choice),
                                 selectizeInput('yvalue',
                                                'Choose a y variable',
                                                y_cor_choice),
                                 plotlyOutput('cor_plot'), width = '100%')),
                    
                    
                    fluidRow(box(title = 'Correlation Plot', plotOutput('cor'), width = '100%')))
       )
        )
    )
  )

     
    

