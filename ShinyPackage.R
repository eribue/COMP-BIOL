#Shiny package
#November 28 2018

#shinyApp is an R package builds interactive web apps
#uses R coding and web interactiveness to create a reactive experience
#ui; user interface: this is the control to create a reactive experience
#server: the coding instructions for the shiny app
#control widgets: web elements that users will interact with

library(shiny)
#define ui-- 
ui<- fluidPage(
  titlePanel(""),
  sidebarLayout(
sidebarPanel(),
mainPanel()
  )
  )
#define server 
server<- function(input, output){
}

#run the app
shinyApp(ui=ui, server=server)

#example
ui<- fluidPage (
  #add title
  titlePanel("This is a test shiny"),
  sidebarLayout(position = "right",
                sidebarPanel(
                h1("this is my first header"),
                h2("this is my second header"),
                selectInput("x", label="x", names(trees)),
                selectInput("y", label="y", names(trees))),
                mainPanel(
                  h1("header"),
                  strong("this is important text"),
                  p("this is a paragraph"),
                  br(),
                  #add images
                  img(src="ant.jpeg", height=75, width=75),
                  plotOutput("TreePlot"))))
                  
server<- function(input, output) {
  selectedData<- reactive({
    trees[,c(input$x, output$y)]
    })
  #use render plot function to add reactive element
  output$Treeplot<- renderPlot({
    #basic plot function
    plot(selectedData(),
         type= "p",
         #change point: pch values stored plot: 21.25
         pch=21.25,
         col="black",
         bg= "blue",
         #add a main title
         main= "title",
         #subtitle
         sub= "This is a good place to put a caption")
  }
  )
  }

#call to shiny app
shinyApp(ui=ui, server=server)

