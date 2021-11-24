Table of Contents
=================

   * [TIMES MIRO App](#times_miro-app)
      * [Prerequisites](#prerequisites)
      * [Usage of the App](#usage-of-the-app)
      * [Code Structure](#code-structure)
   * [License](#license)

# TIMES MIRO App<a name="times_miro-app"></a>
This is a [GAMS MIRO](https://gams.com/miro) app for the [IEA-ETSAP TIMES](https://github.com/etsap-TIMES/TIMES_model) model.

To obtain the app, including the TIMES source from the [TIMES_model](https://github.com/etsap-TIMES/TIMES_model) repositury plus the [TIMES_Demo](https://github.com/etsap-TIMES/TIMES_Demo) and the the [TIMES-DK\_COMETS](https://github.com/energy-modelling-club/TIMES-DK_COMETS) data sets, run the following command:
> git clone --recurse-submodules https://github.com/GAMS-dev/TIMES_MIRO.git

The app allows the user to load different data sets, to set TIMES options, to manipulate input data, to analyze output data, and to compare scenarios. Furthermore, the user can decide whether to run the TIMES MIRO app locally (local [GAMS](https://www.gams.com/download/) and [GAMS MIRO](https://www.gams.com/miro/download.html) installation required) or to access the [online App](https://times.gams.com/login) that submits jobs to the [TIMES Cloud Service](https://times.gams.com/engine/) (credentials can be requested by sending an email to timescloud@etsap.org).

## Prerequisites<a name="prerequisites"></a>
In order to use the online TIMES MIRO app that submits jobs to the TIMES Cloud Service you need
* request credentials from timescloud@etsap.org and login at https://times.gams.com/login

In order to use the TIMES MIRO app locally you need
* to clone this repository or download the self contained *.miroapp file (https://github.com/GAMS-dev/TIMES_MIRO/releases)
* to install GAMS 31.2.0 or newer (https://www.gams.com/download/)
* to install GAMS MIRO 2.2.0 or newer (https://www.gams.com/miro/download.html)

**Note:** Starting the app locally for the first time may take some time because the predefined scenario data sets have to be imported to the MIRO database.

## Usage of the App<a name="usage-of-the-app"></a>
Usage of the app is explained in detail in the [app_README](app_README.md).

## Code Structure<a name="code-structure"></a>
The basic principle of the TIMES MIRO app is that it works as a wrapper around the existing TIMES source code and the well established data handling concept that feeds the model with data via so-called \*.dd files.

The code sections referred to in the following overview are highlighted via corresponding comments in the wrapper file `times_miro.gms`. Also note that there is difference between running the file through the app (this is what happens in the background when the user hits "solve") and running it through Studio. Running the file through studio is mainly useful to prepare new TIMES data sets for usage with the app. To do so, run 

>times_miro.gms --RUNMODE=create --RUNFILE=<path/to/runfile.run> --DDPREFIX=<path/to/ddFiles/>

where you replace `<path/to/runfile.run>` by a locally available \*.run file and replace `<path/to/ddFiles/>` by a local folder that contains all the relevant \*.dd files (**make sure to provide the final directory separator!!!**).

![inputcube](static_times_miro/code_structure.png)

# License<a name="license"></a>
The MIRO demo app is licensed under the MIT license (see file LICENSE). Note that everything inside the times\_model, TIMES\_Demo as well as the TIMES-DK_COMETS submodules is licensed under GPL-3. See files `times_model\LICENSE.txt`, `TIMES_Demo\LICENSE.txt` as well as `TIMES-DK_COMETS\LICENSE` for more information.
