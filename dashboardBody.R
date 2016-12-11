dashboard_body <-   dashboardBody(
  
  tabItems(
    
    tabItem(tabName = 'system',
            fluidRow( infoBoxOutput("totalBox")),
            fluidRow( infoBoxOutput("totalDSBox")),
            fluidRow( infoBoxOutput("updatesBox"))),
    
    tabItem(tabName = 'pdw',
            fluidRow(h1("Privacy, dignity and wellbeing")),
            fluidRow( infoBoxOutput("pdwtotalBox")),
            fluidRow( tableOutput('pdwdatasets'))),
    
    tabItem(tabName = 'datasets', 
            fluidRow(h1("Datasets")),
            fluidRow(p("List of all datasets currently in nhs.publishmydata.com")),
            fluidRow(tableOutput('datasets'))),
    
    tabItem(tabName = 'orgs', 
            fluidRow(h1("Most missing data")),
            fluidRow(tableOutput('orgsdatasets'))),
    
    tabItem(tabName = 'resultsViews',
            fluidRow(h1("Results Views")),
            fluidRow(tableOutput('resultsViews'))),
    
    tabItem(tabName = 'mentalHealthTrusts', 
            fluidRow(h1("Mental Health Trusts")),
            fluidRow(tableOutput('mentalHealthTrusts'))),

    tabItem(tabName = 'missingDatasets',
            fluidRow(h1("Missing Datapoints")),
            fluidRow(
              p("This will be a dynamic page. We can select from the dropdown and the output will change to reflect missing datapoints as per the current PDW tab."),
              p("The dropdown is currently populated such that the selectinput Id is the actual dataset endpoint reference. We can then modify the sparql query to use this a parameter to the query. This will be one of the next tasks on the to do list!")),
            uiOutput("datasetSelector"))
    )
  )