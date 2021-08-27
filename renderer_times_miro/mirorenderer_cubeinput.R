mirorenderer_cubeinputOutput <- function(id, height = NULL, options = NULL, path = NULL){
    ns <- NS(id)
  
  # set default height
  if(is.null(height)){
    height <- 700
  } 
  tagList(tags$head(
    tags$style(HTML("
              .custom-css .row-custom {
                    margin-left: 0;
                    margin-right: 0;
              }
              .custom-css .align-items-center {
                    display: flex;
                    -webkit-box-align: center!important;
                    -ms-flex-align: center!important;
                    align-items: center!important;
              }
              .custom-css .align-items-center .col-sm-2,
              .custom-css .align-items-center .col-sm-3 {
                  flex-basis: 0;
                  -webkit-box-flex: 1;
                  -ms-flex-positive: 1;
                  flex-grow: 1;
                  max-width: 100%;
              }
              .custom-css .flow-chart {
                  min-height:250px;
              }
              .custom-css .flow-chart-outer {
                  margin: 10px 25pt 30pt 0;
                  padding-left: 50px;
                  padding-right: 50px;
                  background-color: #f1f1f18f;
                  box-shadow: inset 0 2px 4px 0 rgb(0 0 0 / 10%);
              }
              .custom-css .side-padding{
                  padding-left: 15px;
                  padding-right: 15px;
              }
              .custom-css .com-proc-item {
                line-height: 16px;
                font-size: 12px;
                text-align: center;
                border-radius: 20px;
                padding: 5px;
                display: block;
                box-shadow: 0 1px 4px rgb(0 0 0 / 10%);
                margin: 4px 3px;
                border: 1px solid;
                cursor: pointer;
                color: #1d2121;
                overflow-wrap: break-word;
              }
              .node-el {
                 border: 2px solid black;
                 padding: 5px;
                 text-align: center;
                 background-color: #fff;
                 overflow-wrap: break-word;
              }
              .flow-arrow {
                  text-align: center;
                  font-size:40px;
              }
              @media (prefers-color-scheme:dark){
                  .custom-css .com-proc-item,
                  .node-el {
                      background-color: #393e46;
                  }
                  .custom-css .flow-chart {
                      background-color: #4e545d;
                  }
                  .flow-arrow {
                      color: #1d2121;
                  }
              }
              .custom-css .com-proc-item:hover {
                  background-color: #e7e7e7;
                  border-color: #adadad;
                  color: #1d2121;
                  transition: all .5s ease;
              }
              .flow-item-list {
                  padding: 5px;
              }
              .custom-list {
                margin: 0;
                padding: 0;
              }
              .flow-row {
                margin: 10pt 0 35pt 0;
              }
              .legend-row {
                padding-top: 25pt;
                text-align: center;
              }
              .legend-row ul {
                display: inline;
              }
              .legend-row .legend-item {
                line-height: 10px;
                cursor: auto;
                padding: 5px 15px;
                display: inline-block;
              }
              ")
    )
  ),
  tags$div(class = "container custom-css", style = "width:100%;padding-left: 0;padding-right: 0;", 
           #define rendererOutput function here 
           tabsetPanel(
             id = ns("Switch"),
             type = "tabs",
             
             # Process Tab
             tabPanel("Process centric view", value = "tp_prc", style = "position:relative;",
                      icon = icon("cogs"),
                      tags$div(class = "small-space"),
                      
                      fluidRow(class = "row-custom", style = "margin-top: 5pt;",
                               column(9, 
                                      fluidRow(class="row-custom", 
                                                      selectInput(ns("sel_prc"), "Select process",
                                                                  choices = c(), width = "350px")
                                               )        
                                      ),
                               column(3, id = ns("ddInfoProc"), 
                                      style = "float:right;",
                                      h3(style = "margin-top:0;",
                                         textOutput(ns("selectedProcess"))),
                                      h4(textOutput(ns("processDesc")))
                               )
                      ),
                      fluidRow(class = "flow-row",
                        column(9, 
                               # Process View. Flowchart
                               fluidRow(id = ns("flowChartProc2"), class = "flow-chart-outer",
                                        fluidRow(class = "align-items-center flow-chart side-padding",
                                        column(width = 4,
                                               class = "flow-item-list",
                                               uiOutput(ns("prc_in"))
                                        ),
                                        column(width = 1, 
                                               class = "flow-arrow", 
                                               tags$div(id = ns("prc_in_arrow"), 
                                                        icon("long-arrow-alt-right"))
                                        ),
                                        column(width = 2, 
                                               uiOutput(ns("sel_button_prc"))
                                        ),
                                        column(width = 1, class = "flow-arrow",
                                               tags$div(id = ns("prc_out_arrow"), 
                                                        icon("long-arrow-alt-right"))
                                        ),
                                        column(width = 4, class = "flow-item-list",
                                               uiOutput(ns("prc_out"))
                                        )),
                                        fluidRow(class = "legend-row side-padding",
                                          uiOutput(ns("prcViewLegend"))
                                        )  
                               )      
                        ),
                        column(3, id = ns("ddInfoProc2"), 
                               style = "float:right;",
                               dataTableOutput(ns("ddInfoPrc"))
                        )
                      ),
                      # Data View process
                      fluidRow(class = "row-custom side-padding",
                               dataTableOutput(ns("data_prc"))
                      )),
             
             # Commodity Tab
             tabPanel("Commodity centric view", value = "tp_com", style = "position:relative;",
                      icon = icon("coins"),
                      tags$div(class = "small-space"),
                      fluidRow(class = "row-custom", style = "margin-top: 5pt;",
                               column(9, 
                                      fluidRow(class="row-custom", 
                                               selectInput(ns("sel_com"), "Select commodity",
                                                           choices = c(), width = "350px")
                                      )        
                               ),
                               column(3, id = ns("ddInfoCom"), 
                                      style = "float:right;",
                                      h3(style = "margin-top:0;",
                                         textOutput(ns("selectedCommodity"))),
                                      h4(textOutput(ns("commodityDesc")))
                               )
                      ),
                      fluidRow(class = "flow-row",
                               column(9, 
                                      # Commodity View. Flowchart
                                      fluidRow(id = ns("flowChartCom2"), class = "flow-chart-outer",
                                               fluidRow(class = "align-items-center flow-chart side-padding",
                                                        column(width = 4, class = "flow-item-list",
                                                               uiOutput(ns("com_in"))
                                                        ),
                                                        column(width = 1, 
                                                               class = "flow-arrow", 
                                                               tags$div(id = ns("com_in_arrow"), 
                                                                        icon("long-arrow-alt-right"))
                                                        ),
                                                        column(width = 2,
                                                               uiOutput(ns("sel_button_com"))
                                                        ),
                                                        column(width = 1, class = "flow-arrow", 
                                                               tags$div(id = ns("com_out_arrow"), 
                                                                        icon("long-arrow-alt-right"))
                                                        ),
                                                        column(width = 4, class = "flow-item-list",
                                                               uiOutput(ns("com_out"))
                                                        )),
                                               fluidRow(class = "legend-row side-padding",
                                                        uiOutput(ns("comViewLegend"))
                                               )
                                      )
                               ),
                               column(3, id = ns("ddInfoCom2"), 
                                      style = "float:right;",
                                      dataTableOutput(ns("ddInfoCom"))
                               )
                      ),
                      # Data commodity view
                      fluidRow(class = "row-custom side-padding",
                        dataTableOutput(ns("data_com"))
                      )
             )
           )
  )
  )
}

renderMirorenderer_cubeinput <- function(input, output, session, data, options = NULL, path = NULL, rendererEnv = NULL, views = NULL, outputScalarsFull = NULL, ...){
  ns <- session$ns
  prcViewTypeIn <- reactiveVal(character(0L))
  prcViewTypeOut <- reactiveVal(character(0L))
  comViewTypeIn <- reactiveVal(character(0L))
  comViewTypeOut <- reactiveVal(character(0L))
  rv <- reactiveValues(update = 1)
  
  # Create inputs first
  data <- mutate_if(data, is.factor, as.character)
  
  uelMap <- suppressWarnings(jsonlite::fromJSON(
    file.path(path, "map.txt"),simplifyDataFrame = FALSE, 
    simplifyMatrix = FALSE, flatten = TRUE))

  
  col_names_header <- c("dd", "uni#2", "uni#1", "uni", "all_ts")

  topData <- data %>% dplyr::filter(siname == "TOP")
  noTopData <- data %>% dplyr::filter(siname != "TOP")

  processes <- topData %>%
    dplyr::pull(prc) %>% 
    unique() %>%
    sort()
  
  commodities <- topData %>% 
      dplyr::pull(com_grp) %>% 
      unique() %>% 
      sort()
  
  updateSelectInput(session, "sel_prc", choices = c("All", processes), selected = processes[1])
  updateSelectInput(session, "sel_com", choices = c("All", commodities), selected = commodities[1])
  
  # Observer
  rendererEnv[[ns("comBtn")]] <- observe({
    req(input$com_button)
    updateTabsetPanel(session, "Switch", selected = "tp_com")
    updateSelectInput(session, "sel_com", selected = input$com_button)
    
  })
  rendererEnv[[ns("prcBtn")]] <- observe({
    req(input$prc_button)
    updateTabsetPanel(session, "Switch", selected = "tp_prc")
    updateSelectInput(session, "sel_prc", selected = input$prc_button)
    
  })
  
  #processInData is also used for commodity out data
  processInData <- topData %>% dplyr::filter(uni == "IN")
  processOutData <- topData %>% dplyr::filter(uni == "OUT") 
  
  colorMap <- c("pre" = "#ffe699", "ire" = "#c6e0b4", "ele" = "#305496", "dmd" = "#acb9ca", "nrg" = "#f4b084", "env" = "#c6e0b4", "dem" = "#acb9ca", "unknown" = "noData")
  #"elc" subtype of NRG?
  darkColors <- ("#305496")
  
  #process IN
  output$prc_in <- renderUI({
    req(input$sel_prc)
    if(!identical(input$sel_prc, "All")){
      # Selected process and commodity
      prc_com_in <- processInData %>% dplyr::filter(prc == input$sel_prc) %>% 
        dplyr::pull(com_grp) %>% unique() %>% sort()
      if(length(prc_com_in)){
        showEl(session, paste0("#", ns("prc_in_arrow")))
      }else{
        hideEl(session, paste0("#", ns("prc_in_arrow")))
      }
      isolate(prcViewTypeIn(character(0)))
      allTypes <<- c()
      tags$ul(class = if(length(prc_com_in)) "custom-list", 
              lapply(prc_com_in, function(x){
                type <- noTopData %>%
                  dplyr::filter(uni == x) %>% 
                  filter(tolower(siname) == "com_tmap") %>% 
                  dplyr::pull("com_grp") %>% unique()
                color <- unname(colorMap[tolower(type)])
                if(!length(color)) color <- ""
                allTypes <<- unique(c(allTypes, type))
                if(identical(x, prc_com_in[length(prc_com_in)])){
                  isolate(prcViewTypeIn(allTypes))
                }
                tags$li(x,
                        onclick = paste0("Shiny.setInputValue('", ns("com_button"), "', '",
                                         x, "', {priority: 'event'})"),
                        class = "com-proc-item",
                        style = paste0("list-style-type:none;background-color:  ", 
                                       color, "; color: ", if(color %in% darkColors) "#eee;")
                )
              }))
    }else{
      return()
    }
  })
  
  #process OUT
  output$prc_out <- renderUI({
    req(input$sel_prc)
    if(!identical(input$sel_prc, "All")){
      prc_com_out <- processOutData %>% dplyr::filter(prc == input$sel_prc) %>% 
        dplyr::pull(com_grp) %>% unique() %>% sort()
      if(length(prc_com_out)){
        showEl(session, paste0("#", ns("prc_out_arrow")))
      }else{
        hideEl(session, paste0("#", ns("prc_out_arrow")))
      }
      isolate(prcViewTypeOut(character(0)))
      allTypes <<- c()
      tags$ul(class = if(length(prc_com_out)) "custom-list", 
              lapply(prc_com_out, function(x){
                type <- noTopData %>%
                  dplyr::filter(uni == x) %>% 
                  filter(tolower(siname) == "com_tmap") %>% 
                  dplyr::pull("com_grp") %>% unique()
                color <- unname(colorMap[tolower(type)])
                if(!length(color)) color <- ""
                allTypes <<- unique(c(allTypes, type))
                if(identical(x, prc_com_out[length(prc_com_out)])){
                  isolate(prcViewTypeOut(allTypes))
                }
                tags$li(x,
                        onclick = paste0("Shiny.setInputValue('", ns("com_button"), "', '",
                                         x, "', {priority: 'event'})"),
                        class = "com-proc-item",
                        style = paste0("list-style-type:none;background-color:  ", 
                                       color, "; color: ", if(color %in% darkColors) "#eee;")
                )
              }))
    }else{
      return()
    }
  })
  
  #Commodity IN
  output$com_in <- renderUI({
    req(input$sel_com)
    if(!identical(input$sel_com, "All")){
      com_prc_in <- processOutData %>% dplyr::filter(com_grp == input$sel_com) %>% 
        dplyr::pull(prc) %>% unique() %>% sort()
      if(length(com_prc_in)){
        showEl(session, paste0("#", ns("com_in_arrow")))
      }else{
        hideEl(session, paste0("#", ns("com_in_arrow")))
      }
      isolate(comViewTypeIn(character(0)))
      allTypes <<- c()
      tags$ul(class = if(length(com_prc_in)) "custom-list", 
              lapply(com_prc_in, function(x){
                type <- noTopData %>%
                  dplyr::filter(prc == x) %>%
                  dplyr::filter(tolower(siname) == "prc_map") %>%
                  dplyr::pull("uni") %>% unique()
                color <- unname(colorMap[tolower(type)])
                if(!length(color)) color <- ""
                allTypes <<- unique(c(allTypes, type))
                if(identical(x, com_prc_in[length(com_prc_in)])){
                  isolate(comViewTypeIn(allTypes))
                }
                tags$li(x,
                        onclick = paste0("Shiny.setInputValue('", ns("prc_button"), "', '",
                                         x, "', {priority: 'event'})"),
                        class = "com-proc-item",
                        style = paste0("list-style-type:none;background-color: ", 
                                       color, "; color: ", if(color %in% darkColors) "#eee;")
                )
              }))
    }else{
      return()
    }
  })
  
  output$com_out <- renderUI({
    req(input$sel_com)
    if(!identical(input$sel_com, "All")){
      com_prc_out <- processInData %>% dplyr::filter(com_grp == input$sel_com) %>% 
        dplyr::pull(prc) %>% unique() %>% sort()
      if(length(com_prc_out)){
        showEl(session, paste0("#", ns("com_out_arrow")))
      }else{
        hideEl(session, paste0("#", ns("com_out_arrow")))
      }
      isolate(comViewTypeOut(character(0)))
      allTypes <<- c()
      tags$ul(class = if(length(com_prc_out)) "custom-list", 
              lapply(com_prc_out, function(x){
                type <- noTopData %>%
                  dplyr::filter(prc == x) %>%
                  dplyr::filter(tolower(siname) == "prc_map") %>%
                  dplyr::pull("uni") %>% unique()
                color <- unname(colorMap[tolower(type)])
                if(!length(color)) color <- ""
                allTypes <<- unique(c(allTypes, type))
                if(identical(x, com_prc_out[length(com_prc_out)])){
                  isolate(comViewTypeOut(allTypes))
                }
                tags$li(x,
                        onclick = paste0("Shiny.setInputValue('", ns("prc_button"), "', '",
                                         x, "', {priority: 'event'})"),
                        class = "com-proc-item",
                        style = paste0("list-style-type:none;background-color:  ", 
                                       color, "; color: ", if(color %in% darkColors) "#eee;")
                )
              }))
    }else{
      return()
    }
  })
  
  output$prcViewLegend <- renderUI({
    req(input$sel_prc)
    if(identical(input$sel_prc, "All")){
      return()
    }
    tags$ul(
      lapply(unique(c(prcViewTypeIn(), prcViewTypeOut())), function(x){
        color <- unname(colorMap[tolower(x)])
        if(!length(color)) color <- ""
        tags$li(x,
                class = "com-proc-item legend-item",
                style = paste0("list-style-type:none;background-color:  ", 
                               color, "; color: ", if(color %in% darkColors) "#eee;")
        )
      }))
  })
  output$comViewLegend <- renderUI({
    req(input$sel_com)
    if(identical(input$sel_com, "All")){
      return()
    }
    tags$ul(
      lapply(unique(c(comViewTypeIn(), comViewTypeOut())), function(x){
        color <- unname(colorMap[tolower(x)])
        if(!length(color)) color <- ""
        tags$li(x,
                class = "com-proc-item legend-item",
                style = paste0("list-style-type:none;background-color:  ", 
                               color, "; color: ", if(color %in% darkColors) "#eee;")
        )
      }))
  })
  
  output$sel_button_prc <- renderUI(tags$div(class = "node-el", input$sel_prc))
  output$sel_button_com <- renderUI(tags$div(class = "node-el", input$sel_com))
  
  # Select data
  # Process-centric view data table
  output$data_prc <- renderDataTable({
    req(input$sel_prc)
    
    tableData <- noTopData 
    if(!identical(input$sel_prc, "All")){
      tableData <- tableData %>% dplyr::filter(prc == input$sel_prc)
    }
    hiddenEmptyColsTmp <- which(vapply(tableData,
                                       function(x) identical(as.character(unique(x)), "-"),
                                       logical(1L), USE.NAMES = FALSE))
    columnDefsTmp <- list(list(visible = FALSE, targets = hiddenEmptyColsTmp -1L))    
    tableObj <- DT::datatable(tableData, filter = "bottom",  rownames= FALSE,
                              options = list(columnDefs = columnDefsTmp))
    return(tableObj)
  })
  
  # Commodity-centric view data table
  output$data_com <- renderDataTable({
    req(input$sel_com)
    
    tableData <- noTopData 
    if(!identical(input$sel_com, "All")){
      tableData <- tableData %>% dplyr::filter(com_grp == input$sel_com)
    }
    hiddenEmptyColsTmp <- which(vapply(tableData,
                                       function(x) identical(as.character(unique(x)), "-"),
                                       logical(1L), USE.NAMES = FALSE))
    columnDefsTmp <- list(list(visible = FALSE, targets = hiddenEmptyColsTmp -1L))                                   
    tableObj <- DT::datatable(tableData, filter = "bottom", rownames= FALSE, 
                              options = list(columnDefs = columnDefsTmp))
    return(tableObj)
  })
  
  # Header of the process info table
  output$selectedProcess <- renderText(input$sel_prc)
  output$processDesc <- renderText({
    req(input$sel_prc, !identical(input$sel_prc, "All"))
    text <- vapply(uelMap$prc_desc, function(reg){
      if(length(reg[[input$sel_prc]])){
        return(unname(reg[[input$sel_prc]]))
      }
      return()
    }, character(1L), USE.NAMES = FALSE)
    
    return(paste(text[!duplicated(tolower(text))], collapse = ", "))
  })
  
  # Header of the commodity info table
  output$selectedCommodity <- renderText(input$sel_com)
  output$commodityDesc <- renderText({
    req(input$sel_com, !identical(input$sel_com, "All"))
    text <- vapply(uelMap$com_desc, function(reg){
      if(length(reg[[input$sel_com]])){
        return(unname(reg[[input$sel_com]]))
      }
      return()
    }, character(1L), USE.NAMES = FALSE)
    return(paste(text[!duplicated(tolower(text))], collapse = ", "))
  })
  
  names_header <- c("Scenario", "Sector", "Type", "Activity Unit", "Timeslice LVL")
  
  #dd files info (processes)
  output$ddInfoPrc <- renderDataTable({
    req(input$sel_prc, !identical(input$sel_prc, "All"))

    data_prc_temp <- noTopData %>% dplyr::filter(prc == input$sel_prc)

    scen <- data_prc_temp %>% dplyr::pull("dd") %>% unique()
    #TODO
    sector <- ""
    type <- data_prc_temp %>% 
      dplyr::filter(tolower(siname) == "prc_map") %>%
      dplyr::pull("uni") %>% unique()
    #TODO
    subType <- ""
    actUnit <- data_prc_temp %>%
      dplyr::filter(tolower(siname) == "prc_actunt") %>%
      dplyr::pull("uni") %>% unique()
    #TODO
    capUnit <- ""
    sets <- ""
    tslvl <- data_prc_temp %>%
      dplyr::filter(tolower(siname) == "prc_tsl") %>%
      dplyr::pull("all_ts") %>% unique()
    if(is.null(tslvl)){
      if(type %in% c("ELE", "STGTSS", "STGIPS")){
        tslvl <- "DAYNITE"
      }else if(type %in% c("CHP", "HPL")){
        tslvl <- "SEASON"
      }else{
        tslvl <- "ANNUAL"
      }
    }
    #TODO
    vintage <- ""
    #TODO
    com_prc_in <- processOutData %>% dplyr::filter(com_grp == input$sel_com) %>% 
      dplyr::pull(prc) %>% unique() %>% sort()
    com_prc_out <- processInData %>% dplyr::filter(com_grp == input$sel_com) %>% 
      dplyr::pull(prc) %>% unique() %>% sort()
    #TODO: user overwrites defaults?
    # pcgOrder <- c("DEM", "MAT", "NRG", "ENV", "FIN")
    # if(length(com_prc_in) > 1 || length(com_prc_out) > 1){
    #   
    # }
    pcg <- ""
    region <- data_prc_temp %>%
      dplyr::filter(tolower(siname) == "prc_actunt") %>%
      dplyr::pull("all_reg") %>% unique()
    
    tableData <- data.frame(key = character(0), value = character(0)) %>%
      add_row(key = "Scenario", value = paste(scen, collapse = ", ")) %>%
      add_row(key = "Sector", value = paste(sector, collapse = ", ")) %>%
      add_row(key = "Type", value = paste(type, collapse = ", ")) %>%
      add_row(key = "SubType", value = paste(subType, collapse = ", ")) %>%
      add_row(key = "Activity Unit", value = paste(actUnit, collapse = ", ")) %>%
      add_row(key = "Capacity Unit", value = paste(capUnit, collapse = ", ")) %>%
      add_row(key = "Sets", value = paste(sets, collapse = ", ")) %>%
      add_row(key = "TimeSlice LVL", value = paste(tslvl, collapse = ", ")) %>%
      add_row(key = "Vintage", value = paste(vintage, collapse = ", ")) %>%
      add_row(key = "PCG", value = paste(pcg, collapse = ", ")) %>%
      add_row(key = "Region", value = paste(region, collapse = ", "))
    
    tableObj <- DT::datatable(tableData, rownames = FALSE, colnames = c("", ""),
                              class = "compact", 
                              options = list(pageLength = 15,
                                             dom = 't', bSort=FALSE,
                                             autoWidth = FALSE,
                                             columnDefs = list(list(width = '30%', 
                                                                    targets = c(0)), 
                                                               list(width = '70%', 
                                                                    targets = c(1))))) %>%
      DT::formatStyle(names(tableData),lineHeight='95%') 
    return(tableObj)
  })
  
  #dd files info (commodities)
  output$ddInfoCom <- renderDataTable({
    req(input$sel_com, !identical(input$sel_com, "All"))
    
    data_com_temp <- noTopData %>% dplyr::filter(com_grp == input$sel_com) 
    
    scen <- data_com_temp %>% dplyr::pull("dd") %>% unique()
    scen <- scen[!tolower(scen) %in% "syssettings"]
    # type <- unname(uelMap$com_tmap$reg1[input$sel_com][[1]])
    type <- noTopData %>%
      dplyr::filter(uni == input$sel_com) %>% 
      filter(tolower(siname) == "com_tmap") %>% 
      dplyr::pull("com_grp") %>% unique()
    subType <- unname(uelMap$nrg_tmap$reg1[input$sel_com][[1]])
    actUnit <- data_com_temp %>% 
      dplyr::filter(tolower(siname) == "com_unit") %>% 
      dplyr::pull("uni") %>% unique()
    #TODO
    sets <- ""
    tslvl <- data_com_temp %>% 
      dplyr::filter(tolower(siname) == "com_tsl") %>% 
      dplyr::pull("all_ts") %>% unique()
    if(is.null(tslvl)){
        tslvl <- "ANNUAL"
    }
    #TODO
    limType <- ""
    peakTs <- ""
    region <- data_com_temp %>% 
      dplyr::filter(tolower(siname) == "com_unit") %>% 
      dplyr::pull("all_reg") %>% unique()
    
    tableData <- data.frame(key = character(0), value = character(0)) %>%
      add_row(key = "Scenario", value = paste(scen, collapse = ", ")) %>%
      add_row(key = "Type", value = paste(type, collapse = ", ")) %>%
      add_row(key = "SubType", value = paste(subType, collapse = ", ")) %>%
      add_row(key = "Activity Unit", value = paste(actUnit, collapse = ", ")) %>%
      add_row(key = "Sets", value = paste(sets, collapse = ", ")) %>%
      add_row(key = "TSLVL", value = paste(tslvl, collapse = ", ")) %>%
      add_row(key = "LimType", value = paste(limType, collapse = ", ")) %>%
      add_row(key = "PeakTS", value = paste(peakTs, collapse = ", ")) %>%
      add_row(key = "Region", value = paste(region, collapse = ", "))
    
    tableObj <- DT::datatable(tableData, rownames = FALSE, colnames = c("", ""),
                              class = "compact", 
                              options = list(dom = 't', bSort=FALSE,
                                             autoWidth = FALSE,
                                             columnDefs = list(list(width = '30%', 
                                                                    targets = c(0)), 
                                                               list(width = '70%', 
                                                                    targets = c(1))))) %>%
      DT::formatStyle(names(tableData),lineHeight='95%') 
    return(tableObj)
  })
  
  observeEvent(input$sel_prc, {
    #hide dd info table and flows if "All" is selected
    if(identical(input$sel_prc, "All")){
      hideEl(session, paste0("#", session$ns("flowChartProc")))
      hideEl(session, paste0("#", session$ns("ddInfoProc")))
      hideEl(session, paste0("#", session$ns("flowChartProc2")))
      hideEl(session, paste0("#", session$ns("ddInfoProc2")))
    }else{
      showEl(session, paste0("#", session$ns("flowChartProc")))
      showEl(session, paste0("#", session$ns("ddInfoProc")))
      showEl(session, paste0("#", session$ns("flowChartProc2")))
      showEl(session, paste0("#", session$ns("ddInfoProc2")))
    }
  })
  observeEvent(input$sel_com, {
    #hide dd info table and flows if "All" is selected
    if(identical(input$sel_com, "All")){
      hideEl(session, paste0("#", session$ns("flowChartCom")))
      hideEl(session, paste0("#", session$ns("ddInfoCom")))
      hideEl(session, paste0("#", session$ns("flowChartCom2")))
      hideEl(session, paste0("#", session$ns("ddInfoCom2")))
    }else{
      showEl(session, paste0("#", session$ns("flowChartCom")))
      showEl(session, paste0("#", session$ns("ddInfoCom")))
      showEl(session, paste0("#", session$ns("flowChartCom2")))
      showEl(session, paste0("#", session$ns("ddInfoCom2")))
    }
  })
}
