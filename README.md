# Student-Formula-Report

This repository contains the findings and the code I developed to perform statistical analysis and study the vehicular dynamics on the Bengal 2023. Here are the following scripts and their descriptions. The work here is done based on Jorge Segers - Analysis Techniques for Race Car Data Acquistion. 

## Cornering Sequence Script

This script is the first script made. So, it contains some function which studies the data set. The cornering sequence script contains the following plots/functions:

1) Investigates the relationship between Front and Rear Brake Pressures
2) Investigates the relationship between the speed of all the wheel (Front Left, Front Right, Rear Left, Rear Right)
3) Visualises the different events taking place during cornering (Throttle Position, Brake Pedal Position, Steering Angle and Wheel Speed) for each wheel throughout the entire time
4) Contains an algorithm which identifies when the car is turing based on lateral acceleration (Lat G Force > 0.5)
5) Does (3) again but now restricted to each cornering
6) Calculates Slip Angle for each wheel
7) Plot Slip angle against Lat G for each wheel for each cornering
8) Plot Traction Circle
9) Plots Effect of Speed on Lat G

To do List:

1) Make plot of effect of speed on Lat G similar to the one in page 150 & 151 in book 1.
2) Go through section 7.4
3) Go through section 7.5
4) Go through section 7.6
5) Go through section 7.7


## Tire Performance Script

The Tire Performance script contains the following functions/computations:

1) Estimating Overall Combined Acceleration through the entire time 
2) Extracting Combined Acceleration Values for each of the situations above: Overall Combined Acceleration, Combined Acceleration when Braking,Combined Acceleration when Cornering, Combined Acceleration when Accelerating, Combined Acceleration (Traction). 

Todo List: 

1) Find tire pressure and tire temperature data
2) Go through section 8.3
3) Go through section 8.4
4) Go through section 8.5
5) Go through section 8.6
6) Go through section 8.7
7) Go through section 8.8
8) Go through section 8.9


## Wheel Loads and Weight Transfer Script

1) Calculate Reacting Inertial Force
2) Calculating Weight Transfer due to Cornering

%Once again, this will work out better once I identify the left and the
%right turns. Then, plot those in order to see the lateral weight transfer
%during actual turns. 

3) Calculate Lateral Weight Transfer Unsprung Mass (Front/Rear)
4) Calculate Lateral Geometric Weight Transfer Unsprung Mass (Front/Rear)
5) Calculate Sprung Mass Center of Gravity  (h_SCOG)
6) Calculate h_roll
7) Calculate Longitudinal Weight Transfer


## Shock Absorbers

1) Calculate Spring Force for each damper
2) Calculate damper velocity for each damper
3) Calculating the shock absorpber Force
4) Plott the Spring Force and Shock Force of the same wheel
5) Plot shock force against vehicle speed
6) Plot Shock Absorber against absolute Velocity
7) Histogram to study speed ranges and their effect on dampening position



## To-Do/Improvement List

- come up with an algorithm to identify the timestamps when the turning is occuring and at each interval are we turning left or right (Cornering Seq - 3)

- So, I should figure out a way to slice the timestamps into when the turning is occuring and then study the slip angle against the lateral acceleration (Cornering Seq - 4)

-  The values here look all wrong, so fix them and redo the next part. Figure out how I can cut the speed of the vehicle into 3 sections. Maybe I can create a new speed array, sort the speed, and then cut it into 3 parts (Cornering seq - 6)

-  Add in all the respective images once I finalised the code

