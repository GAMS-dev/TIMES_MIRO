miroimport_times <- function(symbolNames,
                             localFile = NULL,
                             views = NULL,
                             attachments = NULL,
                             metadata = NULL,
                             customRendererDir = NULL,
                             ...) {
  if (length(localFile$datapath) != 1 || !endsWith(tolower(localFile$datapath), ".zip")) {
    abortSafe("Please upload a single zip file containing either xlsx or dd files as well as a run file.")
  }
  filesInZip <- zip::zip_list(localFile$datapath)
  xlsxFiles <- filesInZip$filename[endsWith(tolower(filesInZip$filename), ".xlsx") | 
                                     endsWith(tolower(filesInZip$filename), ".xlsm")]
  ddFiles <- filesInZip$filename[endsWith(tolower(filesInZip$filename), ".dd")]
  runFile <- filesInZip$filename[endsWith(tolower(filesInZip$filename), ".run")]
  
  if (length(runFile) != 1) {
    zip::zip_append(localFile$datapath,
                    file.path(customRendererDir, "default.run"), 
                    mode = "cherry-pick")
    filesInZip <- zip::zip_list(localFile$datapath)
    runFile <- filesInZip$filename[endsWith(filesInZip$filename, ".run")]
    flog.info("Default run file used since no run file was provided.")
  }
  
  if (any(grepl("../", c(runFile, xlsxFiles, ddFiles), fixed = TRUE))) {
    abortSafe("Please upload a valid ZIP archive")
  }
  
  tempDir <- file.path(tempdir(TRUE), stringi::stri_rand_strings(1L, 10L))
  dir.create(tempDir)
  on.exit(unlink(tempDir, recursive = TRUE), add = TRUE)
  
  if (length(xlsxFiles)) {
    if (length(ddFiles)) {
      abortSafe("The ZIP archive you uploaded contains both XLSX and DD files. Please select one.")
    }
    zip::unzip(localFile$datapath,
               files = c(runFile, xlsxFiles),
               junkpaths = FALSE, exdir = tempDir
    )
    
    ddFilesDir <- file.path(tempDir, "times-excel-reader-output")
    dir.create(ddFilesDir, showWarnings = FALSE)
    
    # call times_excel_reader.py to create dd files from uploaded xlsx files
    tryCatch(
      {
        xl2times <- processx::run(
          command = "python",
          args = c(
            "-m",
            "xl2times",
            file.path(tempDir, xlsxFiles),
            "--output_dir", ddFilesDir,
            "--dd"
          ),
          error_on_status = FALSE,
          wd = tempDir,
          echo_cmd = TRUE, echo = TRUE,
          windows_hide_window = TRUE
        )
      },
      error = function(e) {
        abortSafe(
          sprintf(
            "Problems importing xlsx data. Error message: '%s'.",
            conditionMessage(e)
          )
        )
      }
    )
    
    if (xl2times$status != 0) {
      abortSafe(sprintf(
        "Problems importing xlsx data. Error message: '%s'.",
        xl2times$stdout
      ))
    }
    
  } else if (length(ddFiles)) {
    ddFilesDir <- tempDir
    zip::unzip(localFile$datapath,
               files = c(runFile, ddFiles),
               junkpaths = FALSE, exdir = ddFilesDir
    )
  } else {
    abortSafe("Please upload valid XLSX or DD files")
  }
  
  # call GAMS to convert dd files into MIRO-compatible GDX
  convertDDToGDX <- function(symbolNames, DDToGDXPath, runFilePath, ddFilesDir, dataSource) {
    tryCatch(
      {
        gamsrun <- processx::run(
          command = "gams", args = c(
            DDToGDXPath,
            "--gmsrunopt=local", paste0(
              "--DDPREFIX=",
              ddFilesDir,
              .Platform$file.sep
            ),
            paste0("--runfile=", runFilePath),
            paste0("--data_source=", dataSource)
          ),
          wd = tempDir,
          error_on_status = FALSE,
          echo_cmd = TRUE, echo = TRUE,
          windows_hide_window = TRUE, timeout = 10L
        )
      },
      error = function(e) {
        abortSafe(
          sprintf(
            "Problems running dd to gdx conversion. Error message: '%s'.",
            conditionMessage(e)
          )
        )
      }
    )
    
    if (gamsrun$status != 0) {
      # extract python NameError message
      errorMessage <- sub(".*NameError'>: \\s*(.*?)\\s*\\*\\*\\*.*", "\\1", gamsrun$stdout)
      if (errorMessage == gamsrun$stdout) {
        errorMessage <- "An unexpected error ocurred. Please check the log for more information."
      }
      flog.debug(gamsrun$stdout)
      abortSafe(errorMessage)
    }
    
    rgdxSetCustom <- function(gdxFile, symName) {
      sym <- gdxrrwMIRO::rgdx(gdxFile, list(
        name = symName,
        compress = FALSE,
        ts = FALSE, te = TRUE
      ),
      squeeze = FALSE, useDomInfo = TRUE
      )
      symDim <- sym$dim
      dflist <- vector("list", symDim + 1L)
      if (identical(dim(sym$val)[1], 0L)) { # empty symbol - no elements
        return(tibble())
      } else {
        dflist[seq_len(symDim)] <- lapply(seq_len(symDim), function(d) {
          # first arg to factor must be integer, not numeric:
          # different as.character results
          factor(as.integer(sym$val[, d]),
                 seq_along(sym$uels[[d]]),
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
      return(symDF)
    }
    
    rgdxParamCustom <- function(gdxFile, symName) {
      sym <- gdxrrwMIRO::rgdx(gdxFile,
                              list(
                                name = symName,
                                compress = FALSE,
                                ts = FALSE
                              ),
                              squeeze = FALSE,
                              useDomInfo = TRUE
      )
      symDim <- sym$dim
      if (identical(symDim, 0L)) {
        c <- 0
        if (identical(1L, dim(sym$val)[1])) {
          c <- sym$val[[1]][1]
        }
        return(c)
      }
      dflist <- vector("list", symDim + 1L)
      if (identical(dim(sym$val)[1], 0L)) { # empty symbol - no elements
        return(tibble())
      } else {
        dflist[seq_len(symDim)] <- lapply(seq_len(symDim), function(d) {
          # first arg to factor must be integer, not numeric:
          # different as.character results
          factor(as.integer(sym$val[, d]), seq_along(sym$uels[[d]]),
                 labels = sym$uels[[d]]
          )
        })
      }
      dflist[[symDim + 1L]] <- sym$val[, symDim + 1L]
      names(dflist) <- paste0("...***...", seq_along(dflist))
      symDF <- tibble::as_tibble(dflist)
      symDF <- dplyr::mutate(symDF, across(where(is.factor), as.character))
      return(symDF)
    }
    
    # read generated GDX file
    gdxFile <- file.path(dirname(runFilePath), "miroScenario.gdx")
    
    return(tryCatch(setNames(lapply(symbolNames, function(symbolName) {
      if (symbolName %in% c(
        "solveropt", "scenddmap", "timeslice", "milestonyr",
        "extensions", "dd_prc_desc", "dd_com_desc", "gmssolver"
      )) {
        return(rgdxSetCustom(gdxFile, symbolName))
      }
      # parameters
      if (symbolName %in% c(
        "cubeinput",
        "gmsreslim",
        "gmsbratio"
      )) {
        return(rgdxParamCustom(gdxFile, symbolName))
      }
    }), symbolNames), error = function(e) {
      abortSafe(
        sprintf(
          "Problems reading GDXfile created by dd to gdx conversion. Error message: '%s'.",
          conditionMessage(e)
        )
      )
    }))
  }
  modelDir <- file.path(customRendererDir, "model-for-import")
  convertDDToGDX(
    symbolNames,
    DDToGDXPath = file.path(modelDir, "dd_to_gdx.gms"),
    runFilePath = file.path(tempDir, runFile),
    ddFilesDir = ddFilesDir,
    dataSource = if(length(xlsxFiles)) "xlsx" else "dd"
  )
}
