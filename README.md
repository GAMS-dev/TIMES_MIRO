# TIMES MIRO demo app
This is a [GAMS MIRO](https://gams.com/miro) demo app for the [IEA-ETSAP TIMES](https://github.com/etsap-TIMES/TIMES_model) model.
To obtain the app, including the [TIMES_Demo](https://github.com/etsap-TIMES/TIMES_Demo) data set and the the [TIMES-DK_COMETS](https://github.com/energy-modelling-club/TIMES-DK_COMETS) data sets, run the following command:
> git clone --recurse-submodules https://github.com/GAMS-dev/TIMES_MIRO.git

## Prerequisites
In order to use the TIMES MIRO demo app you need
* to clone this repository
* to install GAMS 31.2.0 or newer
* to install GAMS MIRO 1.0.4 or newer

## Usage of the App
The App can be launched with two predefined data sets, the [TIMES_Demo](https://github.com/etsap-TIMES/TIMES_Demo) data set (default) and the the [TIMES-DK_COMETS](https://github.com/energy-modelling-club/TIMES-DK_COMETS) data set.

### Launching the App

#### Launch TIMES_DEMO App
To launch the TIMES_DEMO app, open `TIMES_MIRO.gms` in [GAMS Studio](https://www.gams.com/latest/docs/T_STUDIO.html) and press F8 or select *MIRO --> Run base mode* from the ribbon menu.

![runbasemode](/pics/run_base_mode.png?raw=true)

#### Launch TIMES-DK_COMETS App
To launch the TIMES-DK_COMETS app, open `TIMES_MIRO.gms` in [GAMS Studio](https://www.gams.com/latest/docs/T_STUDIO.html) and press F8 or select *MIRO --> Run base mode* from the ribbon menu and set [double dash parameter](https://www.gams.com/latest/docs/UG_GamsCall.html#UG_GamsCall_DoubleDashParametersEtc) `--DATASET=dk`.

![runbasemodedk](/pics/run_base_mode_dk.png?raw=true)

#### Launch your individual TIMES App
*to be completed*

### Structure of the App
After launching the app as described above, the app should open inside the browser
The menu on the left allows to navigate between
* Input View
* Output View
* GAMS Interaction View
* Compare Scenarios View
Furthermore it allows to load data from different data sources (e.g. the MIRO Database or a GDX file).
Finally, the menu on the left also contains a solve button that allows to start a run based on settings and data specified in the input view.
![navigation](/pics/solve.png?raw=true)

#### Input View
The input view is organized in eight tabs which are described below.

##### Input Widgets
The Input widgets tab allows to specify some basic settings. Most of them should be self expalining but special attention should be paid to the option to either solve the model locally or to submit it to the [NEOS Server for Optimization](https://neos-server.org/neos/). Submitting the model to NEOS allows to solve models that go beyond the [GAMS demo limits](https://www.gams.com/latest/docs/UG_License.html#General_Information) with a free GAMS demo license.

![inputwidgets](/pics/input_widgets.png?raw=true)

##### DD Files
The DD Files Tab allows to specify the set of dd files and their order that should be used for the run.

##### Timeslices
The Timslices Tab shows the set of time slices for the current model. This is shown for the sake of completeness but should not be edited.  The set of timeslices and the representation of the intra-annual resolution is preconfigured and of central to many model parameters. A re-configuration of this set would require extensive modifications in the input parameters

##### Years for this model run
This tab allows to select the set of years for which the model will run. Those years areoften referred to as *milestone years*.

##### Input
This is the central tab for browsing and editing input data. The concept of this tab follows the idea to look at data based on "important" indices (e.g. Region, Year, Process, Commodity, Time Slice, ...). Such important indices are predefined in the wrapper file `TIMES_MIRO.gms`.
Data can be browsed end edited in a table view that supports sorting and filtering:
*insert screenshot*
In the upper right corner there is *switch view* button that allows to browse the data in a powerful pivot table view.
*insert screenshot*
Currently, editing the data in the pivot table view is not supported.

##### Scenario DD File map
This tab allows to browse and edit multiple combinations of dd files (and their order) that result in different scenarios.

##### TIMES Extensions
This tab allows to enable/disable several TIMES extensions

##### Solver Options
This tab allows to change/define solver options to be used

#### Output View
Once a TIMES model has been solved by clicking the *Solve Model* button, the Output view is filled with data from that solve.
Similar to the Input data, the concept of this tab follows the idea to look at data based on "important" indices (e.g. Region, Year, Process, Commodity, Time Slice, ...). Such important indices are predefined in the wrapper file `TIMES_MIRO.gms`.
Output data can be browsed in a  a powerful pivot table view.
*insert screenshot*
In the upper right corner there is *switch view* button that allows to browse the data in table view that supports sorting and filtering.
*insert screenshot*

The output view also provides basic charting facilities. Supported chart types are:
* bar chart
* stacked bar chart
* line chart
* radar chart

#### GAMS Interaction View
The GAMS Intearction View is automatically focussed during a run. It shows the log file while it is written. The log and lst file can be accessed after a run. Note that the lst file shown in the App is a combination of the lst files written when running the wrapper `TIMES_MIRO.gms` and the driver `timesdriver.gms`.

#### Compare Scenarios View
*to be completed*

## Functionality
The basic principle of the TIMES MIRO demo app is that it works as a wrapper around the existing TIME source code and the well established data handling concept that feeds the model with data via so-called *.dd files.

### The Driver File timesdriver.gms
The TIMES run is controlled by a driver file. When running TIMES through the TIMES_MIRO app, the driver file `timesdriver.gms` is created automatically based on settings made in the Input View. The basic structire of this file can be described as follows
```
$TITLE  TIMES -- VERSION 4.1.0
*<GAMS Options>
option resLim=1000, profile=1, solveOpt=REPLACE, bRatio=1;
option limRow=0, limCol=0, solPrint=OFF, solver=cplex;
$offListing

*<Create Solver Option file>
file fslvopt / "cplex.opt" /; put fslvopt "* Generated cplex option file" /;
$onPut
scaind 0
rerun YES
iis YES
lpmethod 4
baralg 1
barcrossalg 1
barorder 2
threads 8
$offPut

$onMulti
*<Define Timeslices>
set ALL_TS /
ANNUAL
S
W
SD
SN
WD
WN
/;

*<Adjustment for total available time span of years available in the model>
$set BOTIME 1960

*<DD Files>
$batInclude initsys.mod
$batInclude initmty.mod
$batInclude base.dd
$batInclude newtechs.dd
$batInclude trade_param.dd
$batInclude dem_ref.dd
$batInclude syssettings.dd
$batInclude peak_rsv.dd
$batInclude refinery.dd
$batInclude demproj_dtcar.dd
$batInclude uc_nuc_maxcap.dd
$batInclude bounds-uc_wsets.dd

*<Years for this model run>
Set MILESTONYR /
2005
2010
2015
2020
2030
2050
/;

*<define RUN_NAME>
$set RUN_NAME demo12

*<batinclude of TIMES source code>
$ BATINCLUDE maindrv.mod mod
```

### The Wrapper File TIMES_MIRO.gms
This file is at the heart of the TIMES_MIRO demo app.
* It defines and uses the extraordinary domain sets that are used in the cube view for input and output data.
```
set xidom          'Extraordinary input domains'  / UC_N UserConstraint, ALL_REG Region, ALLYEAR Period, PRC Process, COM_GRP Commodity, ALL_TS TimeSlice/
    xodom          'Extraordinary output domains' /                      ALL_REG Region, ALLYEAR Period, PRC Process, COM_GRP Commodity, ALL_TS TimeSlice/
[...]
;
```
* It lists all GAMS Symbols with type and domain information that should be shown in the input data cube. The domain has to be provided in a format that lists all the *extraordinary* domain sets and replaces non-extraordinary domain sets by numbers 1,2,...
```
Set cdInput(siName<,typ,*) 'Cube Input Data' /
REG             .'Set'.'ALL_REG'
CUR             .'Set'.'1'
UNITS           .'Set'.'1'                                               
UNITS_ACT       .'Set'.'1'                                               
UNITS_CAP       .'Set'.'1'                                               
UNITS_COM       .'Set'.'1'                                               
UNITS_MONY      .'Set'.'1'                                               
ACT_BND         .'Par'.'ALL_REG,ALLYEAR,PRC,ALL_TS,1'                    
ACT_COST        .'Par'.'ALL_REG,ALLYEAR,PRC,1'                           
ACT_CUM         .'Par'.'ALL_REG,PRC,1,2,3'  
[...]
```
There is no guarantuee that all symbols potentially used in TIMES are already contained in this list. In that case, a comprehensive error message that shows missing symbols should be given.

* It lists all GAMS Symbols with type and domain information that should be shown in the output data cube. The domain has to be provided in a format that lists all the *extraordinary* domain sets and replaces non-extraordinary domain sets by numbers 1,2,...
```
Set cdOutput(soName<,typ,*) 'Cube Data' /
*** Variables & Parameters
'par_actl'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,ALL_TS'        
'par_actm'     . 'par'   . 'ALL_REG,1,ALLYEAR,PRC,ALL_TS'        
'par_capl'     . 'par'   . 'ALL_REG,ALLYEAR,PRC'                 
'par_pasti'    . 'par'   . 'ALL_REG,ALLYEAR,PRC,1'               
[...]
```

* It uses embedded Python code to compute a mapping between original GAMS Symbols and the input/output data cubes shown in the TIMES_MIRO demo app

* 


# License
The MIRO demo app is licensed under the MIT license (see file LICENSE). Note that everything inside the TIMES_Demo submodule is licensed under GPL-3. See file `TIMES_Demo\LICENSE.txt` for more information.
