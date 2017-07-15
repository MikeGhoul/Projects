library(DT)
library(shiny)
library(googleVis)
library(plotly)

shinyServer(function(input, output){
    # show map using googleVis
    output$region <- renderGvis({
        gvisGeoChart(country_summ_mean, "Country Name", input$selected,
                    
                     options=list(width="auto", height="auto"))
    })
    
    dataset <- reactive({
     regions_summ_mean %>% select_(input$selected2)
    })
    

    output$graph <- renderPlotly({
     
    plot_ly(dataset(), type = 'scatter', mode = 'lines+markers', x = as.numeric(dataset()$year),
              y =  pull(dataset(),input$selected2), color = ~Region)


    })
    
   
    # show data using DataTable
    output$table <- DT::renderDataTable({
        datatable(country_summ_mean, rownames=FALSE) %>% 
            formatStyle(input$selected, background="skyblue", fontWeight='bold')
    })
 
})