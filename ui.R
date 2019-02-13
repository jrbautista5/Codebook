#ui
library(tidyverse)
library(shiny)

#Create variables for those that need selector inputs, will make it easier in the code.
Years <- names(table(LA$Year))

fluidPage(
  h1("BIOS 685 ShinyApp"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "Year",
                  label = "Select a year:",
                  choices = Years,
                  selected = "2018"),
      selectInput(inputId = "PayType",
                  label = "What kind of pay do you want to observe?",
                  choices = c("Base.Pay", "Overtime.Pay", "Other.Pay"),
                  selected = "Base.Pay"),
      numericInput(inputId = "n",
                   label = "How many observations do you want to see?",
                   value = 10,
                   min = 1, max = 25, step = 1),
      selectInput(inputId = "method",
                  label = "Choose a measure:",
                  choices = c("Mean_Pay", "Median_Pay"),
                  selected = "Median_Pay")),
  mainPanel(
    hr("Payroll of LA Workers"),
    plotOutput("plot"),
    hr("Table of the highest paid individuals:"),
    tableOutput("top_earner"),
    hr("Departments which earn the most (mean/median):"),
    tableOutput("top_Dpt"),
    hr("Departments which cost the most (total)"),
    tableOutput("topCost_Dpt"),
    hr("Median Pay Over Time"),
    plotOutput("MedPOT")
  )
))














