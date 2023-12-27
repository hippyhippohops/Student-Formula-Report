# Student-Formula-Report

This repository contains the findings and the code I developed to perform statistical analysis and study the vehicular dynamics on the Bengal 2023. This is a document to keep track of the Bengal Data Analysis. The purpose of this is to keep track of my analysis and also showcase what I have done, and gathering what I have learnt from the data set. Here are the following scripts are what they do.

# Cornering Sequence Script

The cornering sequence script contains the following plots/functions:

## Function to visualise the relationship between Front and Rear Brake Pressures against Time

## Function to visualise the relationship between the speed of the Four Wheels against Time

## Plot the brake pressure (front & back), steered angle and wheel (for each wheel) to identify the turning points

Turns out this is not a good approach. I realise it is hard to do it visually. So, it is better to come up with an algorithm to identify the timestamps when the turning is occuring and at each interval are we turning left or right. So, add this to my To-Do List!!

## Function to calculate the Slip Angle of Each Wheel, and then visualise this. We also plot this against the lateral acceeleration

Again, turns out this is not a good approach. Note that the graphs look weird as I have not yet spliced the time. So, I should figure out a way to slice the timestamps into when the turning is occuring and then study the slip angle against the lateral acceleration.

## Plot the traction circle, the "g-g" plot and then the combined acceleration

## Study the effects of speed on the lateral acceleration

Again, turns out this is not a good approach. The values here look all wrong, so fix them and redo the next part. Figure out how I can cut the speed of the vehicle into 3 sections. Maybe I can create a new speed array, sort the speed, and then cut it into 3 parts). 

## Ackermann Steering Angle and it's Related Calculations

## Calculating Yaw Balance



# Tire Performance Script

# Wheel Loads and Weight Transfer Script 

# To-Do/Improvement List

- come up with an algorithm to identify the timestamps when the turning is occuring and at each interval are we turning left or right (Cornering Seq - 3)

- So, I should figure out a way to slice the timestamps into when the turning is occuring and then study the slip angle against the lateral acceleration (Cornering Seq - 4)

-  The values here look all wrong, so fix them and redo the next part. Figure out how I can cut the speed of the vehicle into 3 sections. Maybe I can create a new speed array, sort the speed, and then cut it into 3 parts (Cornering seq - 6)

-  Add in all the respective images once I finalised the code

