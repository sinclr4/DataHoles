## app.R ##
library(shinydashboard)
library(SPARQL)
library(curl)
library(httr)
source("dashboardHeader.R")
source("dashboardSideBar.R")
source("dashboardBody.R")
source("SparqlQueries/executeSparqlQuery.R")
source("SparqlQueries/sparqlEndpoint.R")
source("SparqlQueries/totalTriplesQueryDefinition.R")
source("SparqlQueries/totalDataSetsQueryDefinition.R")
source("SparqlQueries/listDataSetsQueryDefinition.R")
source("SparqlQueries/missingDataPointsPDWQueryDefinition.R")
source("SparqlQueries/worstMentalHealthOrgsQueryDefinition.R")
source("SparqlQueries/totalUpdatesLastWeekQueryDefinition.R")
source("ScorecardWebApiQueries/getResultsViews.R")
source("ScorecardWebApiQueries/getMentalHealthTrusts.R")

ui <- dashboardPage(
  dashboard_header,
  dashboard_sidebar,
  dashboard_body
)

server <- function(input, output) {
 
  # Total Triples
  df <- sparql.totalTriplesQuery()
  y = as.integer(df$count)
  
  output$totalBox <- renderInfoBox({
    infoBox(
      "Total Triples", paste0(y), icon = icon("list"),
      color = "purple"
    )
  })
  
  #How many Data Sets are there
  df <- sparql.totalDatasetsQuery()
  dscount = as.integer(df$count)
  
  output$totalDSBox <- renderInfoBox({
    infoBox(
      "Total Datasest", paste0(dscount), icon = icon("list"),
      color = "green"
    )
  })
  
  # List Datasets
  df2 <- sparql.listDatasetsQuery()
  output$datasets <- renderTable(df2)


  #Missing Datapoints for PDW
  dfpdw <- sparql.missingDatapointsForPDWQuery()
  output$pdwdatasets <- renderTable(dfpdw)
  
  output$pdwtotalBox <- renderInfoBox({
    infoBox(
      "Total Points", 4, icon = icon("list"),
      color = "purple"
    )
  })

  # Total updates in last week
  df <- sparql.totalUpdatesLastWeekQuery()
  updatecount = as.integer(df$count)
  
  output$updatesBox <- renderInfoBox({
    infoBox(
      "Total Updates in last week", paste0(updatecount), icon = icon("list"),
      color = "blue"
    )
  })

  # Worst Mental Health Trusts
  #qd <- SPARQL(sparql_endpoint,worst_mental_health_orgs_query_definition)
  dforgds <- sparql.worstMentalHealthOrgsQuery()
  output$orgsdatasets <- renderTable(dforgds)
  
  # List of Results Views
  output$resultsViews <- renderTable(resultsViewsData)

  # List of Mental Health Trusts
  output$mentalHealthTrusts <- renderTable(organisationsData)
  
  # all data sets missing data and orgs
  datasets <- sparql.listDatasetsQuery()
  vector_selectOptions <- c(datasets[,1])
  names(vector_selectOptions) <- c(datasets[,2])

  selectedDataset <- vector_selectOptions[1]  

  output$datasetSelector <- renderUI({
    selectInput("selectedDataset", "Choose Option:", as.list(vector_selectOptions)) 
  })
  
  }

shinyApp(ui, server)