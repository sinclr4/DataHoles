dashboard_body <- dashboardBody(
  
  tabItems(
    
    tabItem(tabName = 'intro',
            fluidRow(h1("Shiny Dataholes Firebreak")),
            fluidRow(
              h3("This idea is to use R, Shiny and SPARQL to get the data from http://nhs.publishmydata.com"), 
              h3(" to show the organisations that haven't provided us with all the data we need.")),
    imageOutput("logo")),
    
    tabItem(tabName = 'system',
            fluidRow(h1("System Overview")),
             infoBoxOutput("totalBox"),
             infoBoxOutput("totalDSBox"),
             infoBoxOutput("updatesBox"),
             infoBoxOutput("missingTrustsBox")),
    
    tabItem(tabName = 'pdw',
            fluidRow(h1("Privacy, dignity and wellbeing")),
            fluidRow( infoBoxOutput("pdwtotalBox")),
            fluidRow( tableOutput('pdwdatasets'))),
    
    tabItem(tabName = 'datasets', 
            fluidRow(h1("Datasets")),
            fluidRow(p("List of all datasets currently in nhs.phublishmydata.com")),
            fluidRow(tableOutput('datasets'))),
    
    tabItem(tabName = 'orgs', 
            fluidRow(h1("Most missing data")),
            fluidRow(tableOutput('orgsdatasets'))),
    
    tabItem(tabName = 'resultsViews',
            fluidRow(
              h1("Results Views"),
              h3("This is a list of Results Views and associated Metric Groups in our existing Scorecard Database"),
              h4(a("http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/resultsviews", 
                   href = "http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/resultsviews"))),
            fluidRow(tableOutput('resultsViews'))),
    
    tabItem(tabName = 'mentalHealthTrusts', 
            fluidRow(
              h1("Mental Health Trusts"),
              h3("This is a list of Mental Health Trusts in our Scorecard Database"),
              h4(a("http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/OrganisationsByResultsViewId/1054", 
                   href = "http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/OrganisationsByResultsViewId/1054"))
              ),
            fluidRow(tableOutput('mentalHealthTrusts'))),

      tabItem(tabName = 'missingDatasets',
            fluidRow(
              h1("Missing Datapoints")),
            fluidRow(
              textOutput("selectedOption"),
              uiOutput("datasetSelector")),
            fluidRow(
              tableOutput("pdwTable"))),
  
    tabItem(tabName = 'allTrusts',
            
            fluidRow(
              h1("Mental Health Trusts"),
              p("This demostrates finding differences in datasets between out existing Scorecard Api and the data currently loaded into publishmydata.")
            ),
            
            mainPanel(
              tabsetPanel(
                tabPanel("Scorecard Api", 
                   fluidRow(
                     h3("List of Mental Health Trusts in Scorecard Database"),
                     textOutput("numberOfTrusts"),
                      tableOutput("mentalHealthTrusts2"))),
                tabPanel("Publish My Data",  
                   fluidRow(
                     h3("List of Trusts in nhs.PublishMyData.com"),
                     tableOutput('allTrusts'))),
                tabPanel("Missing", 
                   fluidRow(
                     h3("Missing Trusts"),
                     textOutput("countMissingTrusts"),
                     tableOutput("missingTrusts")))
                )
              )
            )
    )
           
  )

    