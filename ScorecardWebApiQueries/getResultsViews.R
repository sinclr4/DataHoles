#Get List of Results Views

resultsViewsRaw <- GET("http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/resultsviews")
resultsViewsData <- jsonlite::fromJSON(content(resultsViewsRaw, as="text"),  flatten=TRUE)