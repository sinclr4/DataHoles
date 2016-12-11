#Query to return the number of triples in the store

total_triples_query_definition <- 'SELECT (count(*) as ?count) WHERE {
   ?s ?p ?o .
}'