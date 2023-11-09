miroimport_xlsx <- function(symbolNames, localFile = NULL, views = NULL, attachments = NULL, metadata = NULL, customRendererDir = NULL, ...){

  pathToXlsx <- dirname(localFile$datapath[1])
  zipFiles <- list.files(pathToXlsx, pattern = "\\.zip$", full.names = TRUE)
  
  if (length(zipFiles)) {
    for (zip in zipFiles) {
      zip::unzip(zipFiles, junkpaths = FALSE, exdir = pathToXlsx)
    }
  }
  
  xlsxFiles <- basename(list.files(pathToXlsx, pattern = "\\.xlsx$", full.names = TRUE, recursive = TRUE))
  runfile <- list.files(pathToXlsx, pattern = "\\.run$", full.names = TRUE)

  if (!length(xlsxFiles) ) {
    abortSafe("Please upload valid XLSX files")
  }
  if (!length(runfile)) {
    abortSafe("Please upload a valid run file")
  }
  
  # # Rename files to original names
  # for (i in 1:nrow(localFile)) {
  #   source_path <- localFile$datapath[i]
  #   new_name <- localFile$name[i]
  #   
  #   tryCatch({
  #     file.rename(source_path, file.path(dirname(source_path), new_name))
  #     cat("Renamed:", source_path, "to", new_name, "\n")
  #   }, error = function(e) {
  #     cat("Error renaming:", source_path, "- Error:", conditionMessage(e), "\n")
  #   })
  # }
  
  ifelse(!dir.exists(file.path(customRendererDir, "times-excel-reader-output")), 
         dir.create(file.path(customRendererDir, "times-excel-reader-output")), 
         FALSE)
  ddFilesDir <- file.path(customRendererDir, "times-excel-reader-output")
  modelDir <- file.path(customRendererDir, "model-for-conversion")
  runfile <- list.files(pathToXlsx, pattern = "\\.run$", full.names = TRUE)
  
  # call times_excel_reader.py to create dd files from uploaded xlsx files
  tryCatch(
    {
      #TODO: use venv (located in renderer dir with all packages)
      processx::run(
        # command = "python", args = c(
        # command = "times-excel-reader", args = c(
        command = file.path(customRendererDir, "times-excel-reader", ".venv", "Scripts", "times-excel-reader.exe"), args = c(
          # file.path(customRendererDir, "times-excel-reader", "times_excel_reader.py"),
          # "times-excel-reader",
          pathToXlsx,
          "--output_dir", ddFilesDir,
          "--dd"
        ),
        wd = file.path(customRendererDir, "times-excel-reader"),
        echo_cmd = TRUE, echo = TRUE,
        windows_hide_window = TRUE, timeout = 100L,
        env = c(
          VIRTUAL_ENV=file.path(customRendererDir, "times-excel-reader", ".venv"),
          PATH=paste0(file.path(customRendererDir, "times-excel-reader", ".venv", "Scripts"), .Platform$path.sep, Sys.getenv("PATH"))

          # export VIRTUAL_ENV
          # _OLD_VIRTUAL_PATH="$PATH"
        )
      )
    },
    error = function(e) {
      abortSafe(
        sprintf("Problems importing xlsx data. Error message: '%s'.",
        conditionMessage(e))
      )
    }
  )
  
  #zip dd files
  ddFiles <- basename(list.files(ddFilesDir, pattern = "\\.dd$", full.names = TRUE))
  
  zipFile <- file.path(ddFilesDir, "dd_files.zip")
  zip::zip(zipFile, ddFiles, root = ddFilesDir)
  file.copy(zipFile, modelDir, overwrite = TRUE)

  # call GAMS to convert dd files into MIRO-compatible GDX
  
  tryCatch(
    {
      processx::run(
        command = "gams", args = c(
          file.path(modelDir, "dd_to_gdx.gms"),
          "--gmsrunopt=local", "--DDPREFIX=dd_files/", paste0("--runfile=", runfile)
        ),
        wd = file.path(modelDir),
        echo_cmd = TRUE, echo = TRUE,
        windows_hide_window = TRUE, timeout = 10L
      )
    },
    error = function(e) {
      abortSafe(
        sprintf("Problems running dd to gdx conversion. Error message: '%s'.",
                conditionMessage(e))
      )
    }
  )
  
  # functions for reading gdx
  rgdxScalarCustom <- function(symName = NULL, sym = NULL) {
    if (!length(sym)) {
      sym <- gdxrrwMIRO::rgdx(gdxFile, list(name = symName))
    }
    c <- 0
    if (identical(1L, dim(sym$val)[1])) {
      c <- sym$val[[1]][1]
    }
    return(c)
  }
  
  rgdxSetCustom <- function(symName, names = NULL) {
    sym <- gdxrrwMIRO::rgdx(gdxFile, list(
      name = symName,
      compress = FALSE,
      ts = FALSE, te = TRUE
    ),
    squeeze = FALSE, useDomInfo = TRUE
    )
    symDim <- sym$dim
    if (length(names)) {
      stopifnot(is.character(names), identical(length(names), symDim + 1L))
    }
    dflist <- vector("list", symDim + 1L)
    if (identical(dim(sym$val)[1], 0L)) { # empty symbol - no elements
      return(tibble())
    } else {
      dflist[seq_len(symDim)] <- lapply(seq_len(symDim), function(d) {
        # first arg to factor must be integer, not numeric: different as.character results
        factor(as.integer(sym$val[, d]),
               seq(to = length(sym$uels[[d]])),
               labels = sym$uels[[d]]
        )
      })
    }
    dflist[[symDim + 1L]] <- sym$te
    names(dflist) <- seq_along(dflist)
    symDF <- tibble::as_tibble(dflist)
    symDF <- dplyr::mutate(symDF, across(where(is.factor), as.character))
    if (symName %in% ioConfig$textOnlySymbols) {
      symDF <- symDF[, c(2, 1)]
    }
    if (length(names)) {
      names(symDF) <- names
    }
    return(symDF)
  }
  
  rgdxParamCustom <- function(symName, names = NULL) {
    sym <- gdxrrwMIRO::rgdx(gdxFile, list(name = symName, compress = FALSE, ts = FALSE),
                            squeeze = FALSE, useDomInfo = TRUE
    )
    symDim <- sym$dim
    if (identical(symDim, 0L)) {
      return(rgdxScalarCustom(sym = sym))
    }
    rgdxTibbleCustom(sym, symDim, names)
  }
  
  rgdxTibbleCustom = function(sym, symDim, names = NULL) {
    if (length(names)) {
      stopifnot(is.character(names), identical(length(names), symDim + 1L))
    }
    dflist <- vector("list", symDim + 1L)
    if (identical(dim(sym$val)[1], 0L)) { # empty symbol - no elements
      return(tibble())
    } else {
      dflist[seq_len(symDim)] <- lapply(seq_len(symDim), function(d) {
        # first arg to factor must be integer, not numeric: different as.character results
        factor(as.integer(sym$val[, d]), seq(to = length(sym$uels[[d]])),
               labels = sym$uels[[d]]
        )
      })
    }
    dflist[[symDim + 1L]] <- sym$val[, symDim + 1L]
    names(dflist) <- paste0("...***...", seq_along(dflist))
    symDF <- tibble::as_tibble(dflist)
    symDF <- dplyr::mutate(symDF, across(where(is.factor), as.character))
    if (length(names)) {
      names(symDF) <- names
    }
    return(symDF)
  }
  
  # read generated GDX file
  gdxFile <- file.path(pathToXlsx, "miroScenario.gdx")
  
  sym_list <- lapply(symbolNames, function(name){
    if(name %in% c("solveropt", "scenddmap", "timeslice", "milestonyr", "extensions", "dd_prc_desc", "dd_com_desc", "gmssolver", "gmsobj")){
      #, "gmsrunlocation", "gmsrunmode"
      return(rgdxSetCustom(symName = name))
    }
    #parameters
    if(name %in% c("cubeinput", "gmsreslim", "gmsbratio", "gmsbotime", "gmseotime")){
      return(rgdxParamCustom(symName = name))
    }
  })
  names(sym_list) <- symbolNames
  return(sym_list)
  
}







# Start with dd files and runfile
miroimport_dd <- function(symbolNames, localFile = NULL, views = NULL, attachments = NULL, metadata = NULL, customRendererDir = NULL, ...){
  
  #TODO: make use of abortSafe more often
  # if (is.null(localFile) || !identical(length(localFile$datapath), 1L)) {
  #   abortSafe("Please upload a single, valid XLSX file")
  # }
  
  pathToDD <- dirname(localFile$datapath[1])
  zipFiles <- list.files(pathToDD, pattern = "\\.zip$", full.names = TRUE)
  
  if (length(zipFiles)) {
    for (zip in zipFiles) {
      zip::unzip(zipFiles, junkpaths = TRUE, exdir = pathToDD)
    }
  }
  
  ddiles <- basename(list.files(pathToDD, pattern = "\\.dd$", full.names = TRUE))
  runfile <- list.files(pathToDD, pattern = "\\.run$", full.names = TRUE)
  
  if (!length(ddiles) ) {
    abortSafe("Please upload valid dd files")
  }
  if (!length(runfile)) {
    abortSafe("Please upload a valid run file")
  }
  
  # # Rename files to original names
  # for (i in 1:nrow(localFile)) {
  #   source_path <- localFile$datapath[i]
  #   new_name <- localFile$name[i]
  #   
  #   tryCatch({
  #     file.rename(source_path, file.path(dirname(source_path), new_name))
  #     cat("Renamed:", source_path, "to", new_name, "\n")
  #   }, error = function(e) {
  #     cat("Error renaming:", source_path, "- Error:", conditionMessage(e), "\n")
  #   })
  # }
  
  ddiles <- basename(list.files(pathToDD, pattern = "\\.dd$", full.names = TRUE))
  runfile <- list.files(pathToDD, pattern = "\\.run$", full.names = TRUE)
  modelDir <- file.path(customRendererDir, "model-for-conversion")

  #zip dd files
  ddFiles <- basename(list.files(pathToDD, pattern = "\\.dd$", full.names = TRUE))
  zipFile <- file.path(pathToDD, "dd_files.zip")
  zip::zip(zipFile, ddFiles, root = pathToDD)
  file.copy(zipFile, modelDir, overwrite = TRUE)
  
  # call GAMS to convert dd files into MIRO-compatible GDX
  
  tryCatch(
    {
      processx::run(
        command = "gams", args = c(
          file.path(modelDir, "dd_to_gdx.gms"),
          "--gmsrunopt=local", "--DDPREFIX=dd_files/", paste0("--runfile=", runfile)
        ),
        wd = file.path(modelDir),
        echo_cmd = TRUE, echo = TRUE,
        windows_hide_window = TRUE, timeout = 10L
      )
    },
    error = function(e) {
      abortSafe(
        sprintf("Problems running dd to gdx conversion. Error message: '%s'.",
                conditionMessage(e))
      )
    }
  )
  
  # functions for reading gdx
  rgdxScalarCustom <- function(symName = NULL, sym = NULL) {
    if (!length(sym)) {
      sym <- gdxrrwMIRO::rgdx(gdxFile, list(name = symName))
    }
    c <- 0
    if (identical(1L, dim(sym$val)[1])) {
      c <- sym$val[[1]][1]
    }
    return(c)
  }
  
  rgdxSetCustom <- function(symName, names = NULL) {
    sym <- gdxrrwMIRO::rgdx(gdxFile, list(
      name = symName,
      compress = FALSE,
      ts = FALSE, te = TRUE
    ),
    squeeze = FALSE, useDomInfo = TRUE
    )
    symDim <- sym$dim
    if (length(names)) {
      stopifnot(is.character(names), identical(length(names), symDim + 1L))
    }
    dflist <- vector("list", symDim + 1L)
    if (identical(dim(sym$val)[1], 0L)) { # empty symbol - no elements
      return(tibble())
    } else {
      dflist[seq_len(symDim)] <- lapply(seq_len(symDim), function(d) {
        # first arg to factor must be integer, not numeric: different as.character results
        factor(as.integer(sym$val[, d]),
               seq(to = length(sym$uels[[d]])),
               labels = sym$uels[[d]]
        )
      })
    }
    dflist[[symDim + 1L]] <- sym$te
    names(dflist) <- seq_along(dflist)
    symDF <- tibble::as_tibble(dflist)
    symDF <- dplyr::mutate(symDF, across(where(is.factor), as.character))
    if (symName %in% ioConfig$textOnlySymbols) {
      symDF <- symDF[, c(2, 1)]
    }
    if (length(names)) {
      names(symDF) <- names
    }
    return(symDF)
  }
  
  rgdxParamCustom <- function(symName, names = NULL) {
    sym <- gdxrrwMIRO::rgdx(gdxFile, list(name = symName, compress = FALSE, ts = FALSE),
                            squeeze = FALSE, useDomInfo = TRUE
    )
    symDim <- sym$dim
    if (identical(symDim, 0L)) {
      return(rgdxScalarCustom(sym = sym))
    }
    rgdxTibbleCustom(sym, symDim, names)
  }
  
  rgdxTibbleCustom = function(sym, symDim, names = NULL) {
    if (length(names)) {
      stopifnot(is.character(names), identical(length(names), symDim + 1L))
    }
    dflist <- vector("list", symDim + 1L)
    if (identical(dim(sym$val)[1], 0L)) { # empty symbol - no elements
      return(tibble())
    } else {
      dflist[seq_len(symDim)] <- lapply(seq_len(symDim), function(d) {
        # first arg to factor must be integer, not numeric: different as.character results
        factor(as.integer(sym$val[, d]), seq(to = length(sym$uels[[d]])),
               labels = sym$uels[[d]]
        )
      })
    }
    dflist[[symDim + 1L]] <- sym$val[, symDim + 1L]
    names(dflist) <- paste0("...***...", seq_along(dflist))
    symDF <- tibble::as_tibble(dflist)
    symDF <- dplyr::mutate(symDF, across(where(is.factor), as.character))
    if (length(names)) {
      names(symDF) <- names
    }
    return(symDF)
  }
  
  # read generated GDX file
  gdxFile <- file.path(pathToDD, "miroScenario.gdx")
  
  sym_list <- lapply(symbolNames, function(name){
    if(name %in% c("solveropt", "scenddmap", "timeslice", "milestonyr", "extensions", "dd_prc_desc", "dd_com_desc", "gmssolver", "gmsobj", "gmsrunlocation", "gmsrunmode")){
      return(rgdxSetCustom(symName = name))
    }
    #parameters
    if(name %in% c("cubeinput", "gmsreslim", "gmsbratio", "gmsbotime", "gmseotime")){
      return(rgdxParamCustom(symName = name))
    }
  })
  names(sym_list) <- symbolNames
  return(sym_list)
  
}