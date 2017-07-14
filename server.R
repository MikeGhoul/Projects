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
    
    # dataset <- reactive({
    #  regions_summ_mean 
    # })
  
    output$graph <- renderPlotly({
      print(class(regions_summ_mean$year))
      plot_ly(regions_summ_mean, type = 'scatter', mode = 'lines+markers', x = as.integer(regions_summ_mean$year),
              y =  input$selected2, color = Region)

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
        datatable(country_summ_mean, rownames=FALSE) %>% 
            formatStyle(input$selected, background="skyblue", fontWeight='bold')
    })
    
    # input slider range
    # sliderValues <- reactive({
})