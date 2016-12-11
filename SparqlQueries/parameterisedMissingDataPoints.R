# parameterised version of missing datapoints query

queries.getMissingDataPointsByDatasetId <- function(datasetId){
  a <- 'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
  SELECT (count(?value) as ?count) ?refArea ?org_name 
  WHERE {
  ?observation <http://purl.org/linked-data/cube#dataSet> '
  
  b <- '. ?observation <http://nhs.publishmydata.com/def/measure-properties/score> ?value.
  ?observation <http://nhs.publishmydata.com/def/dimension/refOrganisation> ?refArea .
  ?refArea rdfs:label ?org_name
}
Group By ?refArea ?org_name
HAVING ( ?count < 4 )'
  
  result <- paste(a, datasetId, b)
    result
}

