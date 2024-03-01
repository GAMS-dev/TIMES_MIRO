mirocompare_explorerOutput <- function(id, height = NULL, options = NULL, path = NULL){
  
  ns <- NS(id)
  
  customRadioButtons <- function(inputId, icons, values){
    # from https://stackoverflow.com/a/65043076
    radios <- lapply(
      seq_along(icons),
      function(i) {
        id <- paste0(inputId, i)
        tagList(
          if(i == 1) {
            tags$input(
              type = "radio",
              name = inputId,
              id = id,
              class = "input-hidden",
              value = as.character(values[i]),
              checked = "checked"
            )
          } else {
            tags$input(
              type = "radio",
              name = inputId,
              id = id,
              class = "input-hidden",
              value = as.character(values[i])
            )
          },
          tags$label(
            class="btn btn-default btn-custom",
            `for` = id,
            tags$div(
              shiny::icon(icons[i])
            )
          )
        )
      }
    )
    do.call(
      function(...) div(..., class = "shiny-input-radiogroup radio-styles", id = inputId), 
      radios
    )
  }
  tagList(
    tags$head(
      tags$script(JS(paste0("$(document).on('click', '#", ns("valueboxes"), " .shiny-html-output', 
              function(){
                  Shiny.setInputValue('",ns("showChart"),"',this.id,{ priority:'event'})
                  
              })")))
    ),
    tags$div(class = "custom-css custom-compare",
             tabsetPanel(id = ns("outputTabs"),
                         type = c("tabs"),
                         
                         ########################################
                         ############### Dashboard ##############
                         ########################################
                         tabPanel(class = "default-height",
                                  textOutput(ns("dashboardTabName")),
                                  value = "dashboard",
                                  fluidRow(class = "outer-row", style="margin:0px;",
                                           column(12, class = "custom-grid-right",
                                                  fluidRow(class="display-flex valueboxes",
                                                           uiOutput(ns("valueboxes"))
                                                  )
                                           ),
                                           column(12, id = ns("dataView"), class = "custom-grid-left padding-custom",
                                                  fluidRow(
                                                    uiOutput(ns("dataViews")),
                                                  )
                                           ),
                                           column(12, id = ns("noDataView"), class = "custom-grid-left padding-custom add-margin", style = "display:none;",
                                                  tags$h4("No output data available", class="highlight-block"),
                                                  tags$h4(class = "no-data-text",
                                                          "Please make sure to configure proper settings 
                                 in the input section to get results that can be displayed."
                                                  ))
                                  )
                         ),
                         
                         
                         #####################################
                         ########## Data Explorer ############
                         #####################################
                         tabPanel(class = "default-height",
                                  textOutput(ns("dataExplorerTabName")),
                                  value = "dataExplorer",
                                  tags$br(),
                                  sidebarLayout(
                                    
                                    # Creating the chart type selection
                                    sidebarPanel(width = 3,
                                                 customRadioButtons(
                                                   ns("chart_type"),
                                                   icons = c("chart-line", "chart-column", "chart-area", "percent", "table"),
                                                   values = c("line", "column", "area", "column_percent", "table")
                                                 ),
                                                 
                                                 # Adding tech and fuel switch
                                                 span(title=HTML("Toggle to switch between Plot by Fuels and Plot by Technologies"),
                                                      radioButtons(ns("Tech_Fuel_Switch"), label = NULL, inline = TRUE,
                                                                   choices = c("Plot by Fuels", "Plot by Technologies")
                                                      )
                                                 ),
                                                 
                                                 span(title=HTML("Dropdown to select between Fuels or Technologies in groups or separated"),
                                                      selectInput(ns("plot_by"), label = NULL, 
                                                                  choices = c("Fuels Grouped", "Fuels Separated"))
                                                 ),
                                                 
                                                 # Dropdowns
                                                 selectInput(ns("subsector"), label = NULL, choices = c("All Sectors" = "All Subsectors")),
                                                 selectInput(ns("enduse"), label = NULL, choices = c()),
                                                 selectInput(ns("tech"), label = NULL, choices = c()),
                                                 selectInput(ns("unit"), label = NULL, choices = c()),
                                                 
                                    ),
                                    
                                    # Adding the Sector tabs
                                    mainPanel(width = 9,
                                              uiOutput(ns("tabsContent"))
                                    )
                                  )
                         )
             )
    )
  )
}
renderMirocompare_explorer <- function(input, output, session, data, options = NULL, path = NULL, rendererEnv = NULL, views = NULL, ...){
  ns <- session$ns
  
  removeTableHeader <- function(viewData) {
    numericColumnNames <- viewData[sapply(viewData, is.numeric)] %>% names()
    
    if (length(numericColumnNames) > 1) {
      viewData <- viewData %>%
        pivot_longer(cols = numericColumnNames,
                     names_to = "Hdr",
                     values_to = "value")
    }
    
    return(viewData)
  }
  
  combineData <- function(data, scenarioNames) {
    non_empty_data <- Filter(function(tibble) nrow(tibble) > 0, data)
    
    if (length(non_empty_data) == 0) {
      return(NULL)
    }
    
    # GAMS Tables need to be lengthened to only have one value column
    numericColumnNames <- data[[1]] %>%
      select(where(is.numeric)) %>%
      names()
    
    dataTmp <- data
    if (length(numericColumnNames) > 1) {
      dataTmp <- lapply(data, removeTableHeader)
    }
    
    non_value_cols  <- setdiff(colnames(dataTmp[[1]]), "value")
    combinedData <- dataTmp %>% purrr::reduce(full_join, by = non_value_cols)
    colnames(combinedData) <- c(non_value_cols, scenarioNames)
    
    return(combinedData)
  }
  
  scenarioNames <- lapply(data$getMetadata(), function(x) x$`_sname`) %>% 
    unlist()
  
  cubeoutputData <- combineData(data$get("cubeoutput"), scenarioNames)
  
  ### Check for existing result data
  if (!nrow(cubeoutputData)) {
    hideEl(session, paste0("#", session$ns("dataView")))
    showEl(session, paste0("#", session$ns("noDataView")))
  } else {
    hideEl(session, paste0("#", session$ns("noDataView")))
    showEl(session, paste0("#", session$ns("dataView")))
    
    if(length(scenarioNames)) {
      cubeoutputData <- cubeoutputData %>% 
        select(-all_of(scenarioNames[1]))
      scenarioNames <- scenarioNames[-1]
    }
  }
  
  
  
  ########################################
  ######### Read Configuration ###########
  ########################################
  config <- jsonlite::fromJSON(file.path(customRendererDir,"config.json"), flatten = TRUE)
  
  generalConfig <- config$generalConfig
  
  if(!length(generalConfig$tabNames)) {
    abortSafe("Must provide at least one tab name.")
  }
  
  # Tab names
  output$dashboardTabName <- renderText({generalConfig$tabNames$dashboard})
  output$dataExplorerTabName <- renderText({generalConfig$tabNames[["dataExplorer"]]})
  
  ###################################################
  ################ Data processing ##################
  ###################################################
  
  # Data processing and data explorer code was taken from https://github.com/EECA-NZ/TIMES-NZ-Visualisation (MIT licensed)
  # The code has been modified to meed the requirements of this application
  
  dataProcessing <- config$dataProcessing
  
  # Removed excludeColumns from configuration file since most columns are mandatory in the rest of the code. 
  dataProcessing$excludeColumns <- c("sow")
  if (length(dataProcessing$excludeColumns)){
    for (exclude in dataProcessing$excludeColumns) {
      if(exclude %in% colnames(cubeoutputData))
        cubeoutputData <- cubeoutputData %>% select(-all_of(exclude))
    }
  } 
  
  # Removed columnNames from configuration file since rest of code needs certain names fixed. 
  dataProcessing$columnNames <- c("Attribute","Commodity", "Process", "Period", "Region", "Vintage", "TimeSlice", "UserConstraint", "Value")
  if (length(dataProcessing$columnNames)){
    colNames <- dataProcessing$columnNames
    noValueCol <- colNames[!tolower(colNames) == "value"]
    if(length(noValueCol) == length(colnames(cubeoutputData)[!colnames(cubeoutputData) %in% scenarioNames])){
      colnames(cubeoutputData) <- c(noValueCol, scenarioNames)
    } else {
      abortSafe(
        sprintf(
          "Number of column dimensions provided in dataProcessing$columnNames (excluding value/scenario column(s)) does not match the number of columns in the data. Current data colum names are '%s'",
          colnames(noValueCol)
        ))
    }
  }
  
  if(isTRUE(dataProcessing$excludeNonNumericPeriods)){
    cubeoutputData <- cubeoutputData %>%
      filter(grepl("^[0-9]+$", Period)) 
  }
  
  if(length(dataProcessing$skip)){
    for (skip in names(dataProcessing$skip)) {
      cubeoutputData <- cubeoutputData %>% 
        filter(!(!!sym(skip) %in% dataProcessing$skip[[skip]]))
    }
  }
  
  #######################
  #### Data explorer ####
  #######################
  
  dataExplorer <- config$scenCompareDataExplorer
  
  if(length(dataExplorer) && length(generalConfig$tabNames[["dataExplorer"]])){
    
    # Import schema
    
    # Data schema
    if (!length(dataExplorer$schemaFiles) || !length(dataExplorer$schemaFiles$dataSchema)) {
      abortSafe("Need to provide data schema in order to use the data explorer tab.")
    }
    schema_all   <- read_xlsx(file.path(customRendererDir, dataExplorer$schemaFiles$dataSchema))
    
    if(!all(c("Attribute",	"Process",	"Commodity",	"Sector",	"Subsector",	
              "Technology",	"Fuel",	"Enduse",	"Unit",	"Parameters",	"FuelGroup") %in% 
            colnames(schema_all))) {
      abortSafe("Data schema must include the following column names: 'Attribute',	'Process',	'Commodity',	'Sector',	'Subsector',	'Technology',	'Fuel',	'Enduse',	'Unit',	'Parameters',	'FuelGroup'")
    }
    
    # Color schema
    if(length(dataExplorer$schemaFiles$colorSchema)){
      schema_colors <- read_xlsx(file.path(customRendererDir, dataExplorer$schemaFiles$colorSchema))
      if(!all(c("Fuel", "Colors", "Symbol") %in% colnames(schema_colors))) {
        abortSafe("Color schema must include the following column names: 'Fuel', 'Colors', 'Symbol'")
      }
    }
    
    # Technology schema
    if (!length(dataExplorer$schemaFiles$technologySchema)) {
      abortSafe("Need to provide technology schema in order to use the data explorer tab.")
    }
    schema_technology <- read_xlsx(file.path(customRendererDir, dataExplorer$schemaFiles$technologySchema))
    
    if(!all(c("Technology", "Technology_Group") %in% colnames(schema_technology))) {
      abortSafe("Technology schema must include the following column names: 'Technology', 'Technology_Group'")
    }
    
    # merge schema data
    
    clean_df <- cubeoutputData %>%  
      # map the schema to the raw data. code was implicitly doing an outer join - this is now done explicitly
      inner_join(schema_all, cubeoutputData, by = c("Attribute", "Process", "Commodity"), relationship = "many-to-many") %>%
      # map the technology schema to the data
      inner_join(schema_technology, clean_df, by = c("Technology"))
    
    # Extract the needed attributes and Commodities
    # Removed neededAttributes from configuration file.
    dataExplorer$neededAttributes <- c("VAR_Act", "VAR_Cap", "VAR_FIn", "VAR_FOut")
    if(length(dataExplorer$neededAttributes)){
      tryCatch(
        {
          clean_df <- clean_df %>%
            filter(Attribute %in% dataExplorer$neededAttributes) 
        },
        error = function(e) {
          abortSafe(
            sprintf(
              "Problems in data processing. Error message: '%s'. Make sure your scenario data matches your configuration.",
              conditionMessage(e)
            )
          )
        }
      )
    }
    
    if(!is.null(dataExplorer$nonEmissionFuel$fuels) && length(dataExplorer$nonEmissionFuel$fuels)){
      tryCatch(
        {
          # Setting Emission values to zero for non emission fuel
          clean_df <- clean_df %>%
            mutate(across(all_of(scenarioNames), 
                          ~ ifelse(Fuel %in% dataExplorer$nonEmissionFuel$fuels & Parameters == dataExplorer$nonEmissionFuel$emissionParameter, 0, .))
            )
        },
        error = function(e) {
          abortSafe(
            sprintf(
              "Problems in data processing. Error message: '%s'. Make sure your scenario data matches your configuration.",
              conditionMessage(e)
            )
          )
        }
      )
    }
    
    tryCatch(
      {
        clean_df <- clean_df %>%
          # complete data for all period by adding zeros
          complete(Period,nesting(Sector, Subsector, Technology, Enduse, Unit, Parameters, Fuel, FuelGroup, Technology_Group), 
                   fill = as.list(setNames(unlist(lapply(scenarioNames, function(name) setNames(0, name))), scenarioNames)))
      },
      error = function(e) {
        abortSafe(
          sprintf(
            "Problems in data processing. Error message: '%s'. Make sure your scenario data matches your configuration.",
            conditionMessage(e)
          )
        )
      }
    )
    
    
    # Apply data mutations
    if(length(dataExplorer$mutateColumns)){
      tryCatch(
        {
          mutate_columns <- dataExplorer$mutateColumns
          
          apply(mutate_columns, 1, function(row) {
            targetColumn <- as.character(row["targetColumn"])
            conditionColumn <- as.character(row["conditionColumn"])
            condition <- as.character(row["condition"])
            newValue <- as.character(row["newValue"])
            
            if(identical(tolower(targetColumn), "value")) {
              clean_df <<- clean_df %>%
                mutate(across(all_of(scenarioNames), 
                              ~ ifelse(!!sym(conditionColumn) == condition, 
                                       # make sure to replace 'Value' strings in newValue with current scenario column name
                                       eval(parse(text = stringr::str_replace(newValue, "Value", as.character(cur_column())))), 
                                       .)
                ))
              
            } else {
              clean_df <<- clean_df %>%
                mutate(!!sym(targetColumn) := ifelse(!!sym(conditionColumn) == condition,
                                                     newValue,
                                                     !!sym(targetColumn)))
            }
          })
        },
        error = function(e) {
          abortSafe(
            sprintf(
              "Problems in data processing. Error message: '%s'. Make sure your scenario data matches your configuration.",
              conditionMessage(e)
            )
          )
        }
      )
    }
    
    tryCatch(
      {
        clean_df <- clean_df %>%
          # Remove the hard coded "N/A" in the data
          filter(!(Technology == "N/A")) %>% 
          # Group by the main variables and sum up
          group_by(Sector, Subsector, Technology, Enduse, Unit, Parameters, Fuel,Period, FuelGroup,Technology_Group) %>%
          # Sum up
          summarise(across(all_of(scenarioNames), sum), .groups = "drop") 
      },
      error = function(e) {
        abortSafe(
          sprintf(
            "Problems in data processing. Error message: '%s'. Make sure your scenario data matches your configuration.",
            conditionMessage(e)
          )
        )
      }
    )
    
    
    # Remove unused data
    if(length(dataExplorer$removeData)){
      removeData <- dataExplorer$removeData
      apply(removeData, 1, function(row) {
        targetColumn <- as.character(row["targetColumn"])
        condition <- as.character(row["condition"])
        
        clean_df <<- clean_df %>% 
          filter(!(!!sym(targetColumn) %in% condition))
      })
    }
    
    # Replace any NAs in the dataset with empty string
    clean_df <- clean_df %>%
      mutate(across(where(is.character), ~ifelse(is.na(.), "", .))) 
    
    # read and execute external data processing code that results in explorer_df tibble
    if(length(generalConfig$preprocessing)){
      tryCatch(
        {
          externalCode <- readLines(file.path(customRendererDir, "data-processing", sub("\\.R$", "_compare.R", generalConfig$preprocessing)), warn = FALSE)
          eval(parse(text = externalCode))
        },
        error = function(e) {
          abortSafe(
            sprintf(
              "Problems in data processing. Error message: '%s'. Make sure your scenario data matches your configuration.",
              conditionMessage(e)
            )
          )
        }
      )
    } else {
      explorer_df <- clean_df
    }
    
    if(!identical(colnames(explorer_df), 
                  c("Sector", "Subsector", "Technology", "Enduse", "Unit",
                    "Parameters", "Fuel", "Period", "FuelGroup", 
                    "Technology_Group", scenarioNames))) {
      abortSafe(paste0("wrong column names for tibble explorer_df! Must be c('Sector', 'Subsector', 'Technology', 'Enduse', 'Unit', 'Parameters', 'Fuel', 'Period', 'FuelGroup', 'Technology_Group', '", paste(scenarioNames, collapse = "', '"), "')"))
    }
    
    # Replacing all NaN with 0
    explorer_df[is.na(explorer_df)] <- 0
    
    
    # List generation
    hierarchy_list <- explorer_df %>%
      distinct(Sector, Subsector,Enduse, Technology,Unit,Fuel) %>%
      arrange(across(everything()))
    
    fuel_list <- distinct(hierarchy_list,Fuel) # Fuel list
    sector_list <-distinct(hierarchy_list, Sector) # sector list
    
    # Replace NAs in main dataset with empty string
    explorer_df <- explorer_df %>% 
      mutate(across(where(is.character), ~ifelse(is.na(.), "", .)))
    
    
    # Create 'hierarchy' file. Based on all combinations of dropdowns.
    hierarchy <- explorer_df %>%
      distinct(
        Sector, 
        Subsector, 
        Enduse, 
        Technology, 
        Unit, 
        Parameters
      ) %>%
      union_all(
        distinct(
          .,
          Sector, 
          Enduse, 
          Technology, 
          Unit, 
          Parameters
        ) %>% 
          mutate(
            Subsector = "All Subsectors"
          )
      ) %>% 
      union_all(
        distinct(
          .,
          Sector, 
          Subsector, 
          Technology, 
          Unit, 
          Parameters
        ) %>% 
          mutate(
            Enduse = "All End Use"
          )
      ) %>% 
      union_all(
        distinct(
          .,
          Sector, 
          Subsector, 
          Enduse, 
          Unit, 
          Parameters
        ) %>% 
          mutate(
            Technology = "All Technology"
          )
      ) %>% 
      arrange(across(everything())) 
    
    updateSelectInput(session, "unit", choices = unique(sort(hierarchy$Parameters)))
    
    # data explorer
    output$tabsContent <- renderUI({
      tabs <- lapply(names(dataExplorer$tabNames), function(tabName) {
        
        if(!length(dataExplorer$tabNames[[tabName]]$dataString)) {
          id <- "overview"
        } else {
          id <- tolower(dataExplorer$tabNames[[tabName]]$dataString)
        }
        
        tabPanel(
          if(nchar(dataExplorer$tabNames[[tabName]]$tooltip)) {
            tags$span(tabName,title = dataExplorer$tabNames[[tabName]]$tooltip)
          } else {
            tabName
          },
          value = if(!length(dataExplorer$tabNames[[tabName]]$dataString)) tabName else dataExplorer$tabNames[[tabName]]$dataString, 
          fluidRow(style = "margin-top: 15px",
                   column(12,
                          lapply(scenarioNames, function(scenario) {
                            tags$div(class = "data-explorer",
                                     tags$div(
                                       uiOutput(ns(paste0(id, scenario, "downloadButtons")))
                                     ),
                                     tags$div(id = ns(paste0(id, scenario, "TableWrapper")), class = "dashboard-table-wrapper", style = "display:none;",
                                              tags$h3(class = "custom-table-header", 
                                                      textOutput(ns(paste0(id, scenario, "tableHeader")))),
                                              dataTableOutput(ns(paste0(id, scenario, "Table")))
                                     ),
                                     tags$div(id = ns(paste0(id, scenario, "ChartWrapper")), class = "dashboard-chart-wrapper", 
                                              chartjs::chartjsOutput(ns(paste0(id, scenario, "Chart")), height = "300px")
                                     )
                            )
                          })
                   )
          )
        )
      })
      # create tabsetPanel
      do.call(tabsetPanel, c(tabs, id = session$ns("tabs"), type = "pills"))
    })
    
    filtered_data <- reactive({
      unit_selected <- if (input$unit == "Select Metric") {
        "Emissions"
      } else {
        input$unit
      }
      
      data <- explorer_df
      
      if (input$subsector != "All Subsectors") {
        data <- filter(data, Subsector == input$subsector)
      }
      
      if (input$enduse != "All End Use") {
        data <- filter(data, Enduse == input$enduse)
      }
      
      if (input$tech != "All Technology") {
        data <- filter(data, Technology == input$tech)
      }
      
      if (input$tabs != "All Sectors") {
        data <- filter(data, Sector == input$tabs)
      }
      
      data <- filter(data, Parameters == unit_selected)
      
      return(data)
    })
    
    # table titles
    rv <- reactiveValues(tableHeader="Title")
    idMap <- list()
    
    lapply(names(dataExplorer$tabNames), function(tabName) {
      
      if(!length(dataExplorer$tabNames[[tabName]]$dataString)) {
        id <- "overview"
      } else {
        id <- tolower(dataExplorer$tabNames[[tabName]]$dataString)
      }
      
      idMap[[id]] <<- tabName
      
      observeEvent(input$chart_type, {
        lapply(scenarioNames, function(scenario) {
          if (identical(input$chart_type, "table")) {
            hideEl(session, paste0("#", session$ns(paste0(id, scenario, "ChartWrapper"))))
            showEl(session, paste0("#", session$ns(paste0(id, scenario, "TableWrapper"))))
          } else {
            hideEl(session, paste0("#", session$ns(paste0(id, scenario, "TableWrapper"))))
            showEl(session, paste0("#", session$ns(paste0(id, scenario, "ChartWrapper"))))
          }
        })
      })
      
      lapply(scenarioNames, function(scenario) {
        output[[paste0(id, scenario, "scenarioName")]] <- renderText({
          scenario
        })
        
        output[[paste0(id, scenario, "tableHeader")]] <- renderText({
          title <- rv$tableHeader  # You may need to adjust this based on your actual data
          title
        })
        
        output[[paste0(id, scenario, "downloadButtons")]] <- renderUI({
          
          canvasId <- paste0(id, scenario, "Chart")
          fileName <- idMap[[id]]
          
          tagList(
            tags$h3(class = "scenario-name-inline",
                    textOutput(ns(paste0(id, scenario, "scenarioName")))),
            tags$div(class = "scenario-name-inline inline-download-buttons",
                     tags$a(
                       id = ns(paste0(id, scenario, "downloadCsv")),
                       class = "btn btn-default btn-custom pivot-btn-custom shiny-download-link",
                       href = "",
                       target = "_blank",
                       download = NA,
                       tags$div(
                         tags$i(class = "fa fa-file-csv"),
                         tags$div(
                           class = "miro-pivot-btn-text",
                           lang$renderers$miroPivot$btDownloadCsv
                         )
                       ),
                       title = lang$renderers$miroPivot$btDownloadCsv
                     ),
                     tags$a(
                       id = ns("downloadPng"),
                       class = "btn btn-default bt-export-canvas btn-custom pivot-btn-custom",
                       download = paste0(fileName, "_", scenario, ".png"),
                       href = "#",
                       `data-canvasid` = ns(canvasId),
                       tags$div(
                         tags$i(class = "fa fa-file-image"),
                         tags$div(
                           class = "miro-pivot-btn-text",
                           lang$renderers$miroPivot$btDownloadPng
                         )
                       ),
                       title = lang$renderers$miroPivot$btDownloadPng
                     )
            )
          )
        })
        
        output[[paste0(id, scenario, "downloadCsv")]] <- downloadHandler(
          filename = function() {
            fileName <- idMap[[id]]
            paste0(fileName, "_", scenario, ".csv")
          },
          content = function(file) {
            dataTmp <- get(paste0(id, scenario), envir = currentEnv)
            return(write_csv(dataTmp, file, na = ""))
          }
        )
        
        output[[paste0(id, scenario, "Table")]] <- renderDT({
          
          if (!identical(id, "overview")) {
            plot_data <- filtered_data() %>% 
              filter(Sector == dataExplorer$tabNames[[tabName]]$dataString)
          } else {
            plot_data <- filtered_data()
          }
          
          if (is.null(plot_data) || !nrow(plot_data)) {
            return()
          }
          
          commonColumns <- setdiff(colnames(plot_data), scenarioNames)
          plot_data <- plot_data %>% select(all_of(c(commonColumns,scenario))) %>%
            rename(Value = {{ scenario }})
          
          titleTmp <- paste0(tabName, " ", unique(plot_data$Parameters), " for ", input$subsector, ", ", input$enduse, " and ", input$tech)
          titleTmp <- paste0(toupper(substr(titleTmp, 1, 1)), tolower(substr(titleTmp, 2, nchar(titleTmp))))
          rv$tableHeader <- paste0(titleTmp, " (", unique(plot_data$Unit), ")")
          
          generic_charts(
            data = plot_data,
            group_var = group_by_val(),
            unit = unique(plot_data$Unit),
            plot_title = paste0(tabName, " ", unique(plot_data$Parameters), " for ", input$subsector, ", ", input$enduse, " and ", input$tech),
            input_chart_type = "table",
            id = paste0(id, scenario)
          )
        })
        
        output[[paste0(id, scenario, "Chart")]] <- chartjs::renderChartjs({
          req(input$subsector, group_by_val())
          
          if(!identical(id, "overview")){
            plot_data <- filtered_data() %>% 
              filter(Sector == dataExplorer$tabNames[[tabName]]$dataString)
          } else{
            plot_data <- filtered_data()
          }
          
          commonColumns <- setdiff(colnames(plot_data), scenarioNames)
          plot_data <- plot_data %>% select(all_of(c(commonColumns,scenario))) %>%
            rename(Value = {{ scenario }})
          
          titleTmp <- paste0(tabName, " ",unique(plot_data$Parameters), " for ",input$subsector, ", ", input$enduse," and " ,input$tech)
          titleTmp <- paste0(toupper(substr(titleTmp, 1, 1)), tolower(substr(titleTmp, 2, nchar(titleTmp))))
          rv$tableHeader <- paste0(titleTmp, " (", unique(plot_data$Unit), ")")
          
          generic_charts(
            data = plot_data,
            group_var = group_by_val(),
            unit = unique(plot_data$Unit),
            plot_title = paste0(tabName, " ",unique(plot_data$Parameters), " for ",input$subsector, ", ", input$enduse," and " ,input$tech ),
            input_chart_type = input$chart_type,
            id = paste0(id, scenario)
          )
        })
        
      })
    })
    
    
    # A reactive object based on the hierarchy dataset. 
    # When on the All Sectors tab, it shows all subsectors/data groups.
    # When not on the All Sectors tab it filters to the current tab 
    # (using the value returned by input$tabs)
    filtered_dropdowns <- reactive({
      if(is.null(input$tabs) || input$tabs == "All Sectors"){
        hierarchy
      } else {
        hierarchy %>% filter(stringr::str_detect(Sector, input$tabs))
      }
    })
    
    # The next few functions 'listen' for changes in the dropdowns and update the dropdowns based
    # on what combinations of filters make sense. 
    
    observeEvent(input$tabs, {
      if (is.null(input$tabs) || input$tabs == "All Sectors") {
        df <- filtered_dropdowns()
        updateSelectInput(session, "subsector", label = NULL, choices = c("All Sectors" = "All Subsectors"))
      } else{
        df <- filtered_dropdowns() %>% filter(Sector == input$tabs)
        updateSelectInput(session, "subsector", label = NULL, choices = unique(filtered_dropdowns()$Subsector))
      }
      
      updateSelectInput(session, "enduse", label = NULL, choices = unique(filtered_dropdowns()$Enduse))
      updateSelectInput(session, "tech", label = NULL, choices = unique(filtered_dropdowns()$Technology))
      
      # Ordering the attributes 
      order_Parameters <- c("Select Metric", unique(filtered_dropdowns()$Parameters) %>% sort())
      
      updateSelectInput(session, "unit", choices = order_Parameters)
      
    }, ignoreNULL = TRUE)
    
    observeEvent(input$subsector, {
      
      if (is.null(input$subsector) || input$subsector == "All Subsectors") {
        df <- filtered_dropdowns()
      } else{
        df <- filtered_dropdowns() %>% filter(Subsector == input$subsector)
      }
      
      # Ordering the attributes 
      order_Parameters <- c("Select Metric", unique(df$Parameters) %>% sort())
      
      updateSelectInput(session, "enduse", choices = sort(unique(df$Enduse)))
      updateSelectInput(session, "tech", choices = sort(unique(df$Technology)))
      updateSelectInput(session, "unit", choices = order_Parameters)
      
    }, ignoreNULL = TRUE)
    
    observeEvent(input$enduse, {
      if ((is.null(input$subsector) || is.null(input$enduse)) || (input$subsector == "All Subsectors" & input$enduse == "All End Use")) {
        df <- filtered_dropdowns() #%>% filter(Enduse == input$enduse)
      } else {
        df <- filtered_dropdowns() %>% filter(Subsector == input$subsector, 
                                              Enduse == input$enduse)
      }
      # Ordering the attributes 
      order_Parameters <- c("Select Metric", unique(df$Parameters) %>% sort())
      
      updateSelectInput(session, "tech", choices = sort(unique(df$Technology)))
      updateSelectInput(session, "unit", choices = order_Parameters)
      
    }, ignoreNULL = TRUE)
    
    observeEvent(input$tech, {
      if (is.null(input$subsector) || 
          (input$subsector == "All Subsectors" & 
           input$enduse  == "All End Use" & 
           input$tech    == "All Technology")) {
        
        df <- filtered_dropdowns() #%>% filter(Enduse == input$enduse)
      } else {
        df <- filtered_dropdowns() %>% filter(Subsector  == input$subsector,
                                              Enduse     == input$enduse, 
                                              Technology == input$tech)
      }
      
      # Ordering the attributes 
      order_Parameters <- c("Select Metric", unique(df$Parameters) %>% sort())
      
      updateSelectInput(session, "unit", choices = order_Parameters)
      
    }, ignoreNULL = TRUE)
    
    
    observeEvent(input$Tech_Fuel_Switch, {
      if (identical(input$Tech_Fuel_Switch, "Plot by Technologies")) {
        updateSelectInput(session, "plot_by",
                          choices = c("Technologies Grouped" ,
                                      "Technologies Separated"))
      } else {
        updateSelectInput(session, "plot_by",
                          choices = c("Fuels Grouped", "Fuels Separated"))
      }
    })
    
    # This is used to select the group by values
    group_by_val <- reactive(
      {
        req(input$plot_by)
        if (identical(input$Tech_Fuel_Switch, "Plot by Fuels") & input$plot_by == "Fuels Grouped" ){
          # Selecting Fuel Group
          "FuelGroup"
        } else if( identical(input$Tech_Fuel_Switch, "Plot by Fuels") & input$plot_by == "Fuels Separated" ) {
          # Selecting detailed Fuel
          "Fuel"
        } else if( identical(input$Tech_Fuel_Switch, "Plot by Technologies") & input$plot_by == "Technologies Separated" ) {
          # Selecting detailed technology
          "Technology"
        } else if(identical(input$Tech_Fuel_Switch, "Plot by Technologies") & input$plot_by == "Technologies Grouped") {
          # Selecting grouped technology
          "Technology_Group"
        }
      }
    )
    
    # Data Explorer Charts
    
    # Generic Plotting function
    generic_charts <- function(dataTmp,          # The filtered data 
                               group_var,        # The stacking (fill-by) variable
                               unit,             # Metric selected 
                               plot_title,       # Plot title
                               input_chart_type = "line", # Type of plot
                               id = NULL
    ) {
      if(!nrow(dataTmp)) {
        return()
      }
      # Conditions for percentage plots
      if (input_chart_type == "column_percent") {
        chart_type    <- "column"    # Setting the plot type 
        stacking_type <- "percent"   # Setting the stacking type
        Y_label       <- "Percent"   # Setting the Y-label
      } else {
        chart_type    <- input_chart_type   # Setting the plot type 
        stacking_type <- "normal"           # Setting the stacking type
        Y_label       <-  unit              # Setting the Y-label
      }
      
      
      # Data processing
      dataTmp <- dataTmp %>%                          # Filtered data 
        # !!sym is used to call the group_var as a string
        group_by(!!sym(group_var), Period) %>%  # Group fill-by and period 
        summarise(Value   = sum(Value), 
                  .groups = "drop") %>%         # Sum up period value 
        # This helps to sort chart by value
        arrange(desc(Value)) %>%                # Sorting value 
        mutate(Value = signif(Value,3)) %>%     # Apply 3 significant values
        ungroup() %>%                           # Remove grouping
        
        # Generate pivot table / Summary table 
        pivot_wider(
          names_from = {{group_var}},           
          values_from = Value,                  # The values to use 
          values_fn = sum,                      # Use the sum function 
          values_fill = 0                       # Setting zero if NULL
        ) %>%
        arrange(Period) %>%                     # Arrange the period
        as.data.frame()                         # Convert to data-frame
      
      
      if(identical(chart_type, "table")) {
        tableObj <- DT::datatable(
          dataTmp,
          rownames = FALSE, 
          options = list(paging = TRUE, dom = 't',
                         scrollX = TRUE, 
                         columnDefs = list(list(
                           className = 'dt-left', targets = "_all"
                         )))
        )
        return(tableObj)
      }
      
      # Extracting the grouped by value 
      measure_columns <- names(dataTmp)[-1]
      
      # Extracting the periods
      categories_column <- names(dataTmp)[1]
      
      
      if (identical(stacking_type, "percent")) {
        rowSums <- rowSums(abs(dataTmp[, -1, drop = FALSE]))
        dataTmp[, -1] <- lapply(dataTmp[, -1], function(x) {
          if (length(select_if(subset(dataTmp, select=-Period),is.numeric)) > 1) {
            (abs(x) / rowSums) * 100 * sign(x)
          } else {
            ifelse(x != 0, 100 * sign(x),0)
          }
        })
        dataTmp["total"] <- rowSums
      }
      
      assign(id, dataTmp, envir = currentEnv)
      chart_data <<- dataTmp
      
      if(length(dataExplorer$schemaFiles$colorSchema)){
        color_marker_list <- list(colors = character(0), markers = character(0))
        for (name in names(dataTmp)[-1]) {
          el <- schema_colors %>% filter(Fuel == name)
          color <- el %>% pull(Colors)
          marker <- el %>% pull(Symbol)
          if(identical(marker, "diamond")) {
            marker <- "rectRot"
          } 
          if(identical(marker, "square")) {
            marker <- "rect"
          }
          color_marker_list$colors <- c(color_marker_list$colors, color, colorspace::lighten(color, amount = 0.3))
          color_marker_list$markers <- c(color_marker_list$markers, marker)
        }
      }
      
      chartJsObj <- chartjs::chartjs(
        title = paste0(stringr::str_to_sentence(plot_title), " (", Y_label , ")"),
        customColors = if(length(dataExplorer$schemaFiles$colorSchema)) color_marker_list$colors else NULL
      )
      if (identical(chart_type, "column")){
        chartJsObj <- chartjs::cjsBar(chartJsObj, labels = sort(unique(dataTmp$Period)), stacked = TRUE, yTitle = Y_label)
      } else if (chart_type %in% c("line", "area")){
        chartJsObj <- chartjs::cjsLine(chartJsObj, labels = sort(unique(dataTmp$Period)), yTitle = Y_label)
      }
      chartJsObj <- chartjs::cjsLegend(chartJsObj)
      
      for (name in names(dataTmp)[-1]) {
        chartJsObj <- chartjs::cjsSeries(chartJsObj, dataTmp[[name]], label = name,
                                         fill = chart_type %in% c("area"),
                                         fillOpacity = if (identical(chart_type, "area")) 0.15 else 0.15) 
      }
      
      if (identical(chart_type, "area")) {
        # Stack area charts
        chartJsObj$x$scales$y$stacked <- 'single'
      }
      # show data of all series when hovering 
      chartJsObj$x$options$interaction$mode <- "index"
      chartJsObj$x$options$interaction$axis <- "x"
      
      if (identical(stacking_type, "percent")) {
        chartJsObj$x$data$datasets[length(names(dataTmp)[-1])][[1]]$hidden <- TRUE
        chartJsObj$x$options$plugins$legend$labels$filter <- htmlwidgets::JS("function(item, chart) {return !item.hidden;}")
        chartJsObj$x$options$plugins$tooltip$callbacks$label <- htmlwidgets::JS("function(tooltipItem, chart) {
                                                                 var label = tooltipItem.dataset.label;
                                                                 const rawValues = this.dataPoints.map(point => point.formattedValue);
                                                                 const allValues = rawValues.map(str => parseFloat(str.replace(/,/g, '')));
                                                                 const totals = this.chart._metasets[this.chart._metasets.length - 1].controller._data
                                                                 
                                                                 // let percentage;
                                                                 let absolute;
                                                                 
                                                                 if (allValues.length > 1) {
                                                                   // const rowSums = allValues.reduce((acc, row) => acc + Math.abs(row), 0);
                                                                   // percentage = (Math.abs(tooltipItem.formattedValue) / rowSums) * 100 * Math.sign(tooltipItem.formattedValue);
                                                                   absolute = (tooltipItem.formattedValue / 100) * totals[tooltipItem.dataIndex]
                                                                 } else {
                                                                   // percentage = tooltipItem.formattedValue !== 0 ? 100 * Math.sign(tooltipItem.formattedValue) : 0;
                                                                   absolute = totals[tooltipItem.dataIndex]
                                                                 }  
                                                                 
                                                                 // return label + ': ' + tooltipItem.formattedValue + ' (' + percentage.toFixed(2) + '%)';
                                                                 return label + ': ' + parseFloat(absolute).toFixed(2) + ' (' + parseFloat(tooltipItem.formattedValue).toFixed(2) + '%)';
                                                                 }")
      }
      
      if (input_chart_type %in% c("column", "area")) {
        chartJsObj$x$options$plugins$tooltip$callbacks$afterBody <- htmlwidgets::JS("function(tooltipItem, chart) {
                                                                 const rawValues = this.dataPoints.map(point => point.formattedValue);
                                                                 const allValues = rawValues.map(str => parseFloat(str.replace(/,/g, '')));
                                                                 let rowSums = allValues.reduce((acc, row) => acc + parseFloat(row), 0);
                                                                 return 'Total: ' + parseFloat(rowSums).toFixed(2);
                                                                 }")
      }
      
      
      # specify series markers
      if (length(dataExplorer$schemaFiles$colorSchema) && chart_type %in% c("line", "area")){
        for (i in 1:length(names(dataTmp)[-1])) { 
          chartJsObj$x$data$datasets[[i]]$pointStyle <- color_marker_list$markers[i]
          if(!identical(color_marker_list$markers[i], "circle")){
            chartJsObj$x$data$datasets[[i]]$radius <- 4
          }
        }
      }
      
      # Fit chart to screen
      chartJsObj$x$options$maintainAspectRatio = FALSE
      
      # set locale for '.' as decimal sign
      chartJsObj$x$options$locale = "en-US"
      
      # enable zoom
      chartJsObj$x$options$plugins$zoom = list(
        zoom = list(
          wheel = list(
            enabled = TRUE
          ),
          pinch = list(
            enabled = TRUE
          ),
          mode = "xy",
          overScaleMode = "y"
        ),
        pan = list(
          enabled = TRUE,
          mode = "xy"
        )
      )
      return(chartJsObj)
    }
  }
  
  ########################################
  ############### Dashboard ##############
  ########################################
  
  dashboard <- config$scenCompareDashboard
  
  if(length(dashboard) && length(generalConfig$tabNames[["dashboard"]])){
    dataViewsConfig <- dashboard$dataViewsConfig
    
    prepareData <- function(config, viewData) {
      
      dataTmp <- viewData
      
      filterIndexList <- names(config$filter)
      aggFilterIndexList <- names(config$aggregations)
      colFilterIndexList <- names(config$cols)
      filterIndexList <- c(filterIndexList, aggFilterIndexList, colFilterIndexList)
      
      filterElements <- vector("list", length(filterIndexList))
      names(filterElements) <- filterIndexList
      multiFilterIndices <- c()
      
      for (filterIndex in filterIndexList) {
        filterElements[[filterIndex]] <- sort(unique(dataTmp[[filterIndex]]))
        optionId <- "filter"
        if (filterIndex %in% aggFilterIndexList) {
          optionId <- "aggregations"
        } else if (filterIndex %in% colFilterIndexList) {
          optionId <- "cols"
        }
        filterVal <- config[[optionId]][[filterIndex]]
        
        if (!any(filterVal %in% filterElements[[filterIndex]])) {
          if (filterIndex %in% c(aggFilterIndexList, colFilterIndexList)) {
            # nothing selected = no filter for aggregations/cols
            next
          }
          filterVal <- filterElements[[filterIndex]][1]
        }
        if (any(is.na(match(filterIndex, names(dataTmp))))) {
          flog.warn(
            "Attempt to tamper with the app detected! User entered: '%s' as filter index",
            filterIndex
          )
          stop("Attempt to tamper with the app detected!", call. = FALSE)
        }
        if (length(filterVal) > 1L) {
          multiFilterIndices <- c(multiFilterIndices, filterIndex)
          filterExpression <- paste0(
            ".[[\"", filterIndex, "\"]]%in%c('",
            paste(gsub("'", "\\'", filterVal, fixed = TRUE), collapse = "','"),
            "')"
          )
        } else {
          filterExpression <- paste0(
            ".[[\"", filterIndex, "\"]]=='",
            gsub("'", "\\'", filterVal, fixed = TRUE),
            "'"
          )
        }
        dataTmp <- dataTmp %>% filter(
          !!rlang::parse_expr(filterExpression)
        )
      }
      
      
      rowIndexList <- config$rows
      aggregationFunction <- config$aggregationFunction
      setIndices <- names(dataTmp)[-length(dataTmp)]
      if (is.null(rowIndexList)) {
        rowIndexList <- setIndices
      }
      rowIndexList <- c(
        rowIndexList,
        multiFilterIndices[!multiFilterIndices %in% c(aggFilterIndexList, colFilterIndexList)]
      )
      valueColName <- names(dataTmp)[length(dataTmp)]
      if (length(aggFilterIndexList)) {
        if (identical(aggregationFunction, "")) {
          aggregationFunction <- "count"
        } else if (length(aggregationFunction) != 1L ||
                   !aggregationFunction %in% c("sum", "count", "min", "max", "mean", "median", "sd")) {
          flog.warn(
            "Attempt to tamper with the app detected! User entered: '%s' as aggregation function.",
            aggregationFunction
          )
          stop("Attempt to tamper with the app detected!", call. = FALSE)
        }
        valueColName <- names(dataTmp)[length(dataTmp)]
        if (!identical(valueColName, "value")) {
          names(dataTmp)[length(dataTmp)] <- "value"
        }
        dataTmp <- dataTmp %>%
          group_by(!!!rlang::syms(c(rowIndexList, colFilterIndexList))) %>%
          summarise(value = !!rlang::parse_expr(
            if (identical(aggregationFunction, "count")) {
              "sum(!is.na(value))"
            } else {
              paste0(aggregationFunction, "(value, na.rm = TRUE)")
            }
          ), .groups = "drop_last")
        if (!identical(valueColName, "value")) {
          names(dataTmp)[length(dataTmp)] <- valueColName
        }
      }
      
      if (length(rowIndexList)) {
        dataTmp <- dataTmp %>%
          select(!!!c(rowIndexList, colFilterIndexList, valueColName)) %>%
          arrange(!!!rlang::syms(rowIndexList))
      } else {
        dataTmp <- dataTmp %>% select(!!!c(colFilterIndexList, valueColName))
      }
      
      # apply custom labels
      if (length(config$chartOptions$customLabels)) {
        labelCols <- dataTmp[, sapply(dataTmp, class) == 'character']
        for (i in seq_len(nrow(dataTmp))) {
          for (j in seq_len(length(labelCols))) {
            if (is.na(dataTmp[[i, j]])) {
              next
            }
            for (key in names(config$chartOptions$customLabels)) {
              if (dataTmp[[i, j]] == key) {
                dataTmp[[i, j]] <- config$chartOptions$customLabels[[key]]
                break
              }
            }
          }
        }
      }
      
      userFilterData <- list()
      
      if (length(config$userFilter)) {
        for (filter in config$userFilter) {
          userFilterData[[filter]] <- unique(dataTmp[[filter]])
        }
      }
      
      if (length(colFilterIndexList)) {
        # note that names_sep is not an ASCII full stop, but UNICODE U+2024
        tryCatch(
          {
            dataTmp <- dataTmp %>%
              pivot_wider(
                names_from = !!colFilterIndexList, values_from = !!valueColName,
                names_sep = "\U2024",
                names_sort = TRUE, names_repair = "unique"
              )
          },
          warning = function(w) {
            if (grepl("list-cols", conditionMessage(w), fixed = TRUE)) {
              flog.trace("Dashboard configuration: Data contains duplicated keys and can therefore not be pivoted.")
              showErrorMsg(
                lang$renderers$miroPivot$errorTitle,
                lang$renderers$miroPivot$errPivotDuplicate
              )
            } else {
              flog.info(
                "Dashboard configuration: Unexpected warning while pivoting data. Error message: %s",
                conditionMessage(e)
              )
              showErrorMsg(
                lang$renderers$miroPivot$errorTitle,
                lang$renderers$miroPivot$errPivot
              )
            }
          },
          error = function(e) {
            flog.info(
              "Dashboard configuration: Unexpected error while pivoting data. Error message: %s",
              conditionMessage(e)
            )
            showErrorMsg(
              lang$renderers$miroPivot$errorTitle,
              lang$renderers$miroPivot$errPivot
            )
          }
        )
      }
      attr(dataTmp, "noRowHeaders") <- length(rowIndexList)
      for (filterName in names(userFilterData)) {
        attr(dataTmp, paste0("userFilterData_", filterName)) <- userFilterData[[filterName]]
      }
      return(dataTmp)
    }
    
    hasMultipleNumeric <- function(df) {
      numericCols <- sapply(df, is.numeric)
      sum(numericCols) > 1
    }
    
    dashboardChartData <- list()
    
    for (view in names(dataViewsConfig)) {
      config <- dataViewsConfig[[view]]
      
      if (!is.null(config$data)) {
        viewData <- combineData(data$get(config$data), scenarioNames)
      } else {
        viewData <- cubeoutputData
      }
      
      # Scenario columns need to be lengthened to only have one value column
      viewData <- viewData %>%
        pivot_longer(cols = scenarioNames,
                     names_to = "_scenName",
                     values_to = "value")
      
      preparedData <- prepareData(config, viewData)
      dashboardChartData[[view]] <- preparedData
    }
    
    
    # Boxes for  KPIs (custom infobox)
    infoBoxCustom <-
      function(value = NULL,
               prefix = "+",
               postfix = "%",
               noColor = FALSE,
               invert = FALSE,
               title,
               subtitle = NULL,
               icon = shiny::icon("bar-chart"),
               color = "aqua",
               width = 4,
               href = NULL,
               fill = FALSE,
               customColor = NULL,
               noView = FALSE) {
        shinydashboard:::validateColor(color)
        shinydashboard:::tagAssert(icon, type = "i")
        
        colorClass <- paste0("bg-", color)
        boxContent <- div(
          class = "info-box custom-info-box",
          class = if (fill)
            colorClass,
          class = if (noView)
            "no-view",
          span(
            class = "info-box-icon",
            class = if (!fill)
              colorClass,
            style = if (!is.null(customColor))
              paste0("background-color:", customColor, "!important;")
            else
              "",
            icon
          ),
          div(
            class = "info-box-content",
            span(class = "info-box-text",
                 title),
            if (!is.null(value))
              span(
                class = "info-box-number",
                style = if (is.na(suppressWarnings(as.numeric(value))) || noColor) {
                  "color:''"
                } else if (!is.na(suppressWarnings(as.numeric(value))) && 
                           as.numeric(value) == 0) {
                  "color:''"
                } else if (!is.na(suppressWarnings(as.numeric(value))) && 
                           as.numeric(value) > 0) {
                  if (invert) {
                    "color:#dd4b39!important"
                  } else{
                    "color:#3d9970!important"
                  }
                } else if (invert) {
                  "color:#3d9970!important"
                } else{
                  "color:#dd4b39!important"
                },
                if (!is.na(suppressWarnings(as.numeric(value))) && 
                    as.numeric(value) > 0) {
                  paste0(prefix, value, postfix)
                } else if (!is.na(suppressWarnings(as.numeric(value))) && 
                           as.numeric(value) == 0) {
                  paste0("0", postfix)
                } else if (!is.na(suppressWarnings(as.numeric(value)))) {
                  paste0(value, postfix)
                } else {
                  value
                }
              ),
            if (!is.null(subtitle))
              p(subtitle)
          )
        )
        
        if (!is.null(href))
          boxContent <- a(href = href, boxContent)
        
        div(class = if (!is.null(width))
          paste0("col-sm-", width),
          boxContent)
      }
    
    currentEnv <- environment()
    chartChoices <- c("Line" = "line", "Scatter" = "scatter", "Area" = "area", 
                      "Stackedarea" = "stackedarea", "Bar" = "bar", 
                      "Stackedbar" = "stackedbar", "Radar" = "radar", 
                      "Timeseries" = "timeseries", "Table" = "table")
    
    # Get scalar output data in case valueboxes should show a value
    if (length(dashboard$valueBoxes$ValueScalar) && any(!is.na(dashboard$valueBoxes$ValueScalar))) {
      if (!"_scalars_out" %in% data$getAllSymbols()) {
        abortSafe("No scalar output symbols found for valueBoxes")
      } 
      scalarData <- combineData(data$get("_scalars_out"), scenarioNames)
    }
    
    # Valueboxes output
    output$valueboxes <- renderUI({
      
      box_columns <- lapply(dashboard$valueBoxes$Id, function(box_name) {
        column(12, class = "box-styles col-xs-6 col-sm-6", shinydashboard::valueBoxOutput(ns(box_name), width = 12))
      })
      tagList(column(12, class = "col-xs-12 col-sm-12 custom-highlight-block custom-padding",
                     tags$h4(dashboard$valueBoxesTitle[[1]], class = "highlight-block")), 
              if(any(!is.na(dashboard$valueBoxes$ValueScalar))){
                column(12, class = "col-xs-12 col-sm-12 custom-highlight-block custom-padding",
                       tags$div(
                         tags$div(class = "scenario-dropdown", style = "height: 30px;",
                                  selectizeInput(ns("scenarioSelect"), label = NULL, 
                                                 choices = scenarioNames,
                                                 options = list(onInitialize = I(paste0("function(value) {
  document.querySelector('.selectize-input input[id^=\"", ns("scenarioSelect"), "\"]').setAttribute('readonly', 'readonly');
}")))),
                         )
                       ))
              },
              do.call(tagList, box_columns))
    })
    
    lapply(1:length(dashboard$valueBoxes$Id), function(i) {
      
      valBoxName <- dashboard$valueBoxes$Id[i]
      
      if (is.na(dashboard$valueBoxes$ValueScalar[i])) {
        valueTmp <- NULL
      } else {
        valueTmp <- scalarData %>% 
          filter(scalar == tolower(dashboard$valueBoxes$ValueScalar[i]))
        if(!nrow(valueTmp)) {
          abortSafe(sprintf("No scalar symbol '%s' found for valueBox '%s'"), dashboard$valueBoxes$ValueScalar[i], dashboard$valueBoxes$Id[i])
        }
      }
      
      output[[valBoxName]] <- renderValueBox({
        
        #Note: Modify in case (optional) valueBox values should be calculated differently
        value <- NULL
        if(!is.null(valueTmp)) {
          value <- valueTmp %>% 
            pull(input$scenarioSelect) %>% as.numeric()
          if(!is.na(dashboard$valueBoxes$Decimals[i])) {
            value <- value %>% round(as.numeric(dashboard$valueBoxes$Decimals[i]))
          }
        }
        
        infoBoxCustom(
          value = value,
          prefix = dashboard$valueBoxes$Prefix[i],
          postfix = dashboard$valueBoxes$Postfix[i],
          noColor = dashboard$valueBoxes$NoColor[i],
          invert = dashboard$valueBoxes$redPositive[i],
          title = dashboard$valueBoxes$Title[i],
          color = if (startsWith(dashboard$valueBoxes$Color[i], "#")) "aqua" else dashboard$valueBoxes$Color[i],
          icon = icon(dashboard$valueBoxes$Icon[i]),
          customColor = if (startsWith(dashboard$valueBoxes$Color[i], "#")) dashboard$valueBoxes$Color[i] else NULL,
          noView = if (!valBoxName %in% names(dashboard$dataViews)) TRUE else FALSE
        )
      })
    })
    
    # Data View switch
    observeEvent(input$showChart, {
      views <- names(dashboard$dataViews)
      boxWithoutView <- dashboard$valueBoxes$Id[!dashboard$valueBoxes$Id %in% views]
      
      reportToRender <- substr(input$showChart, nchar(session$ns("")) + 1L, nchar(input$showChart))
      if (reportToRender %in% boxWithoutView) {
        return()
      }
      reportToRender <- if (reportToRender %in% views) reportToRender else dashboard$valueBoxes$Id[[1]]
      
      for (view in views) {
        if (identical(reportToRender, view)) {
          showEl(session, paste0("#", session$ns(paste0(view, "View"))))
        } else {
          hideEl(session, paste0("#", session$ns(paste0(view, "View"))))
        }
      }
    })
    
    # Data views
    # Distinguishes between dataViews objects with one and multiple elements 
    # names(dataViews) must match valueBoxes$Id entries
    output$dataViews <- renderUI({
      sections <- lapply(names(dashboard$dataViews), function(viewList) {
        
        view <- dashboard$dataViews[[viewList]]
        
        id <- names(view)[1]
        title <- view[[1]]
        
        if(length(view) > 1) {
          idList <- list()
          titleList <- list()
          
          for(i in seq_along(view)) {
            idList[[i]] <- names(view)[i]
            titleList[[i]] <- view[[i]]
          }
          
          tags$div(
            id = ns(paste0(viewList, "View")),
            style = ifelse(viewList == dashboard$valueBoxes$Id[[1]], "", "display:none;"),
            
            lapply(seq_along(idList), function(i) {
              id <- idList[[i]]
              title <- titleList[[i]]
              
              column(12, class = "add-margin",
                     tags$h4(title, class = "highlight-block"),
                     tags$div(style = "overflow:auto;",
                              tags$div(class = "row table-chart-wide-widgets",
                                       tags$div(class = "charttype-and-btn-wrapper",
                                                class = if (length(dataViewsConfig[[id]]$userFilter) %% 2 == 0) "even-inline" else if (length(dataViewsConfig[[id]]$userFilter) == 1) "one-inline" else "odd-inline",
                                                tags$div(class = "custom-dropdown",
                                                         selectizeInput(ns(paste0(id, "ChartType")), label = NULL,
                                                                        choices = chartChoices,
                                                                        selected = dataViewsConfig[[id]]$pivotRenderer,
                                                                        options = list(onInitialize = I(paste0("function(value) {
                  document.querySelector('.selectize-input input[id^=\"", ns(paste0(id, "ChartType")), "\"]').setAttribute('readonly', 'readonly');
                }")))
                                                         )
                                                ),
                                                uiOutput(ns(paste0(id, "DownloadButtons")))),
                                       if(length(dataViewsConfig[[id]]$userFilter)){
                                         filterInputs <- lapply(dataViewsConfig[[id]]$userFilter, function(filterName) {
                                           tags$div(class = "custom-dropdown-wide user-filter",
                                                    class = if (length(dataViewsConfig[[id]]$userFilter) %% 2 == 0) "even-inline" else if (length(dataViewsConfig[[id]]$userFilter) == 1) "one-inline" else "odd-inline",
                                                    selectizeInput(ns(paste0(id, "userFilter_", filterName)), label = NULL,
                                                                   choices = c("All" = '', attr(dashboardChartData[[id]], paste0("userFilterData_", filterName))), 
                                                                   multiple = TRUE, width = "100%",
                                                                   options = list(onInitialize = I(paste0("function(value) {
                                         document.querySelector('.selectize-input input[id^=\"", ns(paste0(id, "userFilter_", filterName)), "\"]').setAttribute('readonly', 'readonly');
                                       }")))
                                                    )
                                           )
                                         })
                                         
                                         do.call(tagList, filterInputs)
                                       }
                              ),
                              
                              tags$div(class = "table-chart-wide-wrapper",
                                       dataTableOutput(ns(paste0(id, "Table"))),
                                       tags$div(id = ns(paste0(id, "ChartWrapper")), class = "dashboard-chart-wrapper",
                                                chartjs::chartjsOutput(ns(paste0(id, "Chart")), height="300px")
                                       )
                              )
                     )
              )
            })
          )
        } else {
          tags$div(
            id = ns(paste0(viewList, "View")),
            style = ifelse(viewList == dashboard$valueBoxes$Id[[1]], "", "display:none;"),
            column(12, class = "add-margin",
                   tags$h4(title, class = "highlight-block"),
                   tags$div(style = "overflow:auto;",
                            tags$div(class = "row table-chart-wide-widgets",
                                     tags$div(class = "charttype-and-btn-wrapper",
                                              class = if (length(dataViewsConfig[[id]]$userFilter) %% 2 == 0) "even-inline" else if (length(dataViewsConfig[[id]]$userFilter) == 1) "one-inline" else "odd-inline",
                                              tags$div(class = "custom-dropdown",
                                                       selectizeInput(ns(paste0(id, "ChartType")), label = NULL,
                                                                      choices = chartChoices[chartChoices != "table"],
                                                                      selected = if(dataViewsConfig[[id]]$pivotRenderer %in%
                                                                                    tolower(names(chartChoices[chartChoices != "table"]))) dataViewsConfig[[id]]$pivotRenderer
                                                                      else "Line",
                                                                      options = list(onInitialize = I(paste0("function(value) {
                  document.querySelector('.selectize-input input[id^=\"", ns(paste0(id, "ChartType")), "\"]').setAttribute('readonly', 'readonly');
                }")))
                                                       )
                                              ),
                                              uiOutput(ns(paste0(id, "DownloadButtons")))
                                     ),
                                     if(length(dataViewsConfig[[id]]$userFilter)){
                                       filterInputs <- lapply(dataViewsConfig[[id]]$userFilter, function(filterName) {
                                         tags$div(class = "custom-dropdown-wide user-filter",
                                                  class = if (length(dataViewsConfig[[id]]$userFilter) %% 2 == 0) "even-inline" else if (length(dataViewsConfig[[id]]$userFilter) == 1) "one-inline" else "odd-inline",
                                                  selectizeInput(ns(paste0(id, "userFilter_", filterName)), label = NULL,
                                                                 choices = c("All" = '', attr(dashboardChartData[[id]], paste0("userFilterData_", filterName))), 
                                                                 multiple = TRUE, width = "100%",
                                                                 options = list(onInitialize = I(paste0("function(value) {
                                         document.querySelector('.selectize-input input[id^=\"", ns(paste0(id, "userFilter_", filterName)), "\"]').setAttribute('readonly', 'readonly');
                                       }")))
                                                  )
                                         )
                                       })
                                       
                                       do.call(tagList, filterInputs)
                                     }
                            ),
                            tags$div(id = ns(paste0(id, "ChartWrapper")), class = "dashboard-chart-wrapper",
                                     chartjs::chartjsOutput(ns(paste0(id, "Chart")), height="300px")
                            )
                   )
            ),
            column(12,
                   tags$div(class = "no-header",
                            dataTableOutput(ns(paste0(id, "Table"))))
            )
          )
        }
        
      })
      
      do.call(tagList, sections)
    })
    
    # show/hide Chart for view with multi-chart layout. Show/hide table is done in renderDT() directly
    toggleChartType <- function(indicator) {
      if (identical(input[[paste0(indicator, "ChartType")]], "table")) {
        hideEl(session, paste0("#", session$ns(paste0(indicator, "ChartWrapper"))))
      } else {
        showEl(session, paste0("#", session$ns(paste0(indicator, "ChartWrapper"))))
      }
    }
    
    # identify views with two-chart layout
    multiChartsViews <- unlist(lapply(names(dashboard$dataViews), function(view) {
      if (length(dashboard$dataViews[[view]]) > 1) {
        names(dashboard$dataViews[[view]])
      } else {
        character(0)
      }
    }))
    
    lapply(names(dashboardChartData), function(indicator) {
      
      # observer for views where user can switch between table/chart  (two-chart layout)
      if(indicator %in% multiChartsViews) {
        observeEvent(input[[paste0(indicator, "ChartType")]], {
          toggleChartType(indicator)
        })
      }
      
      # table for each view
      output[[paste0(indicator, "Table")]] <- renderDT({
        if (!nrow(dashboardChartData[[indicator]]) || 
            (indicator %in% multiChartsViews && !identical(input[[paste0(indicator, "ChartType")]], "table"))) {
          return()
        }
        
        dataTmp <- dashboardChartData[[indicator]]
        if(length(dataViewsConfig[[indicator]]$decimals)){
          dataTmp <- dataTmp %>%
            mutate(across(where(is.numeric), ~ round(., as.numeric(dataViewsConfig[[indicator]]$decimals))))
        }
        
        #filter user selection
        if (length(dataViewsConfig[[indicator]]$userFilter)) {
          for (filterName in dataViewsConfig[[indicator]]$userFilter) {
            if(length(input[[paste0(indicator, "userFilter_", filterName)]])) {
              filterEl <- input[[paste0(indicator, "userFilter_", filterName)]]
              if(filterName %in% names(dataViewsConfig[[indicator]]$cols)) {
                dataTmp <- dataTmp %>%
                  select(1:as.numeric(attr(dashboardChartData[[indicator]], "noRowHeaders")), 
                         (matches(paste0("^", filterEl, "$")) | 
                            contains(paste0(filterEl, "\U2024")) | 
                            contains(paste0("\U2024", filterEl)))
                  )
              } else {
                dataTmp <- dataTmp %>% 
                  filter(!!rlang::sym(filterName) %in% filterEl)
              } 
            }
          }
        }
        
        # Table Summary
        colSummarySettings <- NULL
        
        nonNumericCols <- dataTmp %>%
          select(where(~ !is.numeric(.))) %>%
          names()
        
        if (dataViewsConfig[[indicator]]$tableSummarySettings$enabled) {
          tablesummarySettings <- dataViewsConfig[[indicator]]$tableSummarySettings
          if (identical(tablesummarySettings$rowSummaryFunction, "sum")) {
            dataTmp <- mutate(
              ungroup(dataTmp),
              !!paste0(
                lang$renderers$miroPivot$aggregationFunctions$sum,
                "\U2003\U2003"
              ) := rowSums(dataTmp[vapply(dataTmp, is.numeric,
                                          logical(1L),
                                          USE.NAMES = FALSE
              )], na.rm = TRUE)
            )
          } else if (identical(tablesummarySettings$rowSummaryFunction, "mean")) {
            dataTmp <- mutate(
              ungroup(dataTmp),
              !!paste0(
                lang$renderers$miroPivot$aggregationFunctions$mean,
                "\U2003\U2003"
              ) := rowMeans(dataTmp[vapply(dataTmp, is.numeric,
                                           logical(1L),
                                           USE.NAMES = FALSE
              )], na.rm = TRUE)
            )
          } else {
            # count
            dataTmp <- mutate(
              ungroup(dataTmp),
              !!paste0(
                lang$renderers$miroPivot$aggregationFunctions$count,
                "\U2003\U2003"
              ) := rowSums(!is.na(dataTmp[vapply(dataTmp, is.numeric,
                                                 logical(1L),
                                                 USE.NAMES = FALSE
              )]))
            )
          }
          
          colSummarySettings <- list(caption = lang$renderers$miroPivot$aggregationFunctions[[tablesummarySettings$colSummaryFunction]])
          roundPrecision <- if (length(dataViewsConfig[[indicator]]$decimals)) as.numeric(dataViewsConfig[[indicator]]$decimals) else 2L
          if (identical(tablesummarySettings$colSummaryFunction, "count")) {
            colSummarySettings$data <- round(colSums(!is.na(dataTmp[vapply(dataTmp, is.numeric,
                                                                           logical(1L),
                                                                           USE.NAMES = FALSE
            )])), digits = roundPrecision)
          } else {
            colSummarySettings$data <- round(as.numeric(slice(summarise(dataTmp, across(
              where(is.numeric),
              \(x) match.fun(tablesummarySettings$colSummaryFunction)(x, na.rm = TRUE)
            )), 1L)), digits = roundPrecision)
          }
        }
        
        tableObj <- DT::datatable(
          dataTmp,
          rownames = FALSE,
          container = DTbuildColHeaderContainer(
            names(dataTmp),
            attr(dashboardChartData[[indicator]], "noRowHeaders"),
            unlist(nonNumericCols[names(dataTmp)[seq_len(attr(dashboardChartData[[indicator]], "noRowHeaders"))]],
                   use.names = FALSE
            ),
            colSummary = colSummarySettings
          ),
          options = list(paging = FALSE, dom = 't',
                         scrollX = TRUE,
                         scrollY = "35vh",
                         columnDefs = list(list(
                           className = 'dt-left', targets = "_all"
                         )))
        )
      })
      
      customColors <- c(
        "#a6cee3", "#1f78b4", "#b2df8a", "#33a02c",
        "#fb9a99", "#e31a1c", "#fdbf6f", "#ff7f00",
        "#cab2d6", "#6a3d9a", "#ffff99", "#b15928",
        "#FCDCDB", "#f9b9b7", "#D5D3DA", "#ada9b7",
        "#e2546b", "#66101F", "#E0ABD7", "#c45ab3",
        "#8bf2fe", "#1BE7FF", "#a1d1b6", "#4C9F70",
        "#F6FAA9", "#f0f757", "#d3b499", "#9E6D42",
        "#50caf3", "#086788", "#eee49d", "#E0CA3C",
        "#dbcac7", "#BA9790", "#f69e84", "#EB4511",
        "#ccadf1", "#9B5DE5", "#A1FB8B", "#47fa1a",
        "#8dadd0", "#38618c", "#fcebea", "#fad8d6",
        "#a6b474", "#373d20", "#a248ce", "#210b2c",
        "#f37ea9", "#d81159", "#68f7f7", "#08bdbd",
        "#98feb1", "#35ff69", "#d27193", "#6d213c",
        "#edfab1", "#dcf763", "#feb46f", "#e06c00",
        "#f3ebaa", "#e9d758", "#c0c7c7", "#829191",
        "#f3cac5", "#E8998D", "#c7dac9", "#91b696",
        "#BE99A4", "#714955", "#7c7ccf", "#2a2a72",
        "#7efee0", "#00ffc5", "#c28eb1", "#6c3a5c",
        "#df7192", "#8b1e3f", "#95D86B", "#3E721D"
      )
      
      # charts output
      output[[paste0(indicator, "Chart")]] <- chartjs::renderChartjs({
        
        dataTmp <- dashboardChartData[[indicator]]
        if(length(dataViewsConfig[[indicator]]$decimals)){
          dataTmp <- dataTmp %>%
            mutate(across(where(is.numeric), ~ round(., as.numeric(dataViewsConfig[[indicator]]$decimals))))
        }
        
        #filter user selection
        if (length(dataViewsConfig[[indicator]]$userFilter)) {
          for (filterName in dataViewsConfig[[indicator]]$userFilter) {
            if(length(input[[paste0(indicator, "userFilter_", filterName)]])) {
              filterEl <- input[[paste0(indicator, "userFilter_", filterName)]]
              if(filterName %in% names(dataViewsConfig[[indicator]]$cols)) {
                dataTmp <- dataTmp %>%
                  select(1:as.numeric(attr(dashboardChartData[[indicator]], "noRowHeaders")), 
                         (matches(paste0("^", filterEl, "$")) | 
                            contains(paste0(filterEl, "\U2024")) | 
                            contains(paste0("\U2024", filterEl)))
                  )
              } else {
                dataTmp <- dataTmp %>% 
                  filter(!!rlang::sym(filterName) %in% filterEl)
              } 
            }
          }
        }
        
        chartType <- tolower(input[[paste0(indicator, "ChartType")]])
        currentView <- dataViewsConfig[[indicator]]
        
        if (!nrow(dataTmp) ||
            !chartType %in%
            c("line", "scatter", "area", "stackedarea", "bar",
              "stackedbar", "radar", "timeseries")) {
          return()
        }
        
        rowHeaderLen <- attr(dashboardChartData[[indicator]], "noRowHeaders")
        noSeries <- length(dataTmp) - rowHeaderLen
        labels <- do.call(paste, c(dataTmp[seq_len(rowHeaderLen)], list(sep = ".")))
        if (!length(labels)) {
          labels <- "value"
        }
        
        currentSeriesLabels <- names(dataTmp)[seq(rowHeaderLen + 1L, noSeries + rowHeaderLen)]
        
        if (length(currentView$chartOptions$customChartColors) &&
            length(names(currentView$chartOptions$customChartColors))) {
          # custom chart colors specified
          colorLabels <- names(currentView$chartOptions$customChartColors)
          colorLabelsNew <- colorLabels
          if (length(currentView$chartOptions$customLabels)) {
            colorLabelsNew <- c()
            for (colorLabel in colorLabels) {
              label <- colorLabel
              if (colorLabel %in% names(currentView$chartOptions$customLabels)) {
                label <- currentView$chartOptions$customLabels[[colorLabel]]
              } else {
                labelsTmp <- strsplit(colorLabel, "\U2024")[[1]]
                labelMatch <- which(labelsTmp %in% names(currentView$chartOptions$customLabels))
                labelsTmp[labelMatch] <- unlist(currentView$chartOptions$customLabels[labelsTmp[labelMatch]])
                label <- paste(labelsTmp, collapse = "\U2024")
              }
              colorLabelsNew <- c(colorLabelsNew, label)
            }
          }
          
          chartColorIdx <- match(
            currentSeriesLabels,
            colorLabelsNew
          )
          chartColorsToUse <- currentView$chartOptions$customChartColors[chartColorIdx]
          chartColorsToUse[is.na(chartColorIdx)] <- list(c("#666", "#666"))
          chartColorsToUse <- unlist(chartColorsToUse, use.names = FALSE)
        } else {
          chartColorsToUse <- customColors
        }
        
        if (chartType %in% c(
          "line", "scatter", "area", "stackedarea",
          "timeseries"
        )) {
          chartJsObj <- chartjs(
            customColors = chartColorsToUse
          ) %>%
            cjsLine(
              labels = labels,
              xTitle = currentView$chartOptions$xTitle,
              yTitle = currentView$chartOptions$yTitle
            )
          if (identical(chartType, "scatter")) {
            chartJsObj$x$options$showLine <- FALSE
          } else if (identical(chartType, "stackedarea")) {
            chartJsObj$x$scales$y$stacked <- TRUE
            chartJsObj$x$options$plugins$tooltip <- list(
              mode = "index",
              position = "nearest"
            )
          } else if (identical(chartType, "timeseries")) {
            chartJsObj$x$options$normalized <- TRUE
            chartJsObj$x$options$animation <- FALSE
            chartJsObj$x$options$elements <- list(
              point = list(
                radius = 0L,
                hitRadius = 4L
              )
            )
            chartJsObj$x$options$plugins$tooltip <- list(
              mode = "index",
              position = "nearest"
            )
          }
        } else if (identical(chartType, "stackedbar")) {
          chartJsObj <- chartjs(
            customColors = chartColorsToUse
          ) %>%
            cjsBar(
              labels = labels, stacked = TRUE,
              xTitle = currentView$chartOptions$xTitle,
              yTitle = currentView$chartOptions$yTitle
            )
          chartJsObj$x$options$plugins$tooltip <- list(
            mode = "index",
            position = "nearest"
          )
        } else if (identical(chartType, "radar")) {
          chartJsObj <- chartjs(
            customColors = chartColorsToUse
          ) %>%
            cjsRadar(labels = labels)
        } else {
          chartJsObj <- chartjs(
            customColors = chartColorsToUse
          ) %>%
            cjsBar(
              labels = labels,
              xTitle = currentView$chartOptions$xTitle,
              yTitle = currentView$chartOptions$yTitle
            )
        }
        if (identical(currentView$chartOptions$yLogScale, TRUE) &&
            identical(chartJsObj$x$scales$y$type, "linear")) {
          chartJsObj$x$scales$y$type <- "logarithmic"
        }
        
        for (i in seq_len(noSeries)) {
          chartJsObj <- cjsSeries(chartJsObj, dataTmp[[rowHeaderLen + i]],
                                  label = names(dataTmp)[rowHeaderLen + i],
                                  fill = chartType %in% c("area", "stackedarea"),
                                  fillOpacity = if (identical(chartType, "stackedarea")) 1 else 0.15
          )
        }
        
        if (chartType %in% c("stackedbar", "stackedarea")) {
          chartJsObj$x$options$plugins$tooltip$callbacks$afterBody <- htmlwidgets::JS("function(tooltipItem, chart) {
                                                                   const rawValues = this.dataPoints.map(point => point.formattedValue);
                                                                   const allValues = rawValues.map(str => parseFloat(str.replace(/,/g, '')));
                                                                   let rowSums = allValues.reduce((acc, row) => acc + parseFloat(row), 0);
                                                                   return 'Total: ' + parseFloat(rowSums).toFixed(2);
                                                                   }")
        }
        
        # Fit chart to screen
        chartJsObj$x$options$maintainAspectRatio = FALSE
        
        # set locale for '.' as decimal sign
        chartJsObj$x$options$locale = "en-US"
        
        # enable zoom
        chartJsObj$x$options$plugins$zoom = list(
          zoom = list(
            wheel = list(
              enabled = TRUE
            ),
            pinch = list(
              enabled = TRUE
            ),
            mode = "xy",
            overScaleMode = "y"
          ),
          pan = list(
            enabled = TRUE,
            mode = "xy"
          )
        )
        
        return(chartJsObj %>% cjsLegend())
      })
      
      # download buttons: png & csv
      output[[paste0(indicator, "DownloadButtons")]] <- renderUI({
        
        canvasId <- paste0(indicator, "Chart")
        
        tagList(
          tags$div(class = " dashboard-btn-wrapper",
                   tags$a(
                     id = ns(paste0(indicator, "DownloadCsv")),
                     class = "btn btn-default btn-custom pivot-btn-custom shiny-download-link dashboard-btn dashboard-btn-csv",
                     href = "",
                     target = "_blank",
                     download = NA,
                     tags$div(
                       tags$i(class = "fa fa-file-csv")
                     ),
                     title = lang$renderers$miroPivot$btDownloadCsv
                   ),
                   tags$a(
                     id = ns("downloadPng"),
                     class = "btn btn-default bt-export-canvas btn-custom pivot-btn-custom dashboard-btn dashboard-btn-png",
                     download = paste0(canvasId, ".png"),
                     href = "#",
                     `data-canvasid` = ns(canvasId),
                     tags$div(
                       tags$i(class = "fa fa-file-image")
                     ),
                     title = lang$renderers$miroPivot$btDownloadPng
                   )
          )
        )
      })
      
      #download csv data
      output[[paste0(indicator, "DownloadCsv")]] <- downloadHandler(
        filename = paste0(indicator, ".csv"),
        content = function(file) {
          return(write_csv(dashboardChartData[[indicator]], file, na = ""))
        }
      )
      
    })
  }
  if (!length(dashboard) || !length(generalConfig$tabNames$dashboard)) {
    hideTab("outputTabs", "dashboard", session = session)
  }
  
  ############################
  #### End dashboard code ####
  ############################
  
  if(!length(dataExplorer) || !length(generalConfig$tabNames[["dataExplorer"]])){
    hideTab("outputTabs", "dataExplorer", session = session)
  }  
  updateTabsetPanel(session, "outputTabs", selected = names(generalConfig$tabNames)[[1]])
}