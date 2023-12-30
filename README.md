# Student-Formula-Report

This repository contains the findings and the code I developed to perform statistical analysis and study the vehicular dynamics on the Bengal 2023. This is a document to keep track of the Bengal Data Analysis. The purpose of this is to keep track of my analysis and also showcase what I have done, and gathering what I have learnt from the data set. Here are the following scripts are what they do.

## Cornering Sequence Script

The cornering sequence script contains the following plots/functions:

### Function to visualise the relationship between Front and Rear Brake Pressures against Time

### Function to visualise the relationship between the speed of the Four Wheels against Time

### Plot the brake pressure (front & back), steered angle and wheel (for each wheel) to identify the turning points

Turns out this is not a good approach. I realise it is hard to do it visually. So, it is better to come up with an algorithm to identify the timestamps when the turning is occuring and at each interval are we turning left or right. So, add this to my To-Do List!!

### Function to calculate the Slip Angle of Each Wheel, and then visualise this. We also plot this against the lateral acceeleration

Again, turns out this is not a good approach. Note that the graphs look weird as I have not yet spliced the time. So, I should figure out a way to slice the timestamps into when the turning is occuring and then study the slip angle against the lateral acceleration.

### Plot the traction circle, the "g-g" plot and then the combined acceleration

### Study the effects of speed on the lateral acceleration

Again, turns out this is not a good approach. The values here look all wrong, so fix them and redo the next part. Figure out how I can cut the speed of the vehicle into 3 sections. Maybe I can create a new speed array, sort the speed, and then cut it into 3 parts). 

### Ackermann Steering Angle and it's Related Calculations

### Calculating Yaw Balance



## Tire Performance Script

The Tire Performance script contains the following functions/computations:

### Estimating Overall Grip by calculating the combined acceleration

Firstly, thusfar, I have only computed the combined acceleration. I have to calculate the overall grip. 

But then The problem with this approach is that we can’t compare results between different tracks as the number of high- and low-speed corners and the amount of straights
would skew the average combined acceleration values. So, we gated the combined acceleration channel for certain situations in order to get a reliable lap statistic
for average grip. This lead to the following function:

### Extracting Combined Acceleration Values for each of the situations above.

1) Overall Combined Acceleration
2) Combined Acceleration when Braking
3) Combined Acceleration when Cornering
4) Combined Acceleration when Accelerating
5) Combined Acceleration (Traction)

Something to work on: 

1) My Combined Acceleration (Traction) and Overall G force looks very similar. Is this supposed to be the case? What is the definition of traction? If it is supposed to be the same, explain why.
2) Now, since I have partitioned the forces based on the situation I can integrate to calculate the overall grip in each situation. Also, toy with the idea if I can use these facts to split the time intervals in the cornering sequences. 

### Plotting tire temperature and pressure 

Something to work on:

1) Figure out why the graph is so weird?? We can see that the column values seem weird too. 
2) I seem to be missing tire pressure data, ask for that. 




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

