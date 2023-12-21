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

% DO THIS

% CALCULATE SLIP ANGLE FOR EACH TIRE

% CALCULATE SLIP RATIO FOR EACH TIRE

% CALCULATE TIRE TEMPERATURE FOR EACH TIRE

% PLOT TIRE TEMPERATURE AGAINST TIME FOR EACH TIRE

% PLOT Cold tire pressure estimation using the Ideal Gas Law and TPMS data
% against time (formula is given on page 179)

% absolute value of lateral acceleration versus front and rear tire
% temperature - page 185

% Plot Tire workload calculation from tire temperatures against time FOR
% EACH TIRE - page 193
