dashboard_body <-   dashboardBody(
  
  tabItems(
    
    tabItem(tabName = 'system',
            fluidRow( infoBoxOutput("totalBox")),
            fluidRow( infoBoxOutput("totalDSBox")),
            fluidRow( infoBoxOutput("updatesBox"))),
    
    tabItem(tabName = 'pdw',
            fluidRow( infoBoxOutput("pdwtotalBox")),
            fluidRow( tableOutput('pdwdatasets'))),
    
    tabItem(tabName = 'datasets', 
            fluidRow(tableOutput('datasets'))),
    
    tabItem(tabName = 'orgs', 
            fluidRow(tableOutput('orgsdatasets'))),
    
    tabItem(tabName = 'resultsViews', 
            fluidRow(tableOutput('resultsViews'))),
    
    tabItem(tabName = 'mentalHealthTrusts', 
            fluidRow(tableOutput('mentalHealthTrusts'))
    )
  )
)