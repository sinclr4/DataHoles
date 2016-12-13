dashboard_body <-   dashboardBody(
  
  tabItems(
    
    tabItem(tabName = 'intro',
            fluidRow(h1("Shiny Dataholes Firebreak")),
            fluidRow(
              div("This idea is to use R, Shiny and SPARQL to get the data from http://nhs.publishmydata.com"), 
               div(" to show the organisations that haven't provided us with all the data we need.")),
    imageOutput("logo")),
    tabItem(tabName = 'system',
            fluidRow(h1("System Overview")),
             infoBoxOutput("totalBox"),
             infoBoxOutput("totalDSBox"),
             infoBoxOutput("updatesBox")),
    
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
              p("The dropdown is currently populated such that the selectinput Id is the actual dataset endpoint reference. We can then modify the sparql query to use this a parameter to the query. This will be one of the next tasks on the to do list!"),
              p("Managed to parameterise the query, now we just need to make the table reactive...")),
            # selectInput("selectedOptionId", 
            #             label = "Choose a dataset to display",
            #             choices = vector_select_options),
              textOutput("selectedOption"),
           uiOutput("datasetSelector"),
            
           fluidRow(tableOutput("pdwTable"))
           )
          
    )
  )