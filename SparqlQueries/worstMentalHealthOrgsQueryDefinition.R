#Worst Mental Health Orgs

worst_mental_health_orgs_query_definition <- 'PREFIX dcat: <http://www.w3.org/ns/dcat#>
PREFIX dcterms: <http://purl.org/dc/terms/>
  PREFIX owl: <http://www.w3.org/2002/07/owl#>
  PREFIX qb: <http://purl.org/linked-data/cube#>
  PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
  PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
  PREFIX sdmx: <http://purl.org/linked-data/sdmx/2009/concept#>
  PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
  PREFIX void: <http://rdfs.org/ns/void#>
  PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
  SELECT ?org_name (count(distinct ?ds) as ?count) 
  WHERE {
  ?ds a <http://publishmydata.com/def/dataset#Dataset> .
  ?obs qb:dataSet ?ds .
  ?obs  <http://nhs.publishmydata.com/def/dimension/refOrganisation> ?refOrg .
  ?refOrg rdfs:label ?org_name
  }
  Group By ?org_name 
  Order By ?count'