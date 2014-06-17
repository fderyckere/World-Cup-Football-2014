library(shiny)

data <- read.csv("world cup teams and players.csv")
data <- transform(data, Team = factor(Team), Position = factor(Position))

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
        
        # Application title.
        headerPanel("World Cup Football 2014"),
        
        # Selection of the team of your country
        sidebarPanel(
                selectInput("team", "Select your country:",
                            levels(data$Team), selected="Belgium")
        ),
        
        # Show an overview of the weight and height of the players of your team.
        mainPanel(
                p('This application compares the players of your national football team to all other players in competition.'),
                p('Just select your country and have a look at how tall and heavy your country\'s players are.'),
                p('-'),
                h4("Height and weight of the players of your team compared to the players of all other teams"),
                h4(textOutput('caption')),
                plotOutput('TeamSize')
        )
))
        
        
