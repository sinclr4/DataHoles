dashboard_sidebar <-   dashboardSidebar(
  sidebarMenu(
    menuItem("System Overview Dashboard", tabName = "system", icon = icon("dashboard")),
    menuItem("Privacy, Dignity & Wellbeing", tabName = "pdw", icon = icon("dashboard")),
    menuItem("Worst Mental Health Orgs", tabName = "orgs", icon = icon("dashboard")),
    menuItem("Datasets", tabName = "datasets", icon = icon("th")),
    menuItem("Results Views", tabName = "resultsViews", icon = icon("th")),
    menuItem("Mental Health Trusts", tabName = "mentalHealthTrusts", icon = icon("th"), badgeLabel = "new", badgeColor = "green")
  )
)