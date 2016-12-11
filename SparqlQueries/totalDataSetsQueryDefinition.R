#How many Data Sets are there

total_datasets_query_definition <- 'SELECT (count(*) as ?count)
WHERE {
?obs <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://purl.org/linked-data/cube#DataSet>.
?obs <http://www.w3.org/2000/01/rdf-schema#label> ?Name}'