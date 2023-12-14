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

%%
% At first I used plot(FSAE(:,'Time'),FSAE(:,'BrakePressureFront')); but
% that leads to an error since FSAE is a table, not a matrix. Therefore, we
% use { } brackets instead of ( ). So I use the command like 
% plot(FSAE{:,'Time'},FSAE{:,'ThrottlePosition'});
%% Driver Cornering Sequence

% The car–driver combination goes through various phases when taking a corner. 
% The cornering process basically consists of the following phases: 
% Braking Point to Initial Turn-in Point, . Turn-in Point to Corner,s Apex,
% Corner Exit. The following figures are to illustrates the different events taking place during cornering with the driver
%activity channels (throttle, brake pedal position, and steering wheel).

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

%% Calculating and Plotting Slip Angles

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

figure;
plot(FSAE{:,'GForceLat'},FSAE{:,'GForceLong'},'linestyle','none','marker','.');
title('Plot of Longtidinual G vs Lateral G')

%Now, that we ploted the g-g diagram, we want to analyze the cares 
% cornering potential during transient phases, and this can be done by
% calculating the car's combined G acceleration. It basically represents 
% the radius of the vehicle s instantaneous traction circle


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


% The traction circle and combined G are good working tools for
% investigating the cornering potential of a race car. the vehicle s
% traction circle radius is not constant. It varies with the total vertical
% load acting on the car%s center of gravity. The most important parameter
% here is aerodynamic download, which is speed dependent.Therefore, a
% relationship exists between the vehicle%s speed and its acceleration
% potential, both in a longitudinal and lateral sense. Aerodynamic
% downforce increases proportional to the square of speed, resulting in
% greater cornering and braking potential. Drag has the same relationship
% to speed, so the more speed increases, the less power remains to
% accelerate the vehicle. Now, we want to illustrate this. 

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
