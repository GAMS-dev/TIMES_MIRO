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
          ")
      )
    ),
    tags$div(
      tabsetPanel(id = ns("runmode"),
                  tabPanel("Solve model", value = "solve", 
                           fluidRow(
                             column(8,
                                    fluidRow(
                                      column(6, class = "box-custom",
                                             tags$div(class="table-header",
                                                      tags$h4(tags$span("DD Files order / Read under "),
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
                                      column(6, class = "box-custom",
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
                                      column(6, class = "box-custom",
                                             fluidRow(
                                               column(6,
                                                      tags$h4("Years for model run", class="table-header"),
                                                      tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                                               actionButton(ns("addMilestonyr"), label = NULL, 
                                                                            icon = icon("plus-circle"), 
                                                                            class = "add-row-btn")
                                                      ),
                                                      tags$div(class = "table-styles",
                                                               rHandsontableOutput(ns('milestonyr'))
                                                      )
                                               ),
                                               column(6,
                                                      tags$div(style = "min-width:80px;max-width:125px;",
                                                               numericInput(ns("gmsbotime"), tags$h4("First year available"), 
                                                                            min = 1850, max = 2200, value = "1960", width = "100%")),
                                                      tags$div(style = "min-width:80px;max-width:125px;",
                                                               numericInput(ns("gmseotime"), tags$h4("Last year available"), 
                                                                            min = 1850, max = 2200, value = "2200", width = "100%"))
                                               )
                                             )),
                                      column(6, class = "box-custom",
                                             tags$h4("Time slices available", class="table-header"),
                                             tags$div(class = "add-row-btn-wrapper", title = "Add row", 
                                                      actionButton(ns("addTimeslice"), label = NULL, 
                                                                   icon = icon("plus-circle"), 
                                                                   class = "add-row-btn")
                                             ),
                                             tags$div(class = "table-styles",
                                                      rHandsontableOutput(ns('timeslice'))
                                             )
                                      )
                                    )
                             ),
                             column(4,
                                    fluidRow(
                                      column(6, class = "box-custom",
                                             selectInput(ns("gmssolver"), tags$h4("Solver to use"), c("cplex", "cbc", "conopt", "conopt4"), selected = "cplex"),
                                             numericInput(ns("gmsreslim"), tags$h4("Time limit for solve [seconds]"), 
                                                          min = 10, max = 36000, value = 1000, step = 1)
                                      ),
                                      column(6, class = "box-custom",
                                             selectInput(ns("gmsobj"), tags$h4("Objective function formulation"), c("ALT", "AUTO", "LIN", "MOD", "STD"), selected = "MOD"),
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
                                      )
                                    ),
                                    fluidRow(
                                      column(12, class = "box-custom",
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
                  tabPanel("Create input data", value = "create", 
                           fluidRow(
                             column(3,
                                    tags$h4("Upload DD files and runfile here", class="highlight-block"),
                                    fileInput(ns("ddFilesUpload"), tags$h4("DD file(s):"),
                                              width = "100%", multiple = TRUE,
                                              accept = c("text/plain",
                                                         ".gms", ".inc", "txt", ".dd", ".DD")),
                                    tags$div(id = "invalidFileExtensionDD", class="config-message custom-message", 
                                             "Invalid file extension! allowed are 'dd', 'DD', 'gms', 'inc', 'txt'."),
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
    inputNeedsUpdate = FALSE,
    updateScenddMap = 1,
    updateExtensions = 1,
    updateTimeslice = 1,
    updateMilestonyr = 1,
    updateSolveropt = 1, 
    updateGmsbotime = character(0),
    updateGmseotime = character(0),
    updateGmsobj = character(0),
    updateGmsbratio = character(0),
    updateGmsreslim = character(0),
    updateGmssolver = character(0),
    updateGmsrunmode = character(0),
    ddFiles = character(0), 
    runFile = character(0)
  )
  
  zipFilePath <- tempfile(fileext = ".zip")
  scenddmapData <- NULL
  extensionsData <- NULL
  milestonyrData <- NULL
  solveroptData <- NULL
  timesliceData <- NULL
  offepsData <- NULL
  gmsobjData <- NULL
  # gmsrunlocationData <- NULL
  gmsbotimeData <- NULL
  gmseotimeData <- NULL
  gmsbratioData <- NULL
  gmsreslimData <- NULL
  gmssolverData <- NULL
  
  observe({
    scenddmapData <<- data$scenddmap()
    scenddmapData$offeps <<- as.logical(scenddmapData$offeps)
    extensionsData <<- data$extensions()
    milestonyrData <<- data$milestonyr()
    solveroptData <<- data$solveropt()
    timesliceData <<- data$timeslice()
    gmsobjData <<- data$gmsobj()
    # gmsrunlocationData <<- data$gmsrunlocation()
    gmsbotimeData <<- data$gmsbotime()
    gmseotimeData <<- data$gmseotime()
    gmsbratioData <<- data$gmsbratio()
    gmsreslimData <<- data$gmsreslim()
    gmssolverData <<- data$gmssolver()
    if(length(gmsobjData)){
      updateSelectInput(session, "gmsobj", selected = gmsobjData)
    }
    if(length(gmsbotimeData)){
      updateSelectInput(session, "gmsbotime", selected = gmsbotimeData)
    }
    if(length(gmseotimeData)){
      updateSelectInput(session, "gmseotime", selected = gmseotimeData)
    }
    if(length(gmsbratioData)){
      updateSelectInput(session, "gmsbratio", selected = gmsbratioData)
    }
    if(length(gmsreslimData)){
      updateSelectInput(session, "gmsreslim", selected = gmsreslimData)
    }
    if(length(gmssolverData)){
      updateSelectInput(session, "gmssolver", selected = gmssolverData)
    }
    if("dd_files.zip" %in% attachments$getIds()){
      tryCatch({
        attachments$save(zipFilePath, "dd_files.zip", overwrite = TRUE)
        attachmentsZip <- zip::zip_list(zipFilePath)
        attachmentsZip <- attachmentsZip[attachmentsZip$compressed_size > 0, ]$filename
        rv$ddFiles <- attachmentsZip[grep(".dd", attachmentsZip, ignore.case = TRUE)]
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
    isolate({
      rv$inputNeedsUpdate <- TRUE 
      rv$updateScenddMap <- rv$updateScenddMap + 1
      rv$updateExtensions <- rv$updateExtensions + 1
      rv$updateTimeslice <- rv$updateTimeslice + 1
      rv$updateMilestonyr <- rv$updateMilestonyr + 1
      rv$updateSolveropt <- rv$updateSolveropt + 1
      rv$updateGmsbotime <- input$gmsbotime
      rv$updateGmseotime <- input$gmseotime
      rv$updateGmsobj <- input$gmsobj
      rv$updateGmsbratio <- input$gmsbratio
      rv$updateGmsreslim <- input$gmsreslim
      rv$updateGmssolver <- input$gmssolver
      rv$updateGmsrunmode <- input$gmsrunmode
    })
  })
  
  
  #observe user action in scenddmapTmp table
  observeEvent(input$scenddmap, {
    if(length(input$scenddmap$data)){
      scenddmapData <<- as_tibble(hot_to_r(input$scenddmap))
    }else{
      scenddmapData <<- scenddmapData[0,]
    }
  })
  
  #add table row
  observeEvent(input$addScenddmap, {
    scenddmapData <<- scenddmapData %>% add_row(ddorder = "", dd = "", offeps = FALSE, text = "")
    rv$updateScenddMap <- rv$updateScenddMap + 1
  })
  observeEvent(input$addExtensions, {
    extensionsData <<- extensionsData %>% add_row(uni = "", `uni#1` = "", text = "")
    rv$updateExtensions <- rv$updateExtensions + 1
  })
  observeEvent(input$addTimeslice, {
    timesliceData <<- timesliceData %>% add_row(uni = "", text = "")
    rv$updateTimeslice <- rv$updateTimeslice + 1
  })
  observeEvent(input$addMilestonyr, {
    milestonyrData <<- milestonyrData %>% add_row(uni = "", text = "")
    rv$updateMilestonyr <- rv$updateMilestonyr + 1
  })
  observeEvent(input$addSolveropt, {
    solveroptData <<- solveroptData %>% add_row(uni = "", `uni#1` = "", `uni#2` = "", text = "")
    rv$updateSolveropt <- rv$updateSolveropt + 1
  })
  
  #observe user action in extensions table
  observeEvent(input$extensions, {
    if(length(input$extensions$data)){
      extensionsData <<- as_tibble(hot_to_r(input$extensions))
    }else{
      extensionsData <<- extensionsData[0,]
    }
  })
  
  #observe user action in milestonyr table
  observeEvent(input$milestonyr, {
    if(length(input$milestonyr$data)){
      milestonyrData <<- as_tibble(hot_to_r(input$milestonyr))
    }else{
      milestonyrData <<- milestonyrData[0,]
    }
  })
  
  #observe user action in solveropt table
  observeEvent(input$solveropt, {
    if(length(input$solveropt$data)){
      solveroptData <<- as_tibble(hot_to_r(input$solveropt))
    }else{
      solveroptData <<- solveroptData[0,]
    }
  })
  
  #observe user action in timeslice table
  observeEvent(input$timeslice, {
    if(length(input$timeslice$data)){
      timesliceData <<- as_tibble(hot_to_r(input$timeslice))
    }else{
      timesliceData <<- timesliceData[0,]
    }
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
    ddToAdd <- fileName[grep(".dd$", fileName, ignore.case = TRUE)]
    req(file)
    if(any(!ext %in% c("gms", "txt", "inc", "dd", "DD"))){
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
        ddFiles <- attachmentsZip[grep(".dd", attachmentsZip, ignore.case = TRUE)]
        
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
    rv$updateScenddMap
    scenddmapData <- scenddmapData %>% replace_na(list(order = "", dd = "", offeps = FALSE, text = ""))
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
    rv$updateExtensions
    extensionsTableTmp <<- rhandsontable(extensionsData, 
                                         colHeaders = c("Extension", "Value", "Text"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE,
                                         height = 400) %>% 
      hot_table(stretchH = "none", highlightRow = TRUE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE, 
               colWidths = c(250, 85,0.01) ) %>% 
      hot_col(col = 'Text', colWidths=0.01)
    return(extensionsTableTmp)
  })
  
  toListenYears <- reactive({
    list(input$gmsbotime, input$gmseotime)
  })
  yearsAvailable <- c(1960:2200)
  observeEvent(toListenYears(), {
    yearsAvailable <<- c(input$gmsbotime:input$gmseotime)
  })
  
  #render milestonyr table
  output$milestonyr <- renderRHandsontable({
    rv$updateMilestonyr
    milestonyrTableTmp <<- rhandsontable(milestonyrData, 
                                         colHeaders = c("Year", "Text"),
                                         readOnly = FALSE, 
                                         rowHeaders = NULL,
                                         search = TRUE,
                                         height = 400) %>% 
      hot_table(stretchH = "all", highlightRow = TRUE) %>%
      hot_col(1,  type = "autocomplete", source = yearsAvailable, strict = TRUE, allowInvalid = FALSE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE) %>% 
      hot_col(col = 'Text', colWidths=0.001)
    return(milestonyrTableTmp)
  })
  
  #render solveropt table
  output$solveropt <- renderRHandsontable({
    rv$updateSolveropt
    solveroptTableTmp <<- rhandsontable(solveroptData, 
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
    rv$updateTimeslice
    timesliceTableTmp <<- rhandsontable(timesliceData, 
                                        colHeaders = c("Time Slice", "Text"),
                                        readOnly = FALSE, 
                                        rowHeaders = NULL,
                                        search = TRUE,
                                        height = 400) %>% 
      hot_table(stretchH = "none", highlightRow = TRUE) %>%
      hot_cols(manualColumnResize = TRUE, columnSorting = TRUE,
               colWidths = c(175, 0.01))
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
  
  outputOptions(output, "scenddmap", suspendWhenHidden = FALSE) 
  outputOptions(output, "extensions", suspendWhenHidden = FALSE) 
  outputOptions(output, "milestonyr", suspendWhenHidden = FALSE) 
  outputOptions(output, "timeslice", suspendWhenHidden = FALSE) 
  outputOptions(output, "ddFilesAdded", suspendWhenHidden = FALSE)
  outputOptions(output, "runFileAdded", suspendWhenHidden = FALSE)
  
  return(
    list(
      scenddmap = reactive({
        scenddmapTmp <- hot_to_r(input$scenddmap)
        if(length(scenddmapTmp) && nrow(scenddmapTmp) > 0){
          scenddmapTmp <- scenddmapTmp %>% replace_na(list(order = "", dd = "", offeps = FALSE, text = "")) %>% 
            filter(ddorder != "" & dd != "")
        }
        scenddmapTmp$offeps <- tolower(as.character(scenddmapTmp$offeps))
        scenddmapTmp
      }),
      extensions = reactive({
        extensionsTmp <- hot_to_r(input$extensions)
        if(length(extensionsTmp) && nrow(extensionsTmp) > 0){
          extensionsTmp <- extensionsTmp %>% filter(uni != "" & `uni#1` != "")
        }
        extensionsTmp
      }),
      milestonyr = reactive({
        milestonyrTmp <- hot_to_r(input$milestonyr)
        if(length(milestonyrTmp)){
          milestonyrTmp <- milestonyrTmp[order(milestonyrTmp$uni),]
        }
        if(length(milestonyrTmp) && nrow(milestonyrTmp) > 0){
          milestonyrTmp <- milestonyrTmp %>% filter(uni != "")
        }
        milestonyrTmp
      }),
      solveropt = reactive({
        solveroptTmp <- hot_to_r(input$solveropt)
        if(length(solveroptTmp) && nrow(solveroptTmp) > 0){
          solveroptTmp <- solveroptTmp %>% filter(uni != "" & `uni#1` != "" & `uni#2` != "")
        }
        solveroptTmp
      }),
      timeslice = reactive({
        timesliceTmp <- hot_to_r(input$timeslice)
        if(length(timesliceTmp) && nrow(timesliceTmp) > 0){
          timesliceTmp <- timesliceTmp %>% filter(uni != "")
        }
        timesliceTmp
      }),
      gmsobj = reactive({
        rv$updateGmsobj
      }),
      gmsrunlocation = reactive({
        paste0("||./", rv$runFile)
      }),
      gmsbotime = reactive({
        rv$updateGmsbotime
      }),
      gmseotime = reactive({
        rv$updateGmseotime
      }),
      gmsbratio = reactive({
        rv$updateGmsbratio
      }),
      gmsreslim = reactive({
        rv$updateGmsreslim
      }),
      gmssolver = reactive({
        rv$updateGmssolver
      }),
      gmsrunmode = reactive({
        paste0("||", input$runmode)
      })
    )
  )
  
}