library(shiny)
library(dplyr)
library(ggiraph)
library(ggplot2)
library(shinycssloaders)
library(thematic)
library(DT)
library(bslib)
library(RColorBrewer)


pizza_v <- c("Margarita" = 0.2, "Toscana" = 1, "Romana" = 1, "Tropical" = 0.02, "Serrana" = 1, "Barbacoa" = 1,
             "Vegetal" = 1, "Tonyina" = 1, "4 Formatges" = 1, "Mexicana" = 1, "4 Estaciones (sin anchois)" = 1,
             "Alemana" = 1, "Mediterrana" = 1)

susannas_pizzas <- c(names(pizza_v)[c(7, 11, 13)])

ui <- fluidPage(
    theme = bs_theme(bootswatch = "lumen"),
    title = "Pizza sampler",

    titlePanel("Pizza sampler"),

    sliderInput("n_pizzas", value = 1, min = 1, max = 20, label = "How many pizzas do you need"),

    checkboxInput(inputId = "susanna", label = "Is Susanna eating with us", value = FALSE),

    tableOutput("pizzas")

    #includeMarkdown("readme.md")

)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output[["pizzas"]] <- renderTable({

        sampled_pizzas <- sample(x = names(pizza_v), size = input[["n_pizzas"]],
               replace = TRUE, prob = pizza_v)


        if(input[["susanna"]])
            sampled_pizzas[1] <- sample(susannas_pizzas, 1)

        table(sampled_pizzas) %>%
            data.frame() %>%
            setNames(c("Pizza name", "Quantity")) %>%
            arrange("Pizza name")
    })

}


# Run the application
shinyApp(ui = ui, server = server)
