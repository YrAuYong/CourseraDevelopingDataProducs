require(shiny)
require(ggplot2)
require(rCharts)

shinyUI(
  navbarPage("Mortgage Calculator App",
    tabPanel("Calculate Now",
      fluidPage(
        h3("Mortgage Variable Inputs:"),
        fluidRow(
          column(6,
            numericInput('propValI', 'Property Value ($):', 300000),
            numericInput('downPayI', 'Down Payment ($):', 30000, min = 0),
            dateInput("startDateI", "Payment Start Date:", value = Sys.Date())
          ),
          column(6,
            sliderInput('interestI', 'Loan Interest rate (%):',value = 5.00, min = 0.00, max = 30.00, step = 0.01),
            radioButtons("yearsPayI", "Years to Complete Payment:",
              c("10" = 10,
                "20" = 20,
                "30" = 30),
              selected = 10
            )
          )
        ),
        fluidRow(
          column(10),
          column(2,
            submitButton('Calculate', width = '100%')
          )
        ),
        p("*Click on Calculate button to update results.", align = "right"),
        hr(),
        h3("Calculation Results:"),
        tabsetPanel(
          tabPanel("Summary",
            br(),
            fluidRow(
              column(4, offset = 2, strong("Property Value ($):")),
              column(4, textOutput("propValO")),
              column(2)
            ),
            fluidRow(
              column(4, offset = 2, strong("Down Payment ($):")),
              column(4, textOutput("downPayO")),
              column(2)
            ),
            fluidRow(
              column(4, offset = 2, strong("Down Payment (%):")),
              column(4, textOutput("downPayPercentO")),
              column(2)
            ),
            fluidRow(
              column(4, offset = 2, strong("Principle ($):")),
              column(4, textOutput("principleO")),
              column(2)
            ),
            fluidRow(
              column(4, offset = 2, strong("Loan Interest rate (%):")),
              column(4, textOutput("interestO")),
              column(2)
            ),
            fluidRow(
              column(4, offset = 2, strong("Years to Complete Payment:")),
              column(4, textOutput("yearsPayO")),
              column(2)
            ),            
            fluidRow(
              column(4, offset = 2, strong("Payment Start Date:")),
              column(4, textOutput("startDateO")),
              column(2)
            ),
            fluidRow(
              column(4, offset = 2, strong("Payment End Date:")),
              column(4, textOutput("endDateO")),
              column(2)
            ),
            fluidRow(
              column(4, offset = 2, strong("Payment Per Month ($):")),
              column(4, textOutput("payPerMonthO")),
              column(2)
            ),
            fluidRow(
              column(4, offset = 2, strong("Total Interest Payment of Loan ($):")),
              column(4, textOutput("ttlInterestO")),
              column(2)
            ),
            fluidRow(
              column(4, offset = 2, strong("Total Payment of Loan ($):")),
              column(4, textOutput("ttlPaymentO")),
              column(2)
            ),
            hr()
          ), 
          tabPanel("Annual Table", dataTableOutput("annualTbl")), 
          tabPanel("Monthly Table",
            dataTableOutput("monthlyTbl")),
          tabPanel("Visualisation",
            h4('Mortgage Payment Chart by Month', align = "center"),
            h5('Please hover over each point to see Interest and Principle values by month.', align ="center"),
            p('Payment ($)'),
            showOutput("pymtChart", "morris"),
            p('Date', align = "center")
          )
        )
      )
    ),
    tabPanel("Documentation",
      h4("Usage description for 'Mortgage Calculator App'"),
      tags$ol(
        tags$li("Click on 'Calculate Now' at the navigation bar to go to the application page."),
        tags$li("At the application page, fill in the input values under the 'Mortgage Variable Inputs:' section."),
        tags$li("When you are satisfied with your input values, click the 'Calculate' button to update the 'Calculation Results' section with the latest input values."),
        tags$li("Click on the various tab panels to view the various calculation results:"),
        tags$ul(
          tags$li("The 'Summary' tab includes a summary of the mortgage details and calculated monthly payment value."),
          tags$li("The 'Annual Table' tab shows the estimated interest and principle payment values as well as remaining balance for each year."),
          tags$li("The 'Monthly Table' tab shows the estimated interest and principle payment values as well as remaining balance for each month."),
          tags$li("The 'Visualisation' tab displays an interactive Mortgage Payment Chart by Month")
        ),
        tags$li("To update the calculation results with new input values, restart from step 1 and remember to click on the 'Calculate' button again.")
      )
    ),
    tabPanel("About App",
      h4("OverView:"),
      p("This application is a coursework project for the Developing Data Product module of the Coursera Data Science Specialisation. Mortgage calculation is based on formulas found in http://www.hughcalc.org/formula.php where mortgages are compounded monthly. The calculations have been tested randomly up to property value $8.5million with variations of other input values."),
      h4("Author:"), p(" Yuri Au Yong"),
      h4("Application Last Update Date:"), p(" 25th December 2015"),
      h4("Disclaimer:"), p(" This Application is meant to give a fair estimate on mortages payments and may not be 100% accurate.")
    )
  )  
)