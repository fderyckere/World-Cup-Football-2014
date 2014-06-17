library(shiny)
#library(datasets)

# We tweak the "am" field to have nicer factor labels. Since this doesn't
# rely on any user inputs we can do this once at startup and then use the
# value throughout the lifetime of the application
data <- read.csv("world cup teams and players.csv")
data <- transform(data, Team = factor(Team), Position = factor(Position))

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {

        # Return the input
        output$caption <- renderText({paste("Your team:", toupper(input$team))})

        # Generate a plot with the players of the country compared to all the players
        output$TeamSize <- renderPlot({
                d <- subset(data, Team==input$team)
                plot(as.numeric(data$Height), 
                     as.numeric(data$Weight), 
                     xlab="Height",
                     ylab="Weight",
                     col=rgb(.10,.10,.10,.10), 
                     frame=FALSE)
                points(jitter(as.numeric(d$Height)), 
                     jitter(as.numeric(d$Weight)),
                     col=d$Position,
                     pch=19)
                legend("topleft", levels(data$Position), col=1:4, pch=19)
                abline(lm(Weight~Height, data), col=rgb(.25,.25,.25))
          }, height = 400, width = 600)
})
