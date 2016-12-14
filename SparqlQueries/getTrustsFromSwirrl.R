# List of Datasets

list_of_trusts_from_swirrl_for_pdw <- 'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#> 
SELECT DISTINCT ?refArea ?org_name 
WHERE { 
?observation <http://purl.org/linked-data/cube#dataSet> <http://nhs.publishmydata.com/data/place-pdw> . 
?observation <http://nhs.publishmydata.com/def/dimension/refOrganisation> ?refArea . 
?refArea rdfs:label ?org_name 
}'