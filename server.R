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
     regions_summ_mean %>% group_by(., Region) %>% 
        select_(input$selected2)
    })
  
    
    
    output$graph <- renderPlotly({
     
     
      plot_ly(dataset(), type = 'scatter', mode = 'lines+markers', x = as.numeric(dataset()$year),
              y =  pull(dataset(),input$selected2), color = ~Region)


      # p <- ggplot(dataset(), aes(x = year, y = input$selected2, color = Region)) +
      #   geom_point()
      # 
      # ggplotly(p)
    })
    
    
    # slider input range:
    # output$range <- renderPrint({ input$slider2 })
    
    
    
    # show line plot 
    
    
    
    # 
    # datasetInput <- reactive({
    #   switch(input$dataset,
    #          "rock" = rock,
    #          "pressure" = pressure,
    #          "cars" = cars)
    # })
    # 
    # output$view <- renderGvis({
    #   gvisScatterChart(datasetInput(), options=list(width=400, height=450))
    # })
    
    
    # show data using DataTable
    output$table <- DT::renderDataTable({
        datatable(regions_summ_mean, rownames=FALSE) %>% 
            formatStyle(input$selected, background="skyblue", fontWeight='bold')
    })
    
    # input slider range
    # sliderValues <- reactive({
})