## app.R ##
library(shinydashboard)
library(SPARQL)
library(curl)
library(httr)
source("dashboardHeader.R")
source("dashboardSideBar.R")
source("dashboardBody.R")
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
  qd <- SPARQL(sparql_endpoint,total_triples_query_definition)
  df <-qd$results
  y = as.integer(df$count)
  
  output$totalBox <- renderInfoBox({
    infoBox(
      "Total Triples", paste0(y), icon = icon("list"),
      color = "purple"
    )
  })
  
  #How many Data Sets are there
  qd <- SPARQL(sparql_endpoint,total_datasets_query_definition)
  df <-qd$results
  dscount = as.integer(df$count)
  
  output$totalDSBox <- renderInfoBox({
    infoBox(
      "Total Datasest", paste0(dscount), icon = icon("list"),
      color = "green"
    )
  })
  
  # List Datasets
  qd <- SPARQL(sparql_endpoint,list_datasets_query_definition)
  df2 <-qd$results
  output$datasets <- renderTable(df2)


  #Missing Datapoints for PDW
  qd <- SPARQL(sparql_endpoint,missing_datapoints_for_pdw_query_definition)
  dfpdw <-qd$results
  output$pdwdatasets <- renderTable(dfpdw)
  
  output$pdwtotalBox <- renderInfoBox({
    infoBox(
      "Total Points", 4, icon = icon("list"),
      color = "purple"
    )
  })

  # Total updates in last week
  qd <- SPARQL(sparql_endpoint,total_updates_last_week_query_definition)
  df <-qd$results
  updatecount = as.integer(df$count)
  
  output$updatesBox <- renderInfoBox({
    infoBox(
      "Total Updates in last week", paste0(updatecount), icon = icon("list"),
      color = "blue"
    )
  })

  # Worst Mental Health Trusts
  qd <- SPARQL(sparql_endpoint,worst_mental_health_orgs_query_definition)
  dforgds <-qd$results
  output$orgsdatasets <- renderTable(dforgds)
  
  # List of Results Views
  output$resultsViews <- renderTable(resultsViewsData)

  # List of Mental Health Trusts
  output$mentalHealthTrusts <- renderTable(organisationsData)
  
  }

shinyApp(ui, server)