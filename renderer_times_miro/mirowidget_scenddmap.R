mirowidget_scenddmapOutput <- function(id, height = NULL, options = NULL, path = NULL){
  ns <- NS(id)
  
  tagList(
    tags$head(
      tags$style(HTML("
          .table-styles {
              margin-bottom: 15px;
          }
          .table-header {
              display: inline-block;
          }
          .box-custom {
              height: 450px;
              margin-bottom: 25px;
          }
          .add-row-btn-wrapper {
              display: inline-block;
          }
          .add-row-btn {
              border: none;
              box-shadow: none;
              color: #60ce60;
              font-size: 18px;
          }
          .info-label-nowrap {
              white-space: nowrap;
          }
          @media only screen and (max-width: 1199px) {
              .custom-2 {
                  width: 100%;
              }
              .custom-2.box-custom {
                  height: unset;
                  margin-bottom: 0px;
              }
              .outer-height{
                  height: 475px;
              }
          }
          @media only screen and (min-width: 768px) and (max-width: 1199px) {
              .reverse-custom {
                  display: flex;
                  flex-flow: row-reverse;
              }
          }
          @media only screen and (min-width: 1200px) {
              .custom-4 {
                  width: 33.33333333%;
              }
              .custom-8 {
                  width: 66.66666667%;
              }
          }
          @media only screen and (min-width: 1200px) and (max-width: 1399px) {
              .custom-2 {
                  width: 100%
              }
              .custom-2.box-custom {
                  height: unset;
                  margin-bottom: 0px;
              }
              .outer-height{
                  height: 475px;
              }
              .custom-4 {
                  width: 25%;
              }
              .custom-8 {
                  width: 75%;
              }
          }
          ")
      )
    ),
    tags$div(
      tabsetPanel(id = ns("runmode"),
                  tabPanel("Prepare model run", value = "solve", 
                           fluidRow(
                             tags$div(class = "col-sm-12 col-lg-8 custom-8",
                                    fluidRow(
                                      tags$div(class = "col-sm-12 col-md-6 box-custom",
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
                                                                   icon = icon("plus-circle"), 
                                                                   class = "add-row-btn")
                                             ),
                                             tags$div(class = "table-styles",
                                                      rHandsontableOutput(ns('scenddmap'))
                                             )
                                      ),
                                      tags$div(class = "col-sm-12 col-md-6 box-custom",
                                             tags$h4("Extensions", class="table-header"),
                                             tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                                      actionButton(ns("addExtensions"), label = NULL, 
                                                                   icon = icon("plus-circle"), 
                                                                   class = "add-row-btn")
                                             ),
                                             tags$div(class = "table-styles",
                                                      rHandsontableOutput(ns('extensions'))
                                             )
                                      )
                                    ),
                                    fluidRow(
                                      tags$div(class = "col-sm-12 col-md-8 col-lg-6 box-custom",
                                             tags$h4("Years for model run", class="table-header"),
                                             tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                                      actionButton(ns("addMilestonyr"), label = NULL, 
                                                                   icon = icon("plus-circle"), 
                                                                   class = "add-row-btn")
                                             ),
                                             fluidRow(
                                               tags$div(class = "col-sm-12 col-md-6 box-custom",
                                                      tags$div(class = "table-styles",
                                                               rHandsontableOutput(ns('milestonyr'))
                                                      )
                                               ),
                                               tags$div(class = "col-sm-12 col-md-6 box-custom",
                                                      tags$div(class = "table-styles",
                                                               rHandsontableOutput(ns('boEoTime'))
                                                      )
                                               )
                                             )),
                                      tags$div(class = "col-sm-12 col-md-4 col-lg-6 box-custom",
                                             tags$h4("Time slices available", class="table-header"),
                                             tags$div(class = "table-styles",
                                                      rHandsontableOutput(ns('timeslice'))
                                             )
                                      )
                                    )
                             ),
                             tags$div(class = "col-sm-12 col-lg-4 custom-4",
                                      fluidRow(class = "reverse-custom",
                                        tags$div(class = "col-sm-4 col-lg-12",
                                                 fluidRow(class = "outer-height",
                                                          tags$div(class = "col-sm-6 custom-2 box-custom",
                                                                   selectInput(ns("gmssolver"), tags$h4("Solver to use"), c("cplex", "cbc", "conopt", "conopt4"), selected = "cplex"),
                                                                   numericInput(ns("gmsreslim"), tags$h4("Time limit for solve [seconds]"), 
                                                                                min = 10, max = 36000, value = 1000L, step = 1)
                                                          ),
                                                          tags$div(class = "col-sm-6 custom-2 box-custom",
                                                                   selectInput(ns("gmsobj"), tags$h4("Objective function formulation"), c("ALT", "AUTO", "LIN", "MOD", "STD"), selected = "AUTO"),
                                                                   sliderInput(ns("gmsbratio"), 
                                                                               tags$div(
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
                                                                               ), 
                                                                               min = 0, max = 1, value = 1, step = 0.01)
                                                          ),
                                                 )),
                                        tags$div(class = "col-sm-8 col-lg-12",
                                                 class = "box-custom",
                                                 fluidRow(
                                                   column(12, class = "box-custom",
                                                          tags$h4("Solver options", class="table-header"),
                                                          tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                                                   actionButton(ns("addSolveropt"), label = NULL, 
                                                                                icon = icon("plus-circle"), 
                                                                                class = "add-row-btn")
                                                          ),
                                                          tags$div(class = "table-styles",
                                                                   rHandsontableOutput(ns('solveropt'))
                                                          )
                                                   )
                                                 )
                                                 
                                        )
                                      )
                             )
                           )
                           
                  ),
                  tabPanel("Create new TIMES MIRO scenario", value = "create", 
                           fluidRow(
                             column(3,
                                    tags$h4("Upload DD files and runfile here", class="highlight-block"),
                                    fileInput(ns("ddFilesUpload"), tags$h4("DD file(s):"),
                                              width = "100%", multiple = TRUE,
                                              accept = c(".dd", ".dds")),
                                    tags$div(id = "invalidFileExtensionDD", class="config-message custom-message", 
                                             "Invalid file extension! allowed are 'dd', 'dds'."),
                                    tags$div(id = "attachmentAddedDD", class="config-message", 
                                             "File(s) added as attachment."),
                                    fileInput(ns("gmsrunlocation"), tags$h4("RUN file:"),
                                              width = "100%", multiple = FALSE,
                                              accept = c("text/plain",
                                                         ".gms", ".inc", "txt", ".run")),
                                    tags$div(id = "attachmentAddedRUN", class="config-message", 
                                             "File was added as attachment."),
                                    tags$div(id = "invalidFileExtensionRUN", class="config-message custom-message", 
                                             "Invalid file extension!"),
                                    tags$div(id = "tooMuchAttachments", class="config-message", 
                                             "Maximum number of attachments exceeded! No attachment was added.")
                             ),
                             column(3,
                                    tags$h4("Uploaded DD files:", class="highlight-block"),
                                    tags$div(style = "overflow: auto;max-height:400px;",
                                             dataTableOutput(ns("ddFilesAdded")))
                             ),
                             column(3,
                                    tags$h4("Uploaded Run file:", class="highlight-block"),
                                    tags$div(style = "overflow: auto;max-height:400px;",
                                             dataTableOutput(ns("runFileAdded")))
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
  
  zipFilePath <- tempfile(fileext = ".zip")
  
  observe({
    rv$scenddmapData <<- data$scenddmap()
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
    
    rv$extensionsData <<- data$extensions()
    rv$milestonyrData <<- data$milestonyr()
    rv$solveroptData <<- data$solveropt()
    rv$timesliceData <<- data$timeslice()
    rv$gmsobj <<- data$gmsobj()
    rv$gmsbotime <<- data$gmsbotime()
    rv$gmseotime <<- data$gmseotime()
    rv$gmsbratio <<- data$gmsbratio()
    rv$gmsreslim <<- data$gmsreslim()
    rv$gmssolver <<- data$gmssolver()
    
    isolate({
      updateSelectInput(session, "gmsobj", selected = if(length(rv$gmsobj)) rv$gmsobj else "MOD")
      updateSelectInput(session, "gmsbratio", selected = if(length(rv$gmsbratio)) rv$gmsbratio else 1)
      updateSelectInput(session, "gmsreslim", selected = if(length(rv$gmsreslim))rv$gmsreslim else 1000)
      updateSelectInput(session, "gmssolver", selected = if(length(rv$gmssolver)) rv$gmssolver else "cplex")
      rv$boEoTimeData <<- tibble(Time = c("BOTIME", "EOTIME"),
                                 Value = c(if(length(rv$gmsbotime)) rv$gmsbotime else 1850, 
                                           if(length(rv$gmseotime)) rv$gmseotime else 2200))
    })
    
    if("dd_files.zip" %in% attachments$getIds()){
      tryCatch({
        attachments$save(zipFilePath, "dd_files.zip", overwrite = TRUE)
        attachmentsZip <- zip::zip_list(zipFilePath)
        attachmentsZip <- attachmentsZip[attachmentsZip$compressed_size > 0, ]$filename
        rv$ddFiles <- attachmentsZip[grep(".dds?$", attachmentsZip, ignore.case = TRUE)]
      }, error = function(e){
        print("An unexpected error occured.")
      })
    }else{
      rv$ddFiles <- character(0)
    }
    if(length(grep(".run$", attachments$getIds(), ignore.case = TRUE))){
      files <- attachments$getIds()
      rv$runFile <- files[grep(".run$", attachments$getIds(), ignore.case = TRUE)]
    }else{
      rv$runFile <- character(0)
    }
  })
  
  #add table row
  observeEvent(input$addScenddmap, {
    rv$scenddmapData <<- rv$scenddmapData %>% add_row(ddorder = "", dd = "", offeps = FALSE, text = "")
  })
  observeEvent(input$addExtensions, {
    rv$extensionsData <<- rv$extensionsData %>% add_row(uni = "", `uni#1` = "", text = "")
  })
  observeEvent(input$addMilestonyr, {
    rv$milestonyrData <<- rv$milestonyrData %>% add_row(uni = "", text = "")
  })
  observeEvent(input$addSolveropt, {
    rv$solveroptData <<- rv$solveroptData %>% add_row(uni = "", `uni#1` = "", `uni#2` = "", text = "")
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
  
  zipDDFiles <- function(zipPath, filepaths, filenames, append = FALSE) {
    stopifnot(identical(length(filepaths), length(filenames)))
    rootDir <- file.path(dirname(filepaths[[1L]]), "ddzip")
    unlink(rootDir, recursive = TRUE)
    on.exit(unlink(rootDir, recursive = TRUE))
    if (!dir.create(rootDir)) {
      stop(sprintf("Could not create: %s", rootDir), call. = FALSE)
    }
    filesToZip <- file.path(rootDir, filenames)
    if (any(!file.rename(filepaths, filesToZip))) {
      stop("Could not move files", call. = FALSE)
    }
    if(append){
      for(file in filesToZip){
        zip::zip_append(zipPath, file, mode = "cherry-pick")
      }
      return(zipPath)
    }
    zip::zip(zipPath, filenames, root = rootDir)
    return(zipPath)
  }
  
  #dd file upload
  observeEvent(input$ddFilesUpload, {
    file <- input$ddFilesUpload
    filePath <- file$datapath
    fileName <- file$name
    ext <- tools::file_ext(file$datapath)
    ddToAdd <- fileName[grep(".dds?$", fileName, ignore.case = TRUE)]
    req(file)
    if(any(!tolower(ext) %in% c("dd", "dds"))){
      showHideEl(session, "#invalidFileExtensionDD")
      return()
    }
    if(!length(filePath)){
      return()
    }
    if("dd_files.zip" %in% attachments$getIds()){
      tryCatch({
        attachments$save(zipFilePath, "dd_files.zip", overwrite = TRUE)
      }, error = function(e){
        print("An unexpected error occured.")
      })
      zipDDFiles(zipFilePath, filePath, fileName, append = TRUE)
    }else{
      zipDDFiles(zipFilePath, filePath, fileName)
    }
    tryCatch(
      {
        attachmentsZip <- zip::zip_list(zipFilePath)
        attachmentsZip <- attachmentsZip[attachmentsZip$compressed_size > 0, ]$filename
        ddFiles <- attachmentsZip[grep(".dds?$", attachmentsZip, ignore.case = TRUE)]
        
        attachments$add(session, zipFilePath, "dd_files.zip", overwrite = TRUE, execPerm = TRUE)
        showHideEl(session, "#attachmentAddedDD")
        rv$ddFiles <- ddFiles
      }, error_max_no = function(e){
        showHideEl(session, "#tooMuchAttachments")
        print(conditionMessage(e))
      }, error_max_size = function(e) {
        print(conditionMessage(e))
      }, error = function(e) {
        print("An unexpected error occured.")
      }
    )
  })
  #runfile upload
  observeEvent(input$gmsrunlocation, {
    file <- input$gmsrunlocation
    filePath <- file$datapath
    fileName <- file$name
    req(file)
    ext <- tools::file_ext(file$datapath)
    if(!identical(tolower(ext), "run")){
      showHideEl(session, "#invalidFileExtensionRUN")
      return()
    }
    oldRunFile <- attachments$getIds()
    oldRunFile <- oldRunFile[grep(".run$", oldRunFile, ignore.case = TRUE)]
    oldRunFile <- oldRunFile[!oldRunFile %in% fileName]
    tryCatch(
      {
        attachments$add(session, filePath, fileName, overwrite = TRUE, execPerm = TRUE)
        attachments$remove(session, oldRunFile, removeLocal = FALSE)
        showHideEl(session, "#attachmentAddedRUN")
        rv$runFile <- fileName
      }, error_max_no = function(e){
        showHideEl(session, "#tooMuchAttachments")
        print(conditionMessage(e))
      }, error_max_size = function(e) {
        print(conditionMessage(e))
      }, error = function(e) {
        print("An unexpected error occured.")
      }
    )
  })
  
  #render scenddmap table
  output$scenddmap <- renderRHandsontable({
    rv$scenddmapData
    scenddmapData <- rv$scenddmapData %>% replace_na(list(order = "", dd = "", offeps = FALSE, text = ""))
    scenddmapData$offeps <- as.logical(scenddmapData$offeps)
    scenddmapTableTmp <<- rhandsontable(scenddmapData, 
                                        colHeaders = c("Order (0=ignore)", "DD File", "$offEps", "Text"),
                                        readOnly = FALSE, 
                                        rowHeaders = NULL,
                                        search = TRUE,
                                        height = 400) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE)  %>% 
      #colWidths = c(60, 275,0.01)
      hot_col(col = 'Order (0=ignore)', colWidths=60, halign = "htCenter") %>% 
      hot_col(col = '$offEps', halign = "htCenter") %>% 
      hot_col(col = 'Text', colWidths=0.01)
    return(scenddmapTableTmp)
  })
  
  #render extensions table
  output$extensions <- renderRHandsontable({
    extensionsTableTmp <<- rhandsontable(rv$extensionsData, 
                                         colHeaders = c("Extension", "Value", "Text"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE,
                                         height = 400) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE ) %>% 
      hot_col(col = 'Text', colWidths=0.01)
    return(extensionsTableTmp)
  })
  
  #render botime and eotime table
  output$boEoTime <- renderRHandsontable({
    boEoTimeTableTmp <<- rhandsontable(rv$boEoTimeData, 
                                         colHeaders = c("Time", "Value"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE,
                                         height = 85) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE) %>%
      hot_col(1, readOnly = TRUE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE)
    boEoTimeTableTmp$x$contextMenu <- list()
    return(boEoTimeTableTmp)
  })
  
  #render milestonyr table
  output$milestonyr <- renderRHandsontable({
    milestonyrTableTmp <<- rhandsontable(rv$milestonyrData, 
                                         colHeaders = c("Year", "Text"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE,
                                         height = 400) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE) %>%
      hot_col(1,  type = "autocomplete", source = c(if(length(rv$gmsbotime)) rv$gmsbotime else 1850:if(length(rv$gmseotime)) rv$gmseotime else 2200), strict = TRUE, allowInvalid = FALSE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE) %>% 
      hot_col(col = 'Text', colWidths=0.001)
    return(milestonyrTableTmp)
  })
  
  #render solveropt table
  output$solveropt <- renderRHandsontable({
    solveroptTableTmp <<- rhandsontable(rv$solveroptData, 
                                        colHeaders = c("Solver", "Option", "Value", "Text"),
                                        readOnly = FALSE, 
                                        rowHeaders = NULL,
                                        search = TRUE,
                                        height = 400) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE )%>% 
      hot_col(col = 'Text', colWidths=0.001)
    return(solveroptTableTmp)
  })
  
  #render timeslice table
  output$timeslice <- renderRHandsontable({
    #TODO: no context menu
    timesliceTableTmp <<- rhandsontable(rv$timesliceData, 
                                        colHeaders = c("Time Slice", "Text"),
                                        readOnly = TRUE, 
                                        rowHeaders = NULL,
                                        search = TRUE,
                                        height = 400) %>% 
      hot_table(stretchH = "none", highlightRow = TRUE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE,
               colWidths = c(175, 0.01))
    timesliceTableTmp$x$contextMenu <- list()
    return(timesliceTableTmp)
  })
  
  output$ddFilesAdded <- renderDataTable({
    DT::datatable(cbind(rv$ddFiles), rownames = FALSE, colnames = c(""),
                  class = "compact", 
                  options = list(dom = 't', bSort=FALSE, pageLength = -1))
  })
  
  output$runFileAdded <- renderDataTable({
    DT::datatable(cbind(rv$runFile), rownames = FALSE, colnames = c(""),
                  class = "compact", 
                  options = list(dom = 't', bSort=FALSE))
  })
  
  toListenCreate <- reactive({
    list(input$runmode, rv$ddFiles, rv$runFile)
  })
  observeEvent(toListenCreate(), {
    if(identical(input$runmode, "create") && (identical(rv$ddFiles, character(0)) || identical(rv$runFile, character(0)))){
      disableEl(session, "#btSolve")
    }else{
      enableEl(session, "#btSolve")
    }
  })
  
  return(
    list(
      scenddmap = reactive({
        scenddmapTmp <- rv$scenddmapData
        if(length(scenddmapTmp) && nrow(scenddmapTmp) > 0){
          scenddmapTmp <- scenddmapTmp %>% replace_na(list(order = "", dd = "", offeps = FALSE, text = "")) %>% 
            filter(ddorder != "" & dd != "")
        }
        scenddmapTmp$offeps <- tolower(as.character(scenddmapTmp$offeps))
        scenddmapTmp
      }),
      extensions = reactive({
        extensionsTmp <- rv$extensionsData
        if(length(extensionsTmp) && nrow(extensionsTmp) > 0){
          extensionsTmp <- extensionsTmp %>% filter(uni != "" & `uni#1` != "")
        }
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
        milestonyrTmp
      }),
      solveropt = reactive({
        solveroptTmp <- rv$solveroptData
        if(length(solveroptTmp) && nrow(solveroptTmp) > 0){
          solveroptTmp <- solveroptTmp %>% filter(uni != "" & `uni#1` != "" & `uni#2` != "")
        }
        solveroptTmp
      }),
      timeslice = reactive({
        timesliceTmp <- rv$timesliceData
        if(length(timesliceTmp) && nrow(timesliceTmp) > 0){
          timesliceTmp <- timesliceTmp %>% filter(uni != "")
        }
        timesliceTmp
      }),
      gmsobj = reactive({
        rv$gmsobj
      }),
      gmsrunlocation = reactive({
        paste0("||./", rv$runFile)
      }),
      gmsbotime = reactive({
        as.numeric(rv$gmsbotime)
      }),
      gmseotime = reactive({
        as.numeric(rv$gmseotime)
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
      gmsrunmode = reactive({
        paste0("||", input$runmode)
      })
    )
  )
  
}