mirowidget_scenddmapOutput <- function(id, height = NULL, options = NULL, path = NULL){
  ns <- NS(id)
  
  tagList(
    tags$div(class = "custom-widget",
      tabsetPanel(
        tabPanel("Model setup",
                 tags$div(class = "col-sm-12 col-lg-8 custom-8",
                          tags$div(class = "col-sm-12 col-md-6",
                                   tags$div(class="table-header",
                                            tags$h4(tags$span("DD Files order / Read "),
                                                    tags$span(class = "info-label-nowrap", "$offEps", tags$a("",
                                                                                                             title = "order: 0 = ignore DD file. Do not delete a table row when the DD info is used elsewhere (input data); $offEps: Do not interpret zero values as EPS. - Open documentation", 
                                                                                                             class = "info-wrapper",
                                                                                                             href = "https://www.gams.com/latest/docs/UG_DollarControlOptions.html#DOLLARonoffeps",
                                                                                                             tags$span(
                                                                                                               class = "fas fa-info-circle", class = "info-icon",
                                                                                                               role = "presentation",
                                                                                                               `aria-label` = "More information"
                                                                                                             ), target = "_blank"
                                                    ))),
                                   ),
                                   tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                            actionButton(ns("addScenddmap"), label = NULL, 
                                                         icon = icon("circle-plus"), 
                                                         class = "add-row-btn")
                                   ),
                                   tags$div(class = "table-styles",
                                            rHandsontableOutput(ns('scenddmap'))
                                   )
                          ),
                          tags$div(class = "col-sm-12 col-md-6",
                                   tags$h4("Additional statements in run file", class="table-header"),
                                   tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                            actionButton(ns("addStatements"), label = NULL, 
                                                         icon = icon("circle-plus"), 
                                                         class = "add-row-btn")
                                   ),
                                   tags$div(class = "table-styles",
                                            rHandsontableOutput(ns('additionalStatements'))
                                   )
                          )
                 ),
                 tags$div(class = "col-sm-12 col-lg-4 custom-4",
                          tags$h4("Years for model run ('milestonyr')", class="table-header"),
                          tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                   actionButton(ns("addMilestonyr"), label = NULL, 
                                                icon = icon("circle-plus"), 
                                                class = "add-row-btn")
                          ),
                          tags$div(class = "table-styles",
                                   rHandsontableOutput(ns('milestonyr'))
                          ),
                          tags$div(class = "table-styles",
                                   rHandsontableOutput(ns('boEoTime'))
                          ),
                          tags$div(class = "table-styles",
                                   rHandsontableOutput(ns('timeslice'))
                          )
                 )
        ),
        tabPanel("Options / Extensions",
                 column(12, class = "col-xs-12 col-sm-12 col-md-6 col-lg-4",
                        uiOutput(ns("col1"))
                 ),
                 column(12, class = "col-xs-12 col-sm-12 col-md-6 col-lg-4",
                        uiOutput(ns("col2"))
                 ),
                 column(12, class = "col-xs-12 col-sm-12 col-md-6 col-lg-4",
                        uiOutput(ns("col3"))
                 )
        ),
        tabPanel("Solver options",
                 column(12, class = "col-xs-12 col-sm-12 col-md-6 col-lg-4",
                        tags$h4("Solver options", class="table-header"),
                        tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                 actionButton(ns("addSolveropt"), label = NULL, 
                                              icon = icon("circle-plus"), 
                                              class = "add-row-btn")
                        ),
                        tags$div(class = "table-styles",
                                 rHandsontableOutput(ns('solveropt'))
                        )
                 ),
                 column(12, class = "col-xs-12 col-sm-12 col-md-6 col-lg-6",
                        tags$div(class = "col-sm-6 custom-2",
                                 selectInput(ns("gmssolver"), tags$h4("Solver to use"), c("cplex", "cbc", "conopt", "conopt4"), selected = "cplex"),
                                 numericInput(ns("gmsreslim"), tags$h4("Time limit for solve [seconds]"), 
                                              min = 10, max = 36000, value = 1000L, step = 1)
                        ),
                        tags$div(class = "col-sm-6 custom-2",
                                 sliderInput(ns("gmsbratio"), label = tags$div(
                                   tags$h4("Basis indicator (bRatio)", tags$a("",
                                                                              title = "The value specified for bRatio will cause a basis to be discarded if the number of basic variables is smaller than bRatio times the number of equations. - Open documentation", 
                                                                              class = "info-wrapper",
                                                                              href = "https://www.gams.com/latest/docs/UG_GamsCall.html#GAMSAObratio",
                                                                              tags$span(
                                                                                class = "fas fa-info-circle", class = "info-icon",
                                                                                role = "presentation",
                                                                                `aria-label` = "More information"
                                                                              ), target = "_blank"
                                   )),
                                 ), min = 0, max = 1, value = 1, step = 0.01)
                        )
                 )
        )
      )
    )
  )
  
}

renderMirowidget_scenddmap <- function(input, output, session, data, options = NULL, 
                                       path = NULL, rendererEnv = NULL, views = NULL, 
                                       attachments = NULL, outputScalarsFull = NULL, ...){
  ns <- session$ns
  
  
  rv <- reactiveValues(
    scenddMapData = NULL,
    extensionsData = NULL,
    additionalStatementsData = NULL,
    timesliceData = NULL,
    milestonyrData = NULL,
    solveroptData = NULL, 
    gmsbratio = character(0),
    gmsreslim = character(0),
    gmssolver = character(0),
    ddFiles = character(0), 
    runFile = character(0)
  )
  
  # read all possible extensions, their defaults and grouping
  extensionConfig <- fromJSON(file.path(customRendererDir,"extensions.json"))
  options_list <- extensionConfig$extensions
  columns <- extensionConfig$groups
  
  # options vector
  options <- unlist(unname(lapply(options_list, function(el) {return(lapply(el, "[[", 1L))})))
  
  # session$sendCustomMessage(type = 'optionlist',
  #                           message = options_list)
  
  # tibble containing all options with their default values
  defaultOptions <- tibble(uni = names(options), `uni#1` = options)
  
  # table IDs
  identifiers <- tolower(gsub("[[:space:]/]", "", names(options_list)))
  identifiers <- paste0(identifiers, "Table")
  
  # description (visible as tooltip) for each option
  option_description <- jsonlite::fromJSON(file.path(customRendererDir,"option_description.json"))
  
  observe({
    rv$scenddmapData <<- data$scenddmap() %>% select(-text)
    #0 values to bottom, rest sorted in ascending order 
    isolate({
      scenddmapZero <- rv$scenddmapData %>%
        filter(ddorder == "0")
      if(nrow(scenddmapZero) > 0){
        rv$scenddmapData <<- rv$scenddmapData %>%
          filter(ddorder != "0") %>% add_row(scenddmapZero)
      }
      rv$scenddmapData$offeps <<- as.logical(rv$scenddmapData$offeps)
    })
    
    rv$extensionsData <<- data$extensions() %>% 
      filter(!(substr(uni, 1, 7) == "premain")) %>% select(-text)
    rv$additionalStatementsData <<- data$extensions() %>% 
      filter(substr(uni, 1, 7) == "premain") %>% select(text)
    
    # merge default options with user options
    isolate({
      rv$mergedOptions <- defaultOptions %>%
        left_join(rv$extensionsData, by = "uni", suffix = c("_default", "_user")) %>%
        mutate(
          `uni#1` = coalesce(`uni#1_user`, `uni#1_default`)
        ) %>%
        select(uni, `uni#1`)
    })
    
    rv$milestonyrData <<- data$milestonyr() %>% select(-text)
    rv$solveroptData <<- data$solveropt() %>% select(-text)
    rv$timesliceData <<- data$timeslice() %>% select(-text)
    rv$gmsbratio <<- data$gmsbratio()
    rv$gmsreslim <<- data$gmsreslim()
    rv$gmssolver <<- data$gmssolver()
    
    isolate({
      updateSliderInput(session, "gmsbratio", value = if(length(rv$gmsbratio)) rv$gmsbratio else 1)
      updateNumericInput(session, "gmsreslim", value = if(length(rv$gmsreslim))rv$gmsreslim else 1000)
      updateSelectInput(session, "gmssolver", selected = if(length(rv$gmssolver)) rv$gmssolver else "cplex")
    })
  })

  lapply(names(columns), function(column) {
    
    colOptions <- columns[[column]]
    
    output[[column]] <- renderUI({
      tables <-  lapply(colOptions, function(category) {
        tagList(
          tags$h4(category, class="table-header"),
          tags$div(class = "table-styles",
                   rHandsontableOutput(ns(paste0(tolower(gsub("[[:space:]/]", "", category)), "Table")))
          )
        )
        
      })
      do.call(tagList, tables)
    })
    
    #table output
    lapply(colOptions, function(category) {
      noSpaceCategory <- tolower(gsub("[[:space:]/]", "", category))
      
      # data observer
      observe({
        rv[[paste0(noSpaceCategory, "TableData")]] <- rv$mergedOptions %>%
          filter(tolower(uni) %in% tolower(names(options_list[[category]])))
      })
      
      output[[paste0(noSpaceCategory, "Table")]] <- renderRHandsontable({
        tableData <- rv[[paste0(noSpaceCategory, "TableData")]]
        
        tableTmp <- rhandsontable(tableData, 
                                  colHeaders = c("Extension", "Value"),
                                  readOnly = FALSE, 
                                  rowHeaders = NULL,
                                  search = TRUE,
                                  height = if(nrow(tableData) < 4) 150 # workaround for handsontable bug
                                  ) %>% 
          hot_table(stretchH = "all", highlightRow = TRUE, overflow = "hidden") %>%
          hot_cols(manualColumnResize = TRUE, columnSorting = TRUE ) %>%
          hot_context_menu(allowComments = TRUE, allowRowEdit = FALSE,
                           allowColEdit = FALSE) %>%
          
          # configure individual dropdown for each value cell in table
          hot_cols(renderer = paste0("
           function (instance, td, row, col, prop, value, cellProperties) {
             const optionsData = ", 
             jsonlite::toJSON(unname(options_list[[category]])),
             ";
             if (col === 0) {
               cellProperties.type = 'text';
             }
             if (col === 1) {
               console.log(optionsData);
               console.log(cellProperties);
               cellProperties.type = 'dropdown';
               cellProperties.source = optionsData[row];
               // cellProperties.renderer = Handsontable.renderers.DropdownRenderer;
             }
      
           }"))

        # Iterate over all rows and set comments
        for (row in 1:nrow(tableData)) {
          uni_value <- as.character(tableData[row, "uni"])
          desc <- option_description[[uni_value]]
          
          if (!is.null(desc)) {
            tableTmp <- hot_cell(tableTmp, row, col = 1, comment = desc, readOnly = TRUE)
          }
        }
        # workaround for handsontable bug that resets stretchH setting when using comments
        tableTmp$x$stretchH <- "all"
        
        return(tableTmp)
      })
      
      # observe changes in extensions tables
      observeEvent(input[[paste0(noSpaceCategory, "Table")]], {
        rv[[paste0(noSpaceCategory, "TableData")]] <<- as_tibble(hot_to_r(input[[paste0(noSpaceCategory, "Table")]]))
      })
    })
    
  })
  
  # merge extensions data from all tables 
  observe({
    rv$extensionsData <- bind_rows(
      lapply(identifiers, function(identifier) {
        as_tibble(hot_to_r(input[[identifier]]))
      })
    )
  })
  
  #add table row
  observeEvent(input$addScenddmap, {
    rv$scenddmapData <<- rv$scenddmapData %>% add_row(ddorder = "", dd = "", offeps = FALSE)
  })
  observeEvent(input$addStatements, {
    rv$additionalStatementsData <<- rv$additionalStatementsData %>% add_row(text = "")
  })
  observeEvent(input$addMilestonyr, {
    rv$milestonyrData <<- rv$milestonyrData %>% add_row(uni = "")
  })
  observeEvent(input$addSolveropt, {
    rv$solveroptData <<- rv$solveroptData %>% add_row(uni = "", `uni#1` = "", `uni#2` = "")
  })
  
  #observe user action in scenddmapTmp table
  observeEvent(input$scenddmap, {
    if(length(input$scenddmap$data)){
      rv$scenddmapData <<- as_tibble(hot_to_r(input$scenddmap))
    }else{
      rv$scenddmapData <<- rv$scenddmapData[0,]
    }
  })
  
  #observe user action in additional Statements table
  observeEvent(input$additionalStatements, {
    if(length(input$additionalStatements$data)){
      rv$additionalStatementsData <<- as_tibble(hot_to_r(input$additionalStatements))
    }else{
      rv$additionalStatementsData <<- rv$additionalStatementsData[0,]
    }
  })
  
  #observe user action in milestonyr table
  observeEvent(input$milestonyr, {
    if(length(input$milestonyr$data)){
      rv$milestonyrData <<- as_tibble(hot_to_r(input$milestonyr))
    }else{
      rv$milestonyrData <<- rv$milestonyrData[0,]
    }
  })
  
  #observe user action in solveropt table
  observeEvent(input$solveropt, {
    if(length(input$solveropt$data)){
      rv$solveroptData <<- as_tibble(hot_to_r(input$solveropt))
    }else{
      rv$solveroptData <<- rv$solveroptData[0,]
    }
  })
  
  #observe user action in timeslice table
  observeEvent(input$timeslice, {
    if(length(input$timeslice$data)){
      rv$timesliceData <<- as_tibble(hot_to_r(input$timeslice))
    }else{
      rv$timesliceData <<- rv$timesliceData[0,]
    }
  })

  observeEvent(input$gmsbratio, {
    rv$gmsbratio <- input$gmsbratio
  })
  observeEvent(input$gmsreslim, {
    rv$gmsreslim <- input$gmsreslim
  })
  observeEvent(input$gmssolver, {
    rv$gmssolver <- input$gmssolver
  })
  
  #render scenddmap table
  output$scenddmap <- renderRHandsontable({
    rv$scenddmapData
    scenddmapData <- rv$scenddmapData %>% replace_na(list(order = "", dd = "", offeps = FALSE))
    scenddmapData$offeps <- as.logical(scenddmapData$offeps)
    scenddmapTableTmp <<- rhandsontable(scenddmapData, 
                                        colHeaders = c("Order (0=ignore)", "DD File", "$offEps"),
                                        readOnly = FALSE, 
                                        rowHeaders = NULL,
                                        search = TRUE) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE, overflow = "hidden") %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE)  %>% 
      #colWidths = c(60, 275,0.01)
      hot_col(col = 'Order (0=ignore)', colWidths=60, halign = "htCenter") %>% 
      hot_col(col = '$offEps', halign = "htCenter")
    return(scenddmapTableTmp)
  })
  
  #render additionalStatements table
  output$additionalStatements <- renderRHandsontable({
    additionalStatementsTableTmp <<- rhandsontable(rv$additionalStatementsData, 
                                         colHeaders = c("Additional statements in run file before $BATINCLUDE maindrv.mod"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE, overflow = "hidden")
    return(additionalStatementsTableTmp)
  })
  
  #render milestonyr table
  output$milestonyr <- renderRHandsontable({
    milestonyrTableTmp <<- rhandsontable(rv$milestonyrData, 
                                         colHeaders = c("Year"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE, overflow = "hidden") %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = FALSE)
    return(milestonyrTableTmp)
  })
  
  #render solveropt table
  output$solveropt <- renderRHandsontable({
    solveroptTableTmp <<- rhandsontable(rv$solveroptData, 
                                        colHeaders = c("Solver", "Option", "Value"),
                                        readOnly = FALSE, 
                                        rowHeaders = NULL,
                                        search = TRUE) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE, overflow = "hidden") %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE )
    return(solveroptTableTmp)
  })
  
  #render timeslice table
  output$timeslice <- renderRHandsontable({
    timesliceTableTmp <<- rhandsontable(rv$timesliceData, 
                                        colHeaders = c("Time slices available"),
                                        readOnly = TRUE, 
                                        rowHeaders = NULL,
                                        search = TRUE) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE, overflow = "hidden") %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = FALSE)
    timesliceTableTmp$x$contextMenu <- list()
    return(timesliceTableTmp)
  })
  
  return(
    list(
      scenddmap = reactive({
        scenddmapTmp <- rv$scenddmapData
        if(length(scenddmapTmp) && nrow(scenddmapTmp) > 0){
          scenddmapTmp <- scenddmapTmp %>% replace_na(list(order = "", dd = "", offeps = FALSE)) %>% 
            filter(ddorder != "" & dd != "")
        }
        scenddmapTmp$offeps <- tolower(as.character(scenddmapTmp$offeps))
        scenddmapTmp[["text"]] <- ""
        scenddmapTmp
      }),
      extensions = reactive({
        extensionsTmp <- rv$extensionsData
        additionalStatementsTmp <- rv$additionalStatementsData
        if(length(extensionsTmp) && nrow(extensionsTmp) > 0){
          extensionsTmp <- extensionsTmp %>% 
            filter(uni != "" & `uni#1` != "") %>% 
            filter(`uni#1` != "unset")
        }
        extensionsTmp[["text"]] <- ""
        
        if(length(additionalStatementsTmp) > 0 && nrow(additionalStatementsTmp) > 0){
          additionalStatementsTmp <- additionalStatementsTmp %>% filter(text != "")
          if(nrow(additionalStatementsTmp) > 0) {
            additionalStatementsTmp <- additionalStatementsTmp %>%
              mutate(uni = 'premain', `uni#1` = as.character(seq(n()))) %>%
              select(uni, `uni#1`, everything())
          }
        }
        extensionsTmp <- bind_rows(extensionsTmp, additionalStatementsTmp)
        extensionsTmp
      }),
      milestonyr = reactive({
        milestonyrTmp <- rv$milestonyrData
        if(length(milestonyrTmp)){
          milestonyrTmp <- milestonyrTmp[order(milestonyrTmp$uni),]
        }
        if(length(milestonyrTmp) && nrow(milestonyrTmp) > 0){
          milestonyrTmp <- milestonyrTmp %>% filter(uni != "")
        }
        milestonyrTmp[["text"]] <- ""
        milestonyrTmp
      }),
      solveropt = reactive({
        solveroptTmp <- rv$solveroptData
        if(length(solveroptTmp) && nrow(solveroptTmp) > 0){
          solveroptTmp <- solveroptTmp %>% filter(uni != "" & `uni#1` != "" & `uni#2` != "")
        }
        solveroptTmp[["text"]] <- ""
        solveroptTmp
      }),
      timeslice = reactive({
        timesliceTmp <- rv$timesliceData
        if(length(timesliceTmp) && nrow(timesliceTmp) > 0){
          timesliceTmp <- timesliceTmp %>% filter(uni != "")
        }
        timesliceTmp[["text"]] <- ""
        timesliceTmp
      }),
      gmsbratio = reactive({
        rv$gmsbratio
      }),
      gmsreslim = reactive({
        rv$gmsreslim
      }),
      gmssolver = reactive({
        rv$gmssolver
      }),
      dd_prc_desc = reactive({
        data$dd_prc_desc()
      }),
      dd_com_desc = reactive({
        data$dd_com_desc()
      })
    )
  )
  
}