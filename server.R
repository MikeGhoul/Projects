library(DT)
library(shiny)
library(googleVis)
library(plotly)

shinyServer(function(input, output){
  
  # show map using googleVis:
  map_out <- reactive({
    country_summ_mean %>% select_(input$selected) %>% filter(., year == input$Year)
  })
  
  output$region <- renderGvis({
        gvisGeoChart(map_out(), "Country Name", input$selected,
                    
                     options=list(width="auto", height="auto"))
    })
  
  # show graph using plotly:  
  dataset <- reactive({
    as.data.frame(regions_summ_mean %>% select_(input$selected2, 'Region'))
  })
  

    output$graph <- renderPlotly({
    print(dataset())
    plot_ly(dataset(), type = 'scatter', mode = 'lines+markers', x = as.numeric(dataset()$year),
            y =  pull(dataset(),input$selected2), color = Region)%>%
      layout(xaxis = list(title = "Year", showticklabels = TRUE), 
             yaxis = list(title=input$selected2), title = 'Indicator View by Region')
    
    })
  
    # show data using DataTable:
    output$table <- DT::renderDataTable({
        datatable(country_format, rownames=FALSE, extensions = c('FixedColumns','FixedHeader'),
                  options = list(scrollX = TRUE, fixedHeader=TRUE,
                                 fixedColumns = list(leftColumns = 4, rightColumns = 0)))
    })
    
    # show additional indicator info:
    txt <- reactive({
      addl_info %>% select_(input$selected3)
    })
    
    output$info <- renderText({
      as.vector(txt()[1, ])
    })
    
    # Correlation plot
    output$cor <- renderPlot({
      y2_g <- corrplot(y2_c)
    })
    
   
    # show correlation plots using plotly:
    df <- reactive({ 
      as.data.frame(x2) %>% select_(input$xvalue, input$yvalue, 'Country')
   })
    
     output$cor_plot <- renderPlotly({
      print(df())
      plot_ly(df(), type = 'scatter', mode = "markers",  x = pull(df(), input$xvalue), 
              y = pull(df(), input$yvalue), color = df()$Country) %>% 
      layout( xaxis = list( title=input$xvalue),
              yaxis = list( title=input$yvalue ), title = 'Indicator Correlation')

    })
     #show infobox
     output$corBox <- renderInfoBox(
       infoBox(title = 'Correlation',
               round(cor(pull(df(),input$xvalue), pull(df(),input$yvalue)), 2),
               icon = icon("calculator"), fill = TRUE))
     
     
    
})