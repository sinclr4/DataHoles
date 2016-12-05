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
    menuItem("Datasets", tabName = "datasets", icon = icon("th"))
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
              fluidRow( infoBoxOutput("totalBox")),
              fluidRow( infoBoxOutput("totalDSBox"))
    ),
    tabItem(tabName = 'datasets',
            fluidRow(tableOutput('datasets'))
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
  
  #endpoint <- 'http://statistics.gov.scot/sparql'
  endpoint <- 'http://nhs.publishmydata.com/sparql'
  #Query to return the number of triples in the store
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
  
  #How many Data Sets are there
  query <- 'SELECT (count(*) as ?count)
WHERE {
  ?obs <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#DataSet>.
  ?obs <http://www.w3.org/2000/01/rdf-schema#label> ?Name}'
  
  qd <- SPARQL(endpoint,query)
  df <-qd$results
  dscount = as.integer(df$count)
  
  output$totalDSBox <- renderInfoBox({
    infoBox(
      "Total Datasest", paste0(dscount), icon = icon("list"),
      color = "green"
    )
  })
    
  query <- 'SELECT *
WHERE {
  ?obs <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#DataSet>.
  ?obs <http://www.w3.org/2000/01/rdf-schema#label> ?Name.
  OPTIONAL{ ?obs <http://purl.org/dc/terms/description> ?Description.} }'
  qd <- SPARQL(endpoint,query)
  df <-qd$results
  output$datasets <- renderTable(df)

  
  }

shinyApp(ui, server)