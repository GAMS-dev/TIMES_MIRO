mirowidget_scenddmapOutput <- function(id, height = NULL, options = NULL, path = NULL){
  ns <- NS(id)
  
  tagList(
    tags$div(
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
                                   tags$h4("Extensions", class="table-header"),
                                   tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                            actionButton(ns("addExtensions"), label = NULL, 
                                                         icon = icon("circle-plus"), 
                                                         class = "add-row-btn")
                                   ),
                                   tags$div(class = "table-styles",
                                            rHandsontableOutput(ns('extensions'))
                                   ),
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
                                 selectInput(ns("gmsobj"), tags$h4("Objective function formulation"), c("ALT", "AUTO", "LIN", "MOD", "STD"), selected = "AUTO"),
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

  
  rv <- reactiveValues(
    scenddMapData = NULL,
    extensionsData = NULL,
    additionalStatementsData = NULL,
    timesliceData = NULL,
    milestonyrData = NULL,
    solveroptData = NULL, 
    gmsbotime = character(0),
    gmseotime = character(0),
    boEoTimeData = NULL,
    gmsobj = character(0),
    gmsbratio = character(0),
    gmsreslim = character(0),
    gmssolver = character(0),
    ddFiles = character(0), 
    runFile = character(0)
  )
  
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
    
    #TODO: read premain lines from data$extensions()[["text"]], communicate via seperate table?
    rv$extensionsData <<- data$extensions() %>% 
      filter(!(substr(uni, 1, 7) == "premain")) %>% select(-text)
    rv$additionalStatementsData <<- data$extensions() %>% 
      filter(substr(uni, 1, 7) == "premain") %>% select(text)
    rv$milestonyrData <<- data$milestonyr() %>% select(-text)
    rv$solveroptData <<- data$solveropt() %>% select(-text)
    rv$timesliceData <<- data$timeslice() %>% select(-text)
    rv$gmsobj <<- data$gmsobj()
    rv$gmsbotime <<- data$gmsbotime()
    rv$gmseotime <<- data$gmseotime()
    rv$gmsbratio <<- data$gmsbratio()
    rv$gmsreslim <<- data$gmsreslim()
    rv$gmssolver <<- data$gmssolver()
    
    isolate({
      updateSelectInput(session, "gmsobj", selected = if(length(rv$gmsobj)) rv$gmsobj else "MOD")
      updateSliderInput(session, "gmsbratio", value = if(length(rv$gmsbratio)) rv$gmsbratio else 1)
      updateNumericInput(session, "gmsreslim", value = if(length(rv$gmsreslim))rv$gmsreslim else 1000)
      updateSelectInput(session, "gmssolver", selected = if(length(rv$gmssolver)) rv$gmssolver else "cplex")
      rv$boEoTimeData <<- tibble(Time = c("BOTIME", "EOTIME"),
                                 Value = c(if(length(rv$gmsbotime)) rv$gmsbotime else 1850, 
                                           if(length(rv$gmseotime)) rv$gmseotime else 2200))
    })
  })
  
  #add table row
  observeEvent(input$addScenddmap, {
    rv$scenddmapData <<- rv$scenddmapData %>% add_row(ddorder = "", dd = "", offeps = FALSE)
  })
  observeEvent(input$addExtensions, {
    rv$extensionsData <<- rv$extensionsData %>% add_row(uni = "", `uni#1` = "")
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
  
  #observe user action in extensions table
  observeEvent(input$extensions, {
    if(length(input$extensions$data)){
      rv$extensionsData <<- as_tibble(hot_to_r(input$extensions))
    }else{
      rv$extensionsData <<- rv$extensionsData[0,]
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
  
  observeEvent(input$gmsobj, {
    rv$gmsobj <- input$gmsobj
  })

  observeEvent(input$boEoTime, {
    if(length(input$boEoTime$data)){
      if(length(as_tibble(hot_to_r(input$boEoTime)))){
        rv$gmsbotime <<- as_tibble(hot_to_r(input$boEoTime)) %>% 
          filter(Time == "BOTIME") %>% pull(Value) %>% unique() %>% as.numeric()
      }else{
        rv$gmsbotime <<- 1850
      }
      if(length(as_tibble(hot_to_r(input$boEoTime)))){
        rv$gmseotime <<- as_tibble(hot_to_r(input$boEoTime)) %>% 
          filter(Time == "EOTIME") %>% pull(Value) %>% unique() %>% as.numeric()
      }else{
        rv$gmseotime <<- 2200
      }
    }else{
      rv$boEoTimeData <<- rv$boEoTimeData[0,]
      rv$gmsbotime <<- 1850
      rv$gmseotime <<- 2200
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
  
  #render extensions table
  output$extensions <- renderRHandsontable({
    extensionsTableTmp <<- rhandsontable(rv$extensionsData, 
                                         colHeaders = c("Extension", "Value"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE, overflow = "hidden") %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE )
    return(extensionsTableTmp)
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
  
  #render botime and eotime table
  output$boEoTime <- renderRHandsontable({
    boEoTimeTableTmp <<- rhandsontable(rv$boEoTimeData,
                                         colHeaders = c("Time", "Value"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE, overflow = "hidden") %>%
      hot_col(1, readOnly = TRUE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE)
    boEoTimeTableTmp$x$contextMenu <- list()
    return(boEoTimeTableTmp)
  })
  
  #render milestonyr table
  output$milestonyr <- renderRHandsontable({
    milestonyrTableTmp <<- rhandsontable(rv$milestonyrData, 
                                         colHeaders = c("Year"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE, overflow = "hidden") %>%
      hot_col(1,  type = "dropdown", 
              source = as.character(
                (if(length(rv$gmsbotime)) rv$gmsbotime 
                 else 1850):(if(length(rv$gmseotime)) 
                   rv$gmseotime else 2200)), 
              strict = TRUE, allowInvalid = FALSE) %>%
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
    #TODO: no context menu
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
          extensionsTmp <- extensionsTmp %>% filter(uni != "" & `uni#1` != "")
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
      gmsobj = reactive({
        rv$gmsobj
      }),
      gmsbotime = reactive({
        if (!length(rv$gmsbotime)) {
          1850L
        } else{
          as.numeric(rv$gmsbotime)
        }
      }),
      gmseotime = reactive({
        if (!length(rv$gmseotime)) {
          2200L
        } else{
          as.numeric(rv$gmseotime)
        }
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