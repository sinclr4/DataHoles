## app.R ##
library(shinydashboard)
library(SPARQL)
library(curl)

ui <- dashboardPage(
  dashboardHeader(title = "Shiny Data Holes dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("System Overview Dashboard", tabName = "system", icon = icon("dashboard")),
    menuItem("Mental Health Dashboard", tabName = "mentalhealth", icon = icon("dashboard")),
    menuItem("Widgets", tabName = "widgets", icon = icon("th"))
  )
  ),
  dashboardBody(

    tabItems(
      tabItem(tabName = "mentalhealth",
              # Boxes need to be put in a row (or column)
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
              
              ),
      tabItem(tabName = 'system',
              fluidRow( infoBoxOutput("totalBox"))
    )
  )
)
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  endpoint <- 'http://statistics.gov.scot/sparql'
  query <- 'SELECT (count(*) as ?count) WHERE {
   ?s ?p ?o .
}'
  
  qd <- SPARQL(endpoint,query)
  df <-qd$results
  y = as.integer(df$count)
 
  output$totalBox <- renderInfoBox({
    infoBox(
      "Total Triples", paste0(y), icon = icon("list"),
      color = "purple"
    )
  })
  
  }

shinyApp(ui, server)