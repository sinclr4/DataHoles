library(SPARQL)

sparql.executeQuery <- function(endpoint, queryDefinition){
  qd <- SPARQL(endpoint,queryDefinition)
  result <-qd$results
  result
}

sparql.totalTriplesQuery <- function(){
  result <- sparql.executeQuery(sparql_endpoint, total_triples_query_definition)
  result
}

sparql.totalDatasetsQuery <- function(){
  result <- sparql.executeQuery(sparql_endpoint, total_datasets_query_definition)
  result
}

sparql.listDatasetsQuery <- function(){
  result <- sparql.executeQuery(sparql_endpoint, list_of_datasets_query_definition)
  result
}

sparql.missingDatapointsForPDWQuery <- function(){
  result <- sparql.executeQuery(sparql_endpoint, missing_datapoints_for_pdw_query_definition)
  result
}

sparql.totalUpdatesLastWeekQuery <- function(){
  result <- sparql.executeQuery(sparql_endpoint, total_updates_last_week_query_definition)
  result
}

sparql.worstMentalHealthOrgsQuery <- function(){
  result <- sparql.executeQuery(sparql_endpoint, worst_mental_health_orgs_query_definition)
  result
}

sparql.getMissingDataPointsByDatasetId <- function(datasetId){
  result <- sparql.executeQuery(sparql_endpoint, queries.getMissingDataPointsById(datasetId))
  result
}
