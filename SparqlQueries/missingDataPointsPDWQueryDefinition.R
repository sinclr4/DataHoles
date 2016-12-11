# Missing datapoints for PDW

missing_datapoints_for_pdw_query_definition <- 'PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
  SELECT (count(?value) as ?count) ?refArea ?org_name 
  WHERE {
  ?observation <http://purl.org/linked-data/cube#dataSet> <http://nhs.publishmydata.com/data/place-pdw>.
  ?observation <http://nhs.publishmydata.com/def/measure-properties/score> ?value.
  ?observation <http://nhs.publishmydata.com/def/dimension/refOrganisation> ?refArea .
?refArea rdfs:label ?org_name
  }
  Group By ?refArea ?org_name
  HAVING ( ?count < 4 )'