%% Scripts Dealing with Cornering


%% Driver Cornering Sequence

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

% We want to see how each variable acts with respect to time. 
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

% Also, now we want to study the relationship between some variables that
% act in tandem.

figure; 
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureFront'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureRear'});
title('Relationship between Front and Rear Brake Pressures against Time');

figure; 
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedFL'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedFR'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedRL'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedRR'});
title('Relationship between Wheel Speed (each tire) against Time');

%Here, I wanted to plot the brake pressure (front & back), steered angle
%and wheel (for each wheel) to identify the turning points. But after
%plotting it, I realise it is hard to do it visually. So, it is better to
%come up with an algorithm to identify the timestamps when the turning is
%occuring and at each interval are we turning left or right. 
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
plot(FSAE{:,'Time'},FSAE{:,'SteeringAngle'});
title('Comparison of Brake Pressure, Wheel Speed (FL) & Throttle Position against Time');

figure;
hold on;
plot(FSAE{:,'Time'},FSAE{:,'ThrottlePosition'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureFront'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureRear'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedFR'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'SteeringAngle'});
title('Chartering of Brake Pressure, Wheel Speed (FR) & Throttle Position against Time');

figure;
hold on;
plot(FSAE{:,'Time'},FSAE{:,'ThrottlePosition'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureFront'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureRear'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedRL'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'SteeringAngle'});
title('Chartering of Brake Pressure, Wheel Speed (RL) & Throttle Position against Time');

figure;
hold on;
plot(FSAE{:,'Time'},FSAE{:,'ThrottlePosition'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureFront'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'BrakePressureRear'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'WheelSpeedRR'});
hold on;
plot(FSAE{:,'Time'},FSAE{:,'SteeringAngle'});
title('Chartering of Brake Pressure, Wheel Speed (RR) & Throttle Position against Time');

% ROOM FOR IMPROVEMENT 1: WHILE THE ABOVE PICTURE IS ALL GOOD, it would be
% better to slice the timeline into pieces where the steered angle changes 
% from 0 and returns to 0, so that we actually identify when the car turns.
% This will allow us to pin-point the intervals the car is turning at so 
% that the above analysis will be more fruitful. For now, there are some 
% issues with the Steering angle; it is all 0, so do the algorithmic design
% first. I guess working on identifying corners should be the first
% business we should be concerned about. 

%% Now, we calculate the slip angle and plot the lateral force against the slip angle

% CALCULATE SLIP ANGLE FOR EACH TIRE

% To calculate the slip angle of the front of the car, alpha_f, we need the
% following data: lateral velocity (v), CG location (a) - [In this case,we
% assume  that laterak velocity is just 1, but FIND OUT ACTUAL CG
% LOCATION], Yawing velocity (r) - [In this case,we assume  that yawing
% velocity is just rotational velocity about the Z axis, from reddit: Yaw
% Rate and Slip Angles - CHECK IF IT IS TRUE], vehicle velocity (V), and
% steer angle front wheels (delta). 

% Slip Angle - Front Left

v = FSAE{:,'GForceLat'};
a = 1;
r = FSAE{:,'AccelerationZ'};
V = FSAE{:,'WheelSpeedFL'};
delta = FSAE{:,'SteeringAngle'};

slip_angle_front_left = [];

for i=1:length(v)
    slip_angle_front_left(i) = v(i)/V(i) + (a*r(i))/V(i) - delta(i);
end

figure;
plot(FSAE{:,'Time'},slip_angle_front_left);
title('Plot of Slip Angle of the Front Left Wheel against Time');
%FIGURE OUT WHY THE OUTPUT IS SO WEIRD

% Slip Angle - Front Right

v = FSAE{:,'GForceLat'};
a = 1;
r = FSAE{:,'AccelerationZ'};
V = FSAE{:,'WheelSpeedFR'};
delta = FSAE{:,'SteeringAngle'};

slip_angle_front_right = [];

for i=1:length(v)
    slip_angle_front_right(i) = v(i)/V(i) + (a*r(i))/V(i) - delta(i);
end

figure;
plot(FSAE{:,'Time'},slip_angle_front_right);
title('Plot of Slip Angle of Front Right Wheel against Time');
%FIGURE OUT WHY THE OUTPUT IS SO WEIRD

%NOTE THAT THE FORMULA FOR SLIP ANGLE IS DIFF FROM FRONT & REAR

% Slip Angle - Rear Left

v = FSAE{:,'GForceLat'};
a = 1; % We use b for the rear formula
b = 1;
r = FSAE{:,'AccelerationZ'};
V = FSAE{:,'WheelSpeedRL'};

slip_angle_rear_left = [];

for i=1:length(v)
    slip_angle_rear_left(i) = v(i)/V(i) + (b*r(i))/V(i) ;
end

figure;
plot(FSAE{:,'Time'},slip_angle_rear_left);
title('Plot of Slip Angle of Rear Left Wheel against Time');
%FIGURE OUT WHY THE OUTPUT IS SO WEIRD

% Slip Angle - Rear Right

v = FSAE{:,'GForceLat'};
a = 1;
b = 1;
r = FSAE{:,'AccelerationZ'};
V = FSAE{:,'WheelSpeedRR'};
delta = FSAE{:,'SteeringAngle'};

slip_angle_rear_right = [];

for i=1:length(v)
    slip_angle_rear_right(i) = v(i)/V(i) + (b*r(i))/V(i);
end

figure;
plot(FSAE{:,'Time'},slip_angle_rear_right);
title('Plot of Slip Angle of Rear Right Wheel against Time');
%FIGURE OUT WHY THE OUTPUT IS SO WEIRD

% Now, after plotting the slip angle against the lateral force for each
% wheel

figure;
plot(slip_angle_front_left,FSAE{:,'GForceLat'});
title('Plot of Slip Angle (FL) vs GForceLat')

figure;
plot(slip_angle_front_right,FSAE{:,'GForceLat'});
title('Plot of Slip Angle (FR) vs GForceLat')

figure;
plot(slip_angle_rear_left,FSAE{:,'GForceLat'});
title('Plot of Slip Angle (RL) vs GForceLat')

figure;
plot(slip_angle_rear_right,FSAE{:,'GForceLat'});
title('Plot of Slip Angle (RR) vs GForceLat');

% Note that the graphs look weird as I have not yet spliced the time. 



%% Plotting the Traction Circle

figure;
plot(FSAE{:,'GForceLat'},FSAE{:,'GForceLong'},'linestyle','none','marker','.');
title('Plot of Longtidinual G vs Lateral G')

% Friction circle diagrams are useful to evaluate if drivers are using the
% full grip potential of the vehicle.

% We now want to calculate the combined acceleration (G). 

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
%Now I will plot the quantile to ensure it is correct
min(first_quantile);
max(first_quantile);
min(second_quantile);
max(second_quantile);
min(third_quantile);
max(third_quantile);

%The values here look all wrong, so fix them and redo the next part. Figure
%out how I can cut the speed of the vehicle into 3 sections. Maybe I can
%create a new speed array, sort the speed, and then cut it into 3 parts) 

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

%% Figure out a way to algorithmically study under and over steer of a vehicle based on section 7.4

%% Ackermann Steering Angle and it's Related Calculations

wheelbase = 60;
R=[];
for i=1:length(FSAE{:,"GForceLat"})
    R(i) = (FSAE{:,"VehicleSpeed"}(i))^2 / FSAE{:,"GForceLat"}(i);
end
ackermann_steering_angle = [];
for i=1:length(FSAE{:,"GForceLat"})
    ackermann_steering_angle(i) =  wheelbase/R(i);
end

figure;
plot(FSAE{:,'Time'},ackermann_steering_angle);
title('Plot Ackermann Steering Angle Against Time')

%CARRY ON MORE CALCULATIONS HERE

%% Yaw Balance
R=[];
for i=1:length(FSAE{:,"GForceLat"})
    R(i) = (FSAE{:,"VehicleSpeed"}(i))^2 / FSAE{:,"GForceLat"}(i);
end

angular_velocity = [];
for i=1:length(FSAE{:,"VehicleSpeed"})
    angular_velocity(i) = FSAE{:,"VehicleSpeed"}(i)/R(i);
end

figure;
plot(FSAE{:,'Time'},angular_velocity);
title("Plot Angular Velocity against Time");


