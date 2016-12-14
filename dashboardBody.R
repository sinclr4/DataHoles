dashboard_body <- dashboardBody(
  
  tabItems(
    
    tabItem(tabName = 'intro',
            fluidRow(
              column(12, h1("Shiny Dataholes Firebreak"))),
            fluidRow(
              column(width = 6, 
                h3("This idea is to use R, Shiny and SPARQL to get the data from http://nhs.publishmydata.com to show the organisations that haven't provided us with all the data we need."))),
            fluidRow(
              column(width = 12,
                     imageOutput("logo")))),
    
    tabItem(tabName = 'system',
            fluidRow(
              column(12,
                h1("System Overview"))),
            fluidRow(
              infoBoxOutput("totalBox"),
              infoBoxOutput("totalDSBox"),
              infoBoxOutput("updatesBox"),
              infoBoxOutput("missingTrustsBox"))),
    
    tabItem(tabName = 'pdw',
            fluidRow(
              column(12, h1("Privacy, dignity and wellbeing"))),
            fluidRow(
              infoBoxOutput("pdwtotalBox")),
            fluidRow(
              column(12, 
                     tableOutput('pdwdatasets')))),
    
    tabItem(tabName = 'datasets', 
            fluidRow(
              column(12, h1("Datasets"))),
            fluidRow(
              column(12, p("List of all datasets currently in nhs.phublishmydata.com"))),
            fluidRow(
              column(12, tableOutput('datasets')))),
    
    tabItem(tabName = 'orgs', 
            fluidRow(
              column(12, h1("Trusts with most Missing Datapoints"))),
            fluidRow(
              column(12, tableOutput('orgsdatasets')))),
    
    tabItem(tabName = 'resultsViews',
            fluidRow(
              column(12, 
                     h1("Results Views"),
                     h3("This is a list of Results Views and associated Metric Groups in our existing Scorecard Database"),
                     h4(a("http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/resultsviews", 
                          href = "http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/resultsviews")))),
            fluidRow(
              column(12, tableOutput('resultsViews')))),
    
    tabItem(tabName = 'mentalHealthTrusts', 
            fluidRow(
              column(12, h1("Mental Health Trusts"),
                     h3("This is a list of Mental Health Trusts in our Scorecard Database"),
                     h4(a("http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/OrganisationsByResultsViewId/1054", 
                          href = "http://mynhs-scorecard-webapi-integration.azurewebsites.net/api/shinydataholes/OrganisationsByResultsViewId/1054")))),
            fluidRow(
              column(12, tableOutput('mentalHealthTrusts')))),

      tabItem(tabName = 'missingDatasets',
            fluidRow(
              column(12, h1("Missing Datapoints"))),
            fluidRow(
              column(12, uiOutput("datasetSelector"))),
            fluidRow(
              column(12, textOutput("selectedOption"))),
            fluidRow(
              column(12, tableOutput("pdwTable")))),
  
    tabItem(tabName = 'allTrusts',
            
            fluidRow(
              column(12, h1("Mental Health Trusts"),
                     p("This demostrates finding differences in datasets between out existing Scorecard Api and the data currently loaded into publishmydata."))),

            
            fluidRow(
              column(12,             
                     mainPanel(
                tabsetPanel(
                  tabPanel("Scorecard Api", 
                           fluidRow(
                             column(12, 
                                    h3("List of Mental Health Trusts in Scorecard Database"),
                                    textOutput("numberOfTrusts"),
                                    tableOutput("mentalHealthTrusts2")))),
                  tabPanel("Publish My Data",  
                           fluidRow(
                             column(12, 
                                    h3("List of Trusts in nhs.PublishMyData.com"),
                                    tableOutput('allTrusts')))),
                  tabPanel("Missing", 
                           fluidRow(
                             column(12, 
                                    h3("Missing Trusts"),
                                    textOutput("countMissingTrusts"),
                                    tableOutput("missingTrusts"))))
                )
              )
              ))
            )
                        

    )
           
  )

    