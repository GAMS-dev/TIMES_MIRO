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

#### Launch TIMES_DEMO App
To launch the TIMES_DEMO app, open `TIMES_MIRO.gms` in [GAMS Studio](https://www.gams.com/latest/docs/T_STUDIO.html) and press F8 or select *MIRO --> Run base mode* from the ribbon menu.

![runbasemode](/pics/run_base_mode.png?raw=true)

#### Launch TIMES-DK_COMETS App
To launch the TIMES-DK_COMETS app, open `TIMES_MIRO.gms` in [GAMS Studio](https://www.gams.com/latest/docs/T_STUDIO.html) and press F8 or select *MIRO --> Run base mode* from the ribbon menu and set [double dash parameter](https://www.gams.com/latest/docs/UG_GamsCall.html#UG_GamsCall_DoubleDashParametersEtc) `--DATASET=dk`.

![runbasemodedk](/pics/run_base_mode_dk.png?raw=true)

#### Launch your individual TIMES App
*to be completed*

### Input View
After launching the app as described above, the app should open inside the browser and the Input view is is shown. Input is organized in eight tabs which are described below.

#### Input Widgets
The Input widgets tab allows to specify some basic settings. Most of them should be self expalining but special attention should be paid to the option to either solve the model locally or to submit it to the [NEOS Server for Optimization](https://neos-server.org/neos/). Submitting the model to NEOS allows to solve models that go beyond the [GAMS demo limits](https://www.gams.com/latest/docs/UG_License.html#General_Information) with a free GAMS demo license.

![inputwidgets](/pics/input_widgets.png?raw=true)

#### DD Files
The DD Files Tab allows to specify the set of dd files and their order that should be used for the run.

#### Timeslices
The Timslices Tab shows the set of time slices for the current model. This is shown for the sake of completeness but should not be edited.  The set of timeslices and the representation of the intra-annual resolution is preconfigured and of central to many model parameters. A re-configuration of this set would require extensive modifications in the input parameters

#### Years for this model run
This tab allows to select the set of years for which the model will run. Those years areoften referred to as *milestone years*.

#### Input
This is the central tab for browsing and editing input data. The concept of this tab follows the idea to look at data based on "important" indices (e.g. Region, Year, Process, Commodity, Time Slice, ...). Such important indices are predefined in the wrapper file `TIMES_MIRO.gms`.
Data can be browsed end edited in a table view that supports sorting and filtering:
*insert screenshot*
In the upper right corner there is *switch view* button that allows to browse the data in a powerful pivot table view.
*insert screenshot*
Currently, editing the data in the pivot table view is not supported.

#### Scenario DD File map
This tab allows to browse and edit multiple combinations of dd files (and their order) that result in different scenarios.

#### TIMES Extensions
This tab allows to enable/disable several TIMES extensions

#### Solver Options
This tab allows to change/define solver options to be used

### Output View

### GAMS Interaction View

#### Log file

#### Listing file

## Functionality
The basic principle of the TIMES MIRO demo app is that it works as a wrapper around the existing TIME source code and the well established data handling concept that feeds the model with data via so-called *.dd files.

### The Driver File timesdriver.gms

### The Wrapper File TIMES_MIRO.gms

# License
The MIRO demo app is licensed under the MIT license (see file LICENSE). Note that everything inside the TIMES_Demo submodule is licensed under GPL-3. See file `TIMES_Demo\LICENSE.txt` for more information.
