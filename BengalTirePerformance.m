FSAE = readtable('cleaned.csv');

%% Estimating Grip Levels of a tire

% Here, the combined acceleration channel will be used to give us a
% statistical representation of the grip developed by the tires of the car
% or the portion of this grip being used by the driver.

% when we plot the combined acceleration channel against distance, the
% larger the area beneath the resulting plot, the more grip the vehicle
% developed on the track or section of the track being looked at.

% We could integrate the combined acceleration channel in function of lap
% distance to obtain a lap statistic that is a measure of the amount of
% grip developed during a single lap. The accuracy of this calculation
% would be greatly dependent on the accuracy of the lap distance channel.
% Simply taking the average value of the combined acceleration channel per
% lap would be a better solution.

% The problem with this approach would be that we can t compare results
% between different tracks as the number of high- and low-speed corners and
% the amount of straights would skew the average combined acceleration
% values
 
% We will therefore need to gate the combined acceleration channel for
% certain situations in order to get a reliable lap statistic for average
% grip. Through clever signal gating, we can assess objective numbers to
% the grip the car is producing in different situations, namely:
% - Overall Grip
% - Braking Grip 
% - Acceleration Grip
% - Cornering Grip
% - Aerodynamic Grip

% Let's calculate the combined acceleration 

G_comb = [];

for i=1:length(FSAE{:,'GForceLat'});
    G_comb(i) = sqrt(FSAE{i,'GForceLat'}^2+FSAE{i,'GForceLong'}^2);
end

%Plotting the combined acceleration 
figure;
plot(FSAE{:,'Time'},G_comb, 'k');

% We now need to set the boundaries to determine these situation. To
% calculate an overall grip factor, we take the combined acceleration over
% the course of a lap but only display situations that are grip limited.
% This way, we can exclude straight-line acceleration where engine power
% and aerodynamic drag are the limiting factors in the acceleration of the
% car. 

% Overall Grip- > 1.0

G_overall_grip = G_comb;
for i=1:length(G_comb)
    if G_comb(i) < 1.0
        G_overall_grip(i) = 0.0;
    end
end

figure;
plot(FSAE{:,'Time'},G_overall_grip, 'r');

% Cornering Grip- > 1.0

GForceLat_cornering = FSAE{:,'GForceLat'};
GForceLong_cornering = FSAE{:,'GForceLong'};

for i=1:length(GForceLat_cornering)
    if GForceLat_cornering(i) < 0.5
        GForceLat_cornering(i) = 0;
        GForceLong_cornering(i) = 0;
    end
end

G_comb_cornering = [];

for i=1:length(GForceLat_cornering);
    G_comb_cornering(i) = sqrt(GForceLat_cornering(i)^2+GForceLong_cornering(i)^2);
end

figure;
plot(FSAE{:,'Time'},G_comb_cornering, 'g');

% Braking Grip- kongtindual G > 1.0

GForceLat_braking = FSAE{:,'GForceLat'};
GForceLong_braking = FSAE{:,'GForceLong'};

for i=1:length(GForceLat_braking)
    if GForceLat_braking(i) < 0.5
        if GForceLong_braking(i) < 0.0
            GForceLat_cornering(i) = 0;
            GForceLong_cornering(i) = 0;
        end
    end
end

G_comb_braking = [];

for i=1:length(GForceLat_braking);
    G_comb_braking(i) = sqrt(GForceLat_braking(i)^2+GForceLong_braking(i)^2);
end

figure;
plot(FSAE{:,'Time'},G_comb_braking, 'b'); 
% This is exactly the same as the first figure
% Is this reasonable? 

% What is the lap distance/lap time? How can I plot Overall grip over
% laptime?

%% Working with Tire Pressure Monitoring System 

% We will first plot tire temperature over time for each tire - WHY IS IT
% ALL WEIRD

%Plotting tire temperature Front Left against Time 
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFL"},'r');

%Plotting tire temperature Front Right against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFR"},'g');

%Plotting tire temperature Rear Left against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRL"},'b');

%Plotting tire temperature Rear Right against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRR"},'k');

% We will first plot tire temperature (Inner) over time for each tire

%Plotting tire temperature Front Left against Time 
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFLInner"},'r');

%Plotting tire temperature Front Right against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFRInner"},'g');

%Plotting tire temperature Rear Left against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRLInner"},'b');

%Plotting tire temperature Rear Right against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRRInner"},'k');

% We will first plot tire temperature (Center) over time for each tire

%Plotting tire temperature Front Left against Time 
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFLCentre"},'r');

%Plotting tire temperature Front Right against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFRCentre"},'g');

%Plotting tire temperature Rear Left against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRLCentre"},'b');

%Plotting tire temperature Rear Right against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRRCentre"},'k');

% We will first plot tire temperature (Outer) over time for each tire

%Plotting tire temperature Front Left against Time 
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFLOuter"},'r');

%Plotting tire temperature Front Right against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFROuter"},'g');

%Plotting tire temperature Rear Left against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRLOuter"},'b');

%Plotting tire temperature Rear Right against Time
figure;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRROuter"},'k');

%We can see that tire temperature is missing - so we will approximate the
%tire temperature using the formula given in page 182

% In order to utilise that formula, we need to calculate tire slip angle
% and tire slip ratio, we also need to assume track temperature, Thermal
% conductivity between tire and air, and Thermal conductivity between tire
% and track surface

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


% CALCULATE SLIP RATIO FOR EACH TIRE

% SAE J670 defines the slip ratio of a tire as SR=(Ω − Ω0)/Ω0. In this
% equation, Ω is the angular velocity of the driven wheel and Ω0 is the
% angular velocity of the free-rolling situation. So, first we need to
% calculate Ω0 is the angular velocity of the free-rolling situation, which
% is expressed as v=ωR. In this equation, R is the object's radius and v is
% its linear velocity.

% Slip ratio for front left wheel

angular_velocity_freerolling_FL = [];
wheel_radius_FL = 12; 
%SEE IF THIS IS ACTUALLY CORRECT? AS TIRE DEGRADES RADIUS CHANGES. SO HOW
%DO I KEEP TRACK OF THIS?
linear_velocity = FSAE{:,'WheelSpeedFL'};
for i=1:length(linear_velocity)
    angular_velocity_freerolling_FL(i) = linear_velocity(i)/wheel_radius_FL;
end

slip_ratio_FL = [];
for i=1:length(linear_velocity)
    slip_ratio_FL(i) = (linear_velocity(i)-angular_velocity_freerolling_FL(i))/angular_velocity_freerolling_FL(i);
end

figure;
plot(FSAE{:,'Time'},slip_ratio_FL);
title('Slip Ratio of Front Left Wheel against Time');

% Slip ratio for front right wheel

angular_velocity_freerolling_FR = [];
wheel_radius_FR = 12; 
%SEE IF THIS IS ACTUALLY CORRECT? AS TIRE DEGRADES RADIUS CHANGES. SO HOW
%DO I KEEP TRACK OF THIS?
linear_velocity = FSAE{:,'WheelSpeedFR'};
for i=1:length(linear_velocity)
    angular_velocity_freerolling_FR(i) = linear_velocity(i)/wheel_radius_FR;
end

slip_ratio_FR = [];
for i=1:length(linear_velocity)
    slip_ratio_FR(i) = (linear_velocity(i)-angular_velocity_freerolling_FR(i))/angular_velocity_freerolling_FR(i);
end

figure;
plot(FSAE{:,'Time'},slip_ratio_FR);
title('Slip Ratio of Front Right Wheel against Time');

% Slip ratio for rear left wheel

angular_velocity_freerolling_RL = [];
wheel_radius_RL = 12; 
%SEE IF THIS IS ACTUALLY CORRECT? AS TIRE DEGRADES RADIUS CHANGES. SO HOW
%DO I KEEP TRACK OF THIS?
linear_velocity = FSAE{:,'WheelSpeedRL'};
for i=1:length(linear_velocity)
    angular_velocity_freerolling_RL(i) = linear_velocity(i)/wheel_radius_RL;
end

slip_ratio_RL = [];
for i=1:length(linear_velocity)
    slip_ratio_RL(i) = (linear_velocity(i)-angular_velocity_freerolling_RL(i))/angular_velocity_freerolling_RL(i);
end

figure;
plot(FSAE{:,'Time'},slip_ratio_RL);
title('Slip Ratio of Rear Left Wheel against Time');

% Slip ratio for Rear right wheel

angular_velocity_freerolling_RR = [];
wheel_radius_RR = 12; 
%SEE IF THIS IS ACTUALLY CORRECT? AS TIRE DEGRADES RADIUS CHANGES. SO HOW
%DO I KEEP TRACK OF THIS?
linear_velocity = FSAE{:,'WheelSpeedRR'};
for i=1:length(linear_velocity)
    angular_velocity_freerolling_RR(i) = linear_velocity(i)/wheel_radius_RR;
end

slip_ratio_RR = [];
for i=1:length(linear_velocity)
    slip_ratio_RR(i) = (linear_velocity(i)-angular_velocity_freerolling_RR(i))/angular_velocity_freerolling_RR(i);
end

figure;
plot(FSAE{:,'Time'},slip_ratio_RR);
title('Slip Ratio of Rear Right Wheel against Time');


% CALCULATE TIRE TEMPERATURE FOR EACH TIRE



% PLOT TIRE TEMPERATURE AGAINST TIME FOR EACH TIRE

% PLOT Cold tire pressure estimation using the Ideal Gas Law and TPMS data
% against time (formula is given on page 179)

% absolute value of lateral acceleration versus front and rear tire
% temperature - page 185

% Plot Tire workload calculation from tire temperatures against time FOR
% EACH TIRE - page 193


