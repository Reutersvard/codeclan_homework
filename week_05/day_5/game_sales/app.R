# Libraries ---------------------------------------------------------------

library(shiny)
library(shinydashboard)
library(tidyverse)
source("clean_data.R")
source("helper.R")


# UI ----------------------------------------------------------------------

ui <- dashboardPage(
    
    dashboardHeader(title = "Game Developer Sales"),
    dashboardSidebar(
      fluidRow(
        column(1),
        column(11,
          sliderInput("slider",
                      label = h3("Year range"),
                      1996, 2016, c(1996, 2016),
                      sep = ""))
      ),
      fluidRow(
        column(1),
        column(11,
          checkboxGroupInput("checkgroup", 
                             label = h3("Game developers"), 
                             choices = unique(games$developer)))
      ),
      fluidRow(
        column(1),
        column(11,
         selectInput("selectbox",
                     label = h3("Plot type"),
                     choices = c("Bar chart", "Line graph")))
      )
    ), # / Sidebar
    dashboardBody(
      plotOutput("plot")
    )
) # /UI


# Server ------------------------------------------------------------------

server <- function(input, output, session) {
    
# This plot provides a comparison of developers and their total game sales
# per year. User can select year range and developer name(s) for granularity.
    output$plot <- renderPlot({
      games %>% 
        group_by(year, developer) %>%
        summarise(total_sales = sum(sales)) %>% 
        filter(developer %in% c(input$checkgroup)) %>%
        filter(year >= input$slider[1] & year <= input$slider[2]) %>%
        geom_selector(geom = input$selectbox) +
        scale_fill_brewer(palette = "Dark2") +
        scale_color_brewer(palette = "Dark2") +
        theme_minimal() +
        labs(x = "\n Year",
             y = "Total sales (million units) \n",
             fill = "Game Developer")  
    })
}




# Run app -----------------------------------------------------------------

shinyApp(ui, server)
