## app.R ##
library(shinydashboard)
library(SPARQL)
library(curl)
library(httr)

ui <- dashboardPage(
  dashboardHeader(title = "Shiny Data Holes dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("System Overview Dashboard", tabName = "system", icon = icon("dashboard")),
    menuItem("Mental Health Dashboard", tabName = "mentalhealth", icon = icon("dashboard")),
    menuItem("Privacy, Dignity & Wellbeing", tabName = "pdw", icon = icon("dashboard")),
    menuItem("Datasets", tabName = "datasets", icon = icon("th")),
    menuItem("Results Views", tabName = "resultsViews", icon = icon("th")),
    menuItem("Mental Health Trusts", tabName = "mentalHealthTrusts", icon = icon("th"))
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
              fluidRow( infoBoxOutput("totalDSBox")),
              fluidRow( infoBoxOutput("updatesBox"))),
      
    tabItem(tabName = 'pdw',
            fluidRow( infoBoxOutput("pdwtotalBox")),
            fluidRow( tableOutput('pdwdatasets'))),
    
    tabItem(tabName = 'datasets', 
            fluidRow(tableOutput('datasets'))),
            
    tabItem(tabName = 'resultsViews', 
            fluidRow(tableOutput('resultsViews'))),
    
    tabItem(tabName = 'mentalHealthTrusts', 
            fluidRow(tableOutput('mentalHealthTrusts'))
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
  
  ##Copy from here to create a new block
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
    
  ##End of copy
  
  
  query2 <- 'SELECT *
WHERE {
  ?obs <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#DataSet>.
  ?obs <http://www.w3.org/2000/01/rdf-schema#label> ?Name.
  OPTIONAL{ ?obs <http://purl.org/dc/terms/description> ?Description.} }'
  qd <- SPARQL(endpoint,query2)
  df2 <-qd$results
  output$datasets <- renderTable(df2)
  
  querypdw <- 'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

  SELECT (count(?value) as ?count) ?refArea
  WHERE {
  ?observation <http://purl.org/linked-data/cube#dataSet> <http://nhs.publishmydata.com/data/place-pdw>.
  ?observation <http://nhs.publishmydata.com/def/measure-properties/score> ?value.
  ?observation <http://nhs.publishmydata.com/def/dimension/refOrganisation> ?refArea
  }
  Group By ?refArea
  HAVING ( ?count < 4 )'
  qd <- SPARQL(endpoint,querypdw)
  dfpdw <-qd$results
  output$pdwdatasets <- renderTable(dfpdw)
  
  output$pdwtotalBox <- renderInfoBox({
    infoBox(
      "Total Points", 4, icon = icon("list"),
      color = "purple"
    )
  })

  query <- 'PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
SELECT (count(*) as ?count)
  WHERE {
  ?obs <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#DataSet>.
  ?obs <http://www.w3.org/2000/01/rdf-schema#label> ?Name.
  OPTIONAL{ ?obs <http://purl.org/dc/terms/modified> ?modified} 
  FILTER (?modified > "2016-09-01T00:00:00"^^xsd:dateTime)}'
  
  qd <- SPARQL(endpoint,query)
  df <-qd$results
  updatecount = as.integer(df$count)
  
  output$updatesBox <- renderInfoBox({
    infoBox(
      "Total Updates in last week", paste0(updatecount), icon = icon("list"),
      color = "blue"
    )
  })
  
  resultsViewsRaw <- GET("http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/resultsviews")
  resultsViewsData <- jsonlite::fromJSON(content(resultsViewsRaw, as="text"),  flatten=TRUE)

  organisationsRaw <- GET("http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/OrganisationsByResultsViewId/1054")
  organisationsData <- jsonlite::fromJSON(content(organisationsRaw, as="text"),  flatten=TRUE)

  output$resultsViews <- renderTable(resultsViewsData)
  output$mentalHealthTrusts <- renderTable(organisationsData)
  
  }

shinyApp(ui, server)