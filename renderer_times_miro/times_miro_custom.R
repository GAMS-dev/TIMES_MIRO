times_miroOutput <- function(id, height = NULL, options = NULL, path = NULL){
  ns <- NS(id)
  
  # set default height
  if(is.null(height)){
    height <- 700
  } 
  tagList( 
    #define rendererOutput function here 
    tabsetPanel(
      id = ns("Switch"),
      type = "tabs",
      
      # Process Tab
      tabPanel("Process centric view",
               sidebarLayout(
                 sidebarPanel(
                   uiOutput(ns("select_prc"))
                 ),
                 mainPanel(
                   fluidRow(
                     h3(textOutput(ns("prc"))),
                     
                     tableOutput(ns("data_prc"))
                   ),
                   
                   br(),
                   
                   # Process View. Flowchart
                   fluidRow(
                     column(width = 3,
                            uiOutput(ns("prc_in"))
                     ),
                     column(width = 2,
                            icon("arrow-right")
                     ),
                     column(width = 2,
                            uiOutput(ns("sel_button_prc"))
                     ),
                     column(width = 2,
                            icon("arrow-right")
                     ),
                     column(width = 3,
                            uiOutput(ns("prc_out"))
                     )
                   ),
                   
                   # Data View process
                   fluidRow(
                     br(),
                     
                     tableOutput(ns("Data_prc")),
                     
                     br()
                   )
                 )
               ),
               icon = icon("cogs")),
      
      # Commodity Tab
      tabPanel(ns("Commodity centric view"),
               sidebarLayout(
                 sidebarPanel(
                   uiOutput(ns("select_com"))
                 ),
                 mainPanel(
                   fluidRow(
                     h3(textOutput(ns("com"))),
                     
                     tableOutput(ns("data_com"))
                   ),
                   
                   br(),
                   
                   # Commodity View. Flowchart
                   fluidRow(
                     column(width = 4,
                            uiOutput(ns("com_in"))
                     ),
                     column(width = 1,
                            icon("arrow-right")
                     ),
                     column(width = 2,
                            uiOutput(ns("sel_button_com"))
                     ),
                     column(width = 1,
                            icon("arrow-right")
                     ),
                     column(width = 4,
                            uiOutput(ns("com_out"))
                     )
                   ),
                   
                   # Data commodity view
                   fluidRow(
                     br(),
                     
                     tableOutput(ns("Data_com")),
                     
                     br()
                   )
                 )
               ),
               icon = icon("coins")
      )
    )
  ) 
}

renderTimes_miro <- function(input, output, session, data, options = NULL, path = NULL, rendererEnv = NULL, ...){
  
  # Create inputs first
  data$PRC <- as.character(data$PRC)
  data$COM_GRP <- as.character(data$COM_GRP)
  data$IO <- as.character(data$.i12)
  processes <- reactive({data %>% 
      dplyr::filter(siName == "TOP") %>% 
      dplyr::pull(PRC) %>% 
      unique() %>% 
      sort()})
  
  commodities <- reactive({data %>% 
      dplyr::filter(siName == "TOP") %>% 
      dplyr::pull(COM_GRP) %>% 
      unique() %>% 
      sort()})
  
  output$select_prc <- renderUI({
    selectInput("prc", 
                "Select process",
                processes(),
                "")
  })
  
  output$select_com <- renderUI({
    selectInput("com", 
                "Select commodity",
                processes(),
                "")
  })
  
  
  # Color of Letter
  cols <- c("green", "yellow", "red", "blue", "white")
  purrr::mapping_cols_com <- sample(cols, length(LETTERS), replace = TRUE)
  purrr::mapping_cols_prc <- sample(cols, length(LETTERS), replace = TRUE)
  names(purrr::mapping_cols_com) <- LETTERS
  names(purrr::mapping_cols_prc) <- LETTERS
  
  # Create a reactive for selected process and commodity
  prc_com_in <- reactive({
    data %>% 
      dplyr::filter(PRC == input$prc, IO == "IN", siName == "TOP") %>% 
      dplyr::pull(COM_GRP)
  })
  
  prc_com_out <- reactive({
    data %>% 
      dplyr::filter(PRC == input$prc, IO == "OUT", siName == "TOP") %>% 
      dplyr::pull(COM_GRP)
  })
  
  com_prc_in <- reactive({
    dplyr::data %>% 
      dplyr::filter(COM_GRP == input$com, IO == "OUT", siName == "TOP") %>% 
      dplyr::pull(PRC)
  })
  
  com_prc_out <- reactive({
    data %>% 
      dplyr::filter(COM_GRP == input$com, IO == "IN", siName == "TOP") %>% 
      dplyr::pull(PRC)
  })
  
  # Observer
  rendererEnv[[ns("comBtn")]] <- observe({
    input$com_button
    updateTabsetPanel(session, "Switch", selected = "Commodity centric view")
    updateSelectInput(session, "com", selected = input$com_button)
  })
  rendererEnv[[ns("prcBtn")]] <- observe({
    input$prc_button
    updateTabsetPanel(session, "Switch", selected = "Process centric view")
    updateSelectInput(session, "prc", selected = input$prc_button)
  })
  
  # Render buttons
  # Processes
  output$prc_in <- renderUI({
    purrr::map(prc_com_in(), ~ tags$button(id = paste0("com_", .x), .x, 
                                           onclick = paste0("Shiny.setInputValue('com_button', '", .x, "')")))
  })
  
  output$prc_out <- renderUI({
    purrr::map(prc_com_out(), ~ tags$button(id = paste0("com_", .x), .x, 
                                            onclick = paste0("Shiny.setInputValue('com_button', '", .x, "')")))
  })
  
  # Commodities
  output$com_in <- renderUI({
    purrr::map(com_prc_in(), ~ tags$button(id = paste0("prc_", .x), .x, 
                                           onclick = paste0("Shiny.setInputValue('prc_button', '", .x, "')")))
  })
  
  output$com_out <- renderUI({
    purrr::map(com_prc_out(), ~ tags$button(id = paste0("prc_", .x), .x, 
                                            onclick = paste0("Shiny.setInputValue('prc_button', '", .x, "')")))
  })
  
  output$prc_in <- renderUI({
    tags$ul(purrr::map(prc_com_in(), ~ tags$li(
      id = paste0("com_", .x), .x,
      onclick = paste0("Shiny.setInputValue('com_button', '", .x, "', {priority: 'event'})"),
      style = paste0("display:block; width:100%; border: 1px solid black; background: ", purrr::mapping_cols_prc[substr(.x, 1, 1)], ";"))),
      style = "list-style-type:none;")
  })
  
  output$prc_out <- renderUI({
    tags$ul(purrr::map(prc_com_out(), ~ tags$li(
      id = paste0("com_", .x), .x,
      onclick = paste0("Shiny.setInputValue('com_button', '", .x, "', {priority: 'event'})"),
      style = paste0("display:block; width:100%; border: 1px solid black; background: ", purrr::mapping_cols_prc[substr(.x, 1, 1)], ";"))),
      style = "list-style-type:none;")
  })
  
  output$com_in <- renderUI({
    tags$ul(purrr::map(com_prc_in(), ~ tags$li(
      id = paste0("prc_", .x), .x,
      onclick = paste0("Shiny.setInputValue('prc_button', '", .x, "', {priority: 'event'})"),
      style = paste0("display:block; width:100%; border: 1px solid black; background: ", purrr::mapping_cols_com[substr(.x, 1, 1)], ";"))),
      style = "list-style-type:none;")
  })
  
  output$com_out <- renderUI({
    tags$ul(purrr::map(com_prc_out(), ~ tags$li(
      id = paste0("prc_", .x), .x,
      onclick = paste0("Shiny.setInputValue('prc_button', '", .x, "', {priority: 'event'})"),
      style = paste0("display:block; width:100%; border: 1px solid black; background: ", purrr::mapping_cols_com[substr(.x, 1, 1)], ";"))),
      style = "list-style-type:none;")
  })
  
  output$sel_button_prc <- renderUI(actionButton("sel_button_prc", input$prc))
  output$sel_button_com <- renderUI(actionButton("sel_button_com", input$com))
  
  # Select data
  # Process centric view
  output$Data_prc <- renderTable(data %>% 
                                   dplyr::filter(siName != "TOP", PRC == input$prc))
  
  # Commodity centric view
  output$Data_com <- renderTable(data %>% 
                                   dplyr::filter(siName != "TOP", COM_GRP == input$com))
  
  # Header of the flowchart
  output$prc <- renderText(input$prc)
  output$com <- renderText(input$com)
  
  # Data in the Header
  data_prc <- reactive({
    data_prc_temp <- purrr::map(col_names_header, ~ {
      string_prc <- data %>% 
        dplyr::filter(siName != "TOP", PRC == input$prc) %>% 
        dplyr::pull(.x) %>% unique()
      string_prc <- string_prc[!grepl("-", string_prc)]
      paste0(string_prc, collapse = ", ")
    })
    
    data_prc_temp <- purrr::reduce(data_prc_temp, rbind.data.frame)
    rownames(data_prc_temp) <- names_header
    colnames(data_prc_temp) <- ""
    return(data_prc_temp)
    
  })
  
  output$data_prc <- renderTable(data_prc(), rownames = TRUE, colnames = FALSE)
  
  data_com <- reactive({
    data_com_temp <- purrr::map(col_names_header, ~ {
      string_com <- data %>% 
        dplyr::filter(siName != "TOP", COM_GRP == input$com) %>% 
        dplyr::pull(.x) %>% unique()
      string_com <- string_com[!grepl("-", string_com)]
      paste0(string_com, collapse = ", ")
    })
    
    data_com_temp <- purrr::reduce(data_com_temp, rbind.data.frame)
    rownames(data_com_temp) <- names_header
    return(data_com_temp)
    
  })
  
  output$data_com <- renderTable(data_com(), rownames = TRUE, colnames = FALSE)
}