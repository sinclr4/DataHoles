## app.R ##
library(shinydashboard)
library(SPARQL)
library(curl)
library(httr)
library(data.table)
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
source("SparqlQueries/parameterisedMissingDataPoints.R")
source("SparqlQueries/getTrustsFromSwirrl.R")
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
  
  output$logo <- renderImage({
    (list(
        src = "img/FireBreak.jpg",
        contentType = "image/jpg",
        alt = "Firebreak"
      ))
    
  }, deleteFile = FALSE)
  
  
  
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
  datasetsRaw <- sparql.listDatasetsQuery()
  ds1 <- sapply(strsplit(as.character(datasetsRaw[,1]), "/"), tail, 1)
  datasets <-  substr(ds1, 1, nchar(ds1)-1)
  vector_selectOptions <- c(datasets)
  names(vector_selectOptions) <- c(datasetsRaw[,2])

  selected_dataset <- vector_selectOptions[1]

  output$datasetSelector <- renderUI({
    selectInput("selectedOptionId", "Choose Option:", as.list(vector_selectOptions, selected = NULL,  
                                                              width = validateCssUnit("600px")), selected_dataset) 
  })
  
  # values <- reactiveValues(df_data = NULL)
  # 
  #  observeEvent(input$selectedOptionId, {
  #    values$df_data <- sparql.getMissingDataPointsByDatasetId(input$selectedOptionId)    
  #  })
  
  
  #Missing Datapoints for PDW
  df <- observe({
    dq <- sparql.getMissingDataPointsByDatasetId(input$selectedOptionId)
  output$pdwTable <- renderTable(dq)
  })
  
  output$selectedOption <- renderText({
    paste("You selected the following dataset: ", input$selectedOptionId)
  })
  
  
  # All Trusts
  allTrusts <- sparql.getTrusts()
  output$numberOfTrusts <- renderText(paste("There are currently ", (length(allTrusts[,1])), "Trusts in the Publish My Data Platform.")) 

  
  d <- sapply(strsplit(as.character(allTrusts[,1]), "/"), tail, 1)
  nacsCodes <-  substr(d, 1, nchar(d)-1)

  allTrustsWithNacsCodes <- cbind(allTrusts, nacsCodes)
  names(allTrustsWithNacsCodes) <- c("Sparql Endpoint Id", "Trust Name", "NACS Code")
  output$allTrusts <- renderTable(allTrustsWithNacsCodes)
  
  
  trustsAndNacsCodesInSwirrl <- allTrustsWithNacsCodes[,2:3]
  trustsAndNacsCodesInWebApi <- organisationsData[,c(2,15)]
  
  missingTrustsNacsCodes <- setdiff(trustsAndNacsCodesInWebApi[,2], trustsAndNacsCodesInSwirrl[,2])
  
  diffTrusts <- trustsAndNacsCodesInWebApi[trustsAndNacsCodesInWebApi[,2] %in% missingTrustsNacsCodes,]
  output$missingTrusts <- renderTable(diffTrusts) 
  
  output$mentalHealthTrusts2 <- renderTable(organisationsData)
  
  output$countMissingTrusts <- renderText(paste("There are currently ", length(diffTrusts[,1]), "missing Trusts"))
  
##  output$missingTrustsBox <- renderInfoBox({
  ##    infoBox(
  ##      "Missing Trusts", paste0(length(diffTrusts[,1])), icon = icon("list"),
  ##      color = "green"
  ##    )
  ##  })
  
  
  }

shinyApp(ui, server)


