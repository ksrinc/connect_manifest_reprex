library(shiny)
library(ggplot2)
library(palmerpenguins)
library(fs)  # For directory listing

# Define UI
ui <- fluidPage(
  titlePanel("Shiny App with External Data: Palmer Penguins"),
  sidebarLayout(
    sidebarPanel(
      # No inputs in this example
    ),
    mainPanel(
      plotOutput("plot"),
      verbatimTextOutput("file_list")
    )
  )
)

# Define server
server <- function(input, output) {
  
  # Load external data (penguins dataset)
  data_path <- "data_1/penguins.csv"  # Update with your actual path
  external_data <- read.csv(data_path)
  
  # List files and folders in the root directory
  root_files <- dir_ls(path = ".", recurse = FALSE)
  
  # Create a ggplot using the external data
  output$plot <- renderPlot({
    ggplot(external_data, aes(x = species, y = bill_length_mm, color = species)) +
      geom_boxplot() +
      labs(title = "Boxplot of Bill Length by Species")
  })
  
  # Display the list of files and folders
  output$file_list <- renderPrint({
    cat("Files and folders in the root directory:\n")
    for (item in root_files) {
      cat(as.character(item), "\n")
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)


