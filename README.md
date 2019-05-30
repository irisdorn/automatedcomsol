# automatedcomsol


## Automatization of COMSOL Multiphysics® Model utilizing LiveLink™ for MATLAB®

Various .m files of code in MATLAB® for automating COMSOL Multiphysics® 

* __[Required Software](https://github.com/irisdorn/automatedcomsol#required-software "Required Software")__
* __[Few tips for getting started](https://github.com/irisdorn/automatedcomsol#few-tips-for-getting-started "Few tips for getting started")__
* __[Other Useful Code](https://github.com/irisdorn/automatedcomsol#other-useful-code "Other Useful Code")__
* __[Contents](https://github.com/irisdorn/automatedcomsol#contents "Contents")__




## Required Software
* [COMSOL Multiphysics®](https://www.comsol.com/comsol-multiphysics "COMSOL Multiphysics®")
  * With [LiveLink™ for MATLAB®](https://www.comsol.com/livelink-for-matlab "LiveLink™ for MATLAB®")
* [MATLAB®](https://www.mathworks.com/products/matlab.html "MATLAB®")

This series of automation .m files were applied to superconducting 1d wire COMSOL model. This particular model was created by implementing the set of Ginzburg-Landau equations into COMSOL’s time-dependent equation based module with the general coefficient PDE form. 
Linking Comsol with MATLAB allowed us to automate several tasks for finding solutions and each task is described below and in the .m files.

### Few tips for getting started
 
1. Launch COMSOL Multiphysics® (Your Version) with MATLAB® Program

_Make sure all other programs, even COMSOL and MATLAB standalones, are closed. This singular program will control both._

2. Load model from command line or into .m file 

_Ensure that you are in the same directory/folder as your COMSOL file._

```
model = mphload('ModelName.mph')
```

3. Access the properties of your model


```
mphlaunch
```

_mphlaunch will launch your model in the COMSOL user interface. This can be useful as you learn more about the mphnavigator settings and how to extract m file code for automating._

or

```
mphnavigator
```

_mphnavigator allows you access to the elements and subproperties of your model. Here is where you will find the tags for your model and can vary this code according to your model's tags. There are many useful lines of code that can be extracted using the 'Copy Get' or 'Copy Set' options in this window._


#### Other Useful Code

Setting values for parameters
```
L= 10; %Set variable value
model.param.set('L0', L); %Set parameter 'L0' to value of L
```

Run the study
```
model.study('std1').run;
```

Generate a plot
```
 model.result("pg6").run();
```

Export an animation/video
```
model.result.export('anim2').run;
```

Clearing the solution
```
model.sol('sol1').clearSolutionData(); %Clear solution 1
```

## Contents:
[AutomationMinimaCount.m](https://github.com/irisdorn/automatedcomsol/blob/master/AutomationMinimaCount.m "AutomationMinimaCount.m")

This file sets a start value for two parameters. A while loop sets an upper limit for one particular parameter. 

The AutomationMinimaCount.m file automated the following tasks:

* Setting the new parameters
* Running the study
* Running the plot
* Exporting the plot data (.txt file)
* Loading the plot data into MATLAB
* Finding local minima with a certain prominence. See documentation on: [islocalmin](https://www.mathworks.com/help/matlab/ref/islocalmin.html?searchHighlight=islocalmin&s_tid=doc_srchtitle "islocalmin")
* Count local minima as n and display
* Runs a set of if-else if conditions in which second parameter is varied, the model solution is cleared and study is rerun 
or 
  * If particular minima condition is met, the parameter values are stored in a .mat file
  * A filename is created from the parameter values
  * The plot is created with title and marking of the minima in with red star marker
  * The plot is saved as a png and the parameters in the while loop is varied

[MinimaLocations.m](https://github.com/irisdorn/automatedcomsol/blob/master/MinimaLocations.m "MinimaLocations.m")

The MinimaLocations.m file automated the following tasks:

* Loads a .mat data set and stores the columns/parameters
* For loop over all elements
* Load model and clear solution data
* Set parameters 
* Run study 
* Run plot
* Export plot data
* Import plot txt file
* Checks that plot is not empty and prints error message
* Else finds locations of minima
* Stores unique values of minima locations
* Plots these locations
* Stores each location in list with paramaters
