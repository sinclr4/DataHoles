#Get Mental Health Trusts

organisationsRaw <- GET("http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/OrganisationsByResultsViewId/1054")
organisationsData <- jsonlite::fromJSON(content(organisationsRaw, as="text"),  flatten=TRUE)