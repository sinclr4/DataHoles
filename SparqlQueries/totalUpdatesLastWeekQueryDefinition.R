#Updates in last week

total_updates_last_week_query_definition <- 'PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
SELECT (count(*) as ?count)
  WHERE {
  ?obs <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#DataSet>.
  ?obs <http://www.w3.org/2000/01/rdf-schema#label> ?Name.
  OPTIONAL{ ?obs <http://purl.org/dc/terms/modified> ?modified} 
  FILTER (?modified > "2016-09-01T00:00:00"^^xsd:dateTime)}'