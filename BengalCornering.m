%% An Introduction

% all race cars negotiate corners, and the ability to do so as fast as
% possible minimizes lap time. This chapter covers the physics involved in
% cornering and how the cornering capability of a race car can be
% investigated using data from the logging system.


%% Driver Cornering Sequence

% The car–driver combination goes through various phases when taking a
% corner. The cornering process basically consists of the following phases:
% Braking Point to Initial Turn-in Point, . Turn-in Point to Corner,s Apex,
% Corner Exit. The following figures are to illustrates the different
% events taking place during cornering with the driver activity channels
% (throttle, brake pedal position, and steering wheel).

%Picking out the relevant data we want
FSAE = readtable('cleaned.csv');
FSAE(:,'Time');
FSAE(:,'ThrottlePosition');
FSAE(:,'BrakePressureFront');
FSAE(:,'BrakePressureRear');
FSAE(:,'WheelSpeedFL');
FSAE(:,'WheelSpeedFR');
FSAE(:,'WheelSpeedRL');
FSAE(:,'WheelSpeedRR');
FSAE(:,'SteeringAngle');
% At first I used plot(FSAE(:,'Time'),FSAE(:,'BrakePressureFront')); but
% that leads to an error since FSAE is a table, not a matrix. Therefore, we
% use { } brackets instead of ( ). So I use the command like 
% plot(FSAE{:,'Time'},FSAE{:,'ThrottlePosition'});

figure;
hold on;
plot(FSAE{:,'Time'},FSAE{:,'ThrottlePosition'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureFront'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureRear'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedFL'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedFR'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedRL'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedRR'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'SteeringAngle'});
title('Comparison of Brake Pressure, Wheel Speed & Throttle Position against Time');

figure;
plot(FSAE{:,'Time'},FSAE{:,'ThrottlePosition'});
title('Plot Throttle Position against Time');
figure;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureFront'});
title('Plot Brake Pressure Front against Time');
figure;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureRear'});
title('Plot Brake Pressure Rear against Time');
figure;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedFL'});
title('Plot Wheel Speed FL against Time');
figure;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedFR'});
title('Plot Wheel Speed FR against Time');
figure;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedRL'});
title('Plot Wheel Speed RL against Time');
figure;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedRR'});
title('Plot Wheel Speed RR against Time');
figure;
plot(FSAE{:,'Time'},FSAE{:,'SteeringAngle'});
title('Plot Steering Angle against Time');

% ROOM FOR IMPROVEMENT 1: WHILE THE ABOVE PICTURE IS ALL GOOD, it would be
% better to slice the timeline into pieces where the steered angle changes 
% from 0 and returns to 0, so that we actually identify when the car turns.
% This will allow us to pin-point the intervals the car is turning at so 
% that the above analysis will be more fruitful. For now, there are some 
% issues with the Steering angle; it is all 0, so do the algorithmic design
% first. I guess working on identifying corners should be the first
% business we should be concerned about. 

% ROOM FOR IMPROVEMENT 2: Find a way to calculate slip angle, then we can 
% plot slip angle against lateral force for each wheel, this will allow us 
% to identify the linear range, transitional range and frictional range 
% (page 141). 

%The formula is derived from Race Car Vehicular Dynamics and I took this
%from page 148

slip_angle = [];

%In order to calculate slip angle I need lateral velocity first i guess

%Calculating Front Left Slip Angle


for i=1:length(FSAE{:,'Time'});
    %we will calculate the slip angle of each vehicle at each time
    %instance, store the value and then plot it
    0;
end

%% Plotting the Traction Circle

% How Longitudinal and Lateral acceleration shows cornering 
% 1) When longitudinal acceleration is negative while lateral G is at zero, 
% the car is braking in a straight line.
% 2) At the point where the longitudinal deceleration is still more or less
% the same, but the car has started to build up lateral Gs, the driver is 
% braking into the corner.
% 3) Then, Maximum lateral acceleration is reached and  the longitudinal 
% deceleration is reduced to almost zero Gs.
% 4) Lastly, when the car accelerating out of the corner, it is indicated 
% with positive longitudinal acceleration and decreasing lateral Gs.

% We can plot the Longitudinal and Lateral acceleration in a X-Y plot. This
% is known as the "traction circle.
% NOTE THAT A tire’s maximum grip in any direction depends on the vertical 
% load to which it is being subjected. This implies that the size of the 
% traction circle is not constant. In a high-downforce corner, the circle's
% diameter is larger than in a slow corner. 
figure;
plot(FSAE{:,'GForceLat'},FSAE{:,'GForceLong'},'linestyle','none','marker','.');
title('Plot of Longtidinual G vs Lateral G')

% Friction circle diagrams are useful to evaluate if drivers are using the
% full grip potential of the vehicle.

% ROOM FOR IMPROVEMENT 3: Compare traction circle for different drivers 
% page 144 from data analysis book

% Now, that we ploted the g-g diagram, we want to analyze the cares 
% cornering potential during transient phases, and this can be done by
% calculating the car's combined G acceleration. It basically represents 
% the radius of the vehicle s instantaneous traction circle. STUDY HOW THIS
% IS DONE using this 2 tools!!!

G_comb = [];

for i=1:length(FSAE{:,'GForceLat'});
    G_comb(i) = sqrt(FSAE{i,'GForceLat'}^2+FSAE{i,'GForceLong'}^2);
end

figure;
hold on;
plot(FSAE{:,'Time'},FSAE{:,'GForceLat'}, 'r');
hold on;
plot(FSAE{:,'Time'},FSAE{:,'GForceLong'}, 'b');
hold on;
plot(FSAE{:,'Time'},G_comb, 'k');
hold on;

%% EFFECTS OF SPEED


% The traction circle and combined G are good working tools for
% investigating the cornering potential of a race car. The vehicle s
% traction circle radius is not constant. It varies with the total vertical
% load acting on the car%s center of gravity. The most important parameter
% here is aerodynamic download, which is speed dependent.Therefore, a
% relationship exists between the vehicle%s speed and its acceleration
% potential, both in a longitudinal and lateral sense. 

% Aerodynamic downforce increases proportional to the square of speed,
% resulting in greater cornering and braking potential. Drag has the same
% relationship to speed, so the more speed increases, the less power
% remains to accelerate the vehicle. Now, we want to illustrate this.

%First, we use the statistics summary from our data cleaning done earlier.
% We know that the following summary for the vehicle speed

max(FSAE{:,'VehicleSpeed'}); % Output = 76.4000
min(FSAE{:,'VehicleSpeed'}); % Output = -0.1000

%We split the data into 3 speed ranges for the car

quantile(FSAE{:,'VehicleSpeed'},[ 0.33 0.66 ]);%Output = 27.1500   42.2000

%Now, we want to get the corresponding indices so that the data can be
%split.

first_quantile = find(FSAE{:,'VehicleSpeed'} < 27.1500);
second_quantile = find(FSAE{:,'VehicleSpeed'} < 42.2000);
second_quantile = find(second_quantile > 27.1500);
third_quantile = find(FSAE{:,'VehicleSpeed'} > 42.2000);
length(first_quantile); % 24915
length(second_quantile); % 49695
length(third_quantile); % 25554

first_quantile_long_G = FSAE{:,'GForceLong'}(first_quantile);
second_quantile_long_G = FSAE{:,'GForceLong'}(second_quantile);
third_quantile_long_G = FSAE{:,'GForceLong'}(third_quantile);

first_quantile_lat_G = FSAE{:,'GForceLat'}(first_quantile);
second_quantile_lat_G = FSAE{:,'GForceLat'}(second_quantile);
third_quantile_lat_G = FSAE{:,'GForceLat'}(third_quantile);

figure;
plot(first_quantile_lat_G,first_quantile_long_G,'linestyle','none','marker','.');
title('Plot of Longtidinual G vs Lateral G (First Quantile Speed)');

figure;
plot(second_quantile_lat_G, second_quantile_long_G,'linestyle','none','marker','.');
title('Plot of Longtidinual G vs Lateral G (Second Quantile Speed)');

figure;
plot(third_quantile_lat_G,third_quantile_long_G, 'linestyle','none','marker','.');
title('Plot of Longtidinual G vs Lateral G (Third Quantile Speed)');

%Edit the graph more to look like what it does in Data Analysis Book Page
%148

% Now, let's plot G Force Lateral against each vehicle speed

figure;
hold on;
plot(FSAE{:,'WheelSpeedFL'},FSAE{:,'GForceLat'}, 'r');
hold on;
plot(FSAE{:,'WheelSpeedFL'},FSAE{:,'GForceLong'}, 'b');
title('Plot showing WheelSpeedFL against GForceLat and GForceLong')

figure;
hold on;
plot(FSAE{:,'WheelSpeedFR'},FSAE{:,'GForceLat'}, 'r');
hold on;
plot(FSAE{:,'WheelSpeedFR'},FSAE{:,'GForceLong'}, 'b');
title('Plot showing WheelSpeedFR against GForceLat and GForceLong')

figure;
hold on;
plot(FSAE{:,'WheelSpeedRL'},FSAE{:,'GForceLat'}, 'r');
hold on;
plot(FSAE{:,'WheelSpeedRL'},FSAE{:,'GForceLong'}, 'b');
title('Plot showing WheelSpeedRL against GForceLat and GForceLong')

figure;
hold on;
plot(FSAE{:,'WheelSpeedRR'},FSAE{:,'GForceLat'}, 'r');
hold on;
plot(FSAE{:,'WheelSpeedRR'},FSAE{:,'GForceLong'}, 'b');
hold on;
title('Plot showing WheelSpeedRR against GForceLat and GForceLong')

%Edit the graph more to look like what it does in Data Analysis Book Page
%150 & 151

%% Studying Steering

%DEFINITIONS

% Vehicle balance is commonly described by the terms understeer, neutral 
% steer, and oversteer. In a simple world, understeer causes the vehicle to
% "push" its front tires to the outside of the corner, whereas oversteer 
% causes the rear axle to break out. Neutral steer is the situation where 
% neither understeer nor oversteer are present. 

% Understeer and oversteer are vehicle dynamics terms used to describe the
% sensitivity of a vehicle to steering. Oversteer is what occurs when a car
% turns (steers) by more than the amount commanded by the driver.
% Conversely, understeer is what occurs when a car steers less than the
% amount commanded by the driver.

% HOW TO ANALYSE STEERING

% The most common way to analyze cornering balance is to look at the input
% the vehicle acquires from the driver as a reaction to a handling problem.
% Steering movement and pedal activities can reveal much about the handling
% of the car. Steering angle, throttle position, and lateral acceleration
% are the channels to watch.



figure;
plot(FSAE{:,'Time'},FSAE{:,'ThrottlePosition'});
title('Throttle Position against Time');
figure;
plot(FSAE{:,'Time'},FSAE{:,'SteeringAngle'}); 
title('Steering Angle against Time');
figure;
plot(FSAE{:,'Time'},FSAE{:,'GForceLat'});
title('GForceLat against Time');

% FOR OVERSTEERING

% The driver counters oversteer by reducing the steering angle. The gray
% line in the steering graph indicates approximately how the steering
% movement should have been addressed. Steering corrections for oversteer
% very often are accompanied by little dips in the lateral G graph,
% parallel to the steering wheel movement. In general, lateral acceleration
% levels are lower than expected. Oversteer creates a rough lateral G graph
% as the car loses and regains grip. Variations smaller than 0.25 G and of
% a shorter duration than 0.3 sec are caused by irregularities in the track
% surface. Lateral G variations due to oversteer are confirrmed in the
% steering angle graph.

% Another oversteer indicator is when the vehicle is not willing to accept
% full throttle. In this example, the driver waits until the corner is
% completed before applying full throttle to avoid the rear stepping out.

% FOR UNDERSTEERING

% Understeer is a little more dif!cult to diagnose. Characteristic to
% understeer is the excessive steering angle. When on corner entry the
% steering angle gradually keeps increasing, we re dealing with understeer.
% In this case the steering angle will often peak before the lateral G
% trace. Mid-corner and corner exit understeer generally shows a gradual
% decrease in the lateral G trace, while steering angle increases. In this
% case maximum lateral acceleration will peak before the maximum steering
% angle. Typical of mid-corner and corner exit understeer is the reluctance
% of the car to accept full throttle.


