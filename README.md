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

### Launching the App

#### Launch TIMES_DEMO App

#### Launch TIMES-DK_COMETS App

#### Launch your individual TIMES App

### Input View

#### Options

#### Input Widgets

#### DD Files

#### Timeslices

#### Years for this model run

#### Input

#### Scenario DD File map

#### TIMES Extensions

#### Solver Options

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
