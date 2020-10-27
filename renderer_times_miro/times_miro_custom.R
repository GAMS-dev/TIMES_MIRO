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
                   uiOutput(ns("sel_prc"))
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
                   uiOutput(ns("sel_com"))
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
  
  force(data)
  # Create inputs first
  data <- mutate_if(data, is.factor, as.character)
  print(data)
  print("###########################")
  
  processes <- reactive({data %>% 
      dplyr::filter(siname == "TOP") %>% 
      dplyr::pull(prc) %>% 
      unique() %>% 
      sort()})
  
  commodities <- reactive({data %>% 
      dplyr::filter(siname == "TOP") %>% 
      dplyr::pull(com_grp) %>% 
      unique() %>% 
      sort()})
  
  output$sel_prc <- renderUI({
    
    selectInput(inputId = session$ns("prc"), 
                label = "Select process",
                choices = processes(),
    )
    
  })
  
  output$sel_com <- renderUI({
    
    selectInput(inputId = session$ns("com"), 
                label = "Select commodity",
                choices = commodities(),
    )
    
  })
  
  print(session$ns("prc"))
  print(session$ns("com"))
  print("####################################")
  # print(data %>% dplyr::filter(com_grp == session$ns("com")) %>% dplyr::pull(prc))
  print("####################################")
  
  
  # Color of Letter
  cols <- c("green", "yellow", "red", "blue", "white")
  mapping_cols_com <- sample(cols, length(LETTERS), replace = TRUE)
  mapping_cols_prc <- sample(cols, length(LETTERS), replace = TRUE)
  names(mapping_cols_com) <- LETTERS
  names(mapping_cols_prc) <- LETTERS
  
  # Create a reactive for selected process and commodity
  prc_com_in <- reactive({
    
    req(input$prc)
    data %>% 
      dplyr::filter(prc == input$prc, uni == "IN", siname == "TOP") %>% 
      dplyr::pull(com_grp)
    
  })
  
  prc_com_out <- reactive({
    
    req(input$prc)
    data %>% 
      dplyr::filter(prc == input$prc, uni == "OUT", siname == "TOP") %>% 
      dplyr::pull(com_grp)
    
  })
  
  com_prc_in <- reactive({
    
    req(input$com)
    data %>% 
      dplyr::filter(com_grp == input$com, uni == "OUT", siname == "TOP") %>% 
      dplyr::pull(prc)
    
  })
  
  com_prc_out <- reactive({
    
    req(input$com)
    data %>% 
      dplyr::filter(com_grp == input$com, uni == "IN", siname == "TOP") %>% 
      dplyr::pull(prc)
    
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
  # output$prc_in <- renderUI({
  #   purrr::map(prc_com_in(), ~ tags$button(id = session$ns(paste0("com_", .x)), .x, 
  #                                          onclick = paste0("Shiny.setInputValue('com_button', '", .x, "')")))
  # })
  # 
  # output$prc_out <- renderUI({
  #   purrr::map(prc_com_out(), ~ tags$button(id = session$ns(paste0("com_", .x)), .x, 
  #                                           onclick = paste0("Shiny.setInputValue('com_button', '", .x, "')")))
  # })
  # 
  # # Commodities
  # output$com_in <- renderUI({
  #   purrr::map(com_prc_in(), ~ tags$button(id = session$ns(paste0("prc_", .x)), .x, 
  #                                          onclick = paste0("Shiny.setInputValue('prc_button', '", .x, "')")))
  # })
  # 
  # output$com_out <- renderUI({
  #   purrr::map(com_prc_out(), ~ tags$button(id = session$ns(paste0("prc_", .x)), .x, 
  #                                           onclick = paste0("Shiny.setInputValue('prc_button', '", .x, "')")))
  # })
  
  output$prc_in <- renderUI({
    tags$ul(purrr::map(prc_com_in(), ~ tags$li(
      id = session$ns(paste0("com_", .x)), .x,
      onclick = paste0("Shiny.setInputValue('", session$ns("com_button"), "', '", .x, "', {priority: 'event'})"),
      style = paste0("display:block; width:100%; border: 1px solid black; background: ", mapping_cols_prc[substr(.x, 1, 1)], ";"))),
      style = "list-style-type:none;")
  })
  
  output$prc_out <- renderUI({
    tags$ul(purrr::map(prc_com_out(), ~ tags$li(
      id = paste0("com_", .x), .x,
      onclick = paste0("Shiny.setInputValue('", session$ns("com_button"), "', '", .x, "', {priority: 'event'})"),,
      style = paste0("display:block; width:100%; border: 1px solid black; background: ", mapping_cols_prc[substr(.x, 1, 1)], ";"))),
      style = "list-style-type:none;")
  })
  
  output$com_in <- renderUI({
    tags$ul(purrr::map(com_prc_in(), ~ tags$li(
      id = paste0("prc_", .x), .x,
      onclick = paste0("Shiny.setInputValue('", session$ns("prc_button"), "', '", .x, "', {priority: 'event'})"),,
      style = paste0("display:block; width:100%; border: 1px solid black; background: ", mapping_cols_com[substr(.x, 1, 1)], ";"))),
      style = "list-style-type:none;")
  })
  
  output$com_out <- renderUI({
    tags$ul(purrr::map(com_prc_out(), ~ tags$li(
      id = paste0("prc_", .x), .x,
      onclick = paste0("Shiny.setInputValue('", session$ns("prc_button"), "', '", .x, "', {priority: 'event'})"),,
      style = paste0("display:block; width:100%; border: 1px solid black; background: ", mapping_cols_com[substr(.x, 1, 1)], ";"))),
      style = "list-style-type:none;")
  })
  
  output$sel_button_prc <- renderUI(actionButton("sel_button_prc", input$prc))
  output$sel_button_com <- renderUI(actionButton("sel_button_com", input$com))
  
  # Select data
  # Process centric view
  output$Data_prc <- renderTable(data %>% 
                                   dplyr::filter(siname != "TOP", prc == input$prc))
  
  # Commodity centric view
  output$Data_com <- renderTable(data %>% 
                                   dplyr::filter(siname != "TOP", com_grp == input$com))
  
  # Header of the flowchart
  output$prc <- renderText(input$prc)
  output$com <- renderText(input$com)
  
  # Data in the Header
  data_prc <- reactive({
    req(input$prc)
    data_prc_temp <- purrr::map(col_names_header, ~ {
      string_prc <- data %>% 
        dplyr::filter(siname != "TOP", prc == input$prc) %>% 
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
  
  names_header <- c("Scenario", "Sector", "Type", "Activity Unit", "Timeslice LVL")
  col_names_header <- c("dd", "uni#2", "uni#1", "uni", "all_ts")
  data_com <- reactive({
    req(input$com)
    data_com_temp <- purrr::map(col_names_header, ~ {
      string_com <- data %>% 
        dplyr::filter(siname != "TOP", com_grp == input$com) %>% 
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