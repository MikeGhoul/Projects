library(DT)
library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
    dashboardHeader(title = "My Dashboard"),
    dashboardSidebar(
        
        sidebarUserPanel("Mike Ghoul",
                         image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
        sidebarMenu(
            menuItem('Graph', tabName = 'graph', icon = icon('bar-chart')),
            menuItem("Region View", tabName = "region", icon = icon("map")),
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
                                                choice),
                                 
                                 sliderInput("Year", "Year", 
                                             min = 1977, max = 2016, value = 1990, step= 1)
                                 
                                 
                                 )),
                    fluidRow(box(htmlOutput("region"), height = 300, width = 500))),
                             # box(htmlOutput("hist"), height = 300))),
            tabItem(tabName = "data",
                    fluidRow(box(DT::dataTableOutput("table"), width = 12))),
            
            tabItem(tabName = 'graph',
                    fluidRow(title = 'Selections',
                                 selectizeInput("selected2",
                                                "Select Item to Display",
                                                choice),
                                 
                                 
                    fluidRow(plotlyOutput('graph'), height = 800, width = "100%")
                                 
                                 )))
        )
    
))