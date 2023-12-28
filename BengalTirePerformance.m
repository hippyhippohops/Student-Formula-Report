FSAE = readtable('cleaned.csv');

%% Estimating Grip Levels of a tire through out the "race"

G_comb = [];

for i=1:length(FSAE{:,'GForceLat'});
    G_comb(i) = sqrt(FSAE{i,'GForceLat'}^2+FSAE{i,'GForceLong'}^2);
end
%I realised that Trip Distance doesn't change , so is there another way to
%do this. Also,  find out if it is actually possible for me to calculate
%area under the curve this way since  G_comb is not a function of distance.
% So find out if I can make it that way.
%So, figure out why the distance data is so weird
grip_level = cumtrapz(FSAE{:,"TripDistance"}, G_comb)

%% Splitting the Grip into different portions of the race: Braking, Acc, Cornering & Aerodynamic

% Let's calculate the combined acceleration first to get a feel for the
% data

G_comb = [];

for i=1:length(FSAE{:,'GForceLat'});
    G_comb(i) = sqrt(FSAE{i,'GForceLat'}^2+FSAE{i,'GForceLong'}^2);
end

%Plotting the combined acceleration 
figure;
plot(FSAE{:,'Time'},G_comb, 'k');
title("Combined G Force against Time");

% Overall Grip

% Here, we will plot overall grip when combination acceleration > 1.0. 
% However, note that this is customisable. 

G_overall_grip = G_comb;
for i=1:length(G_comb)
    if G_comb(i) < 1.0
        G_overall_grip(i) = 0.0;
    end
end

figure;
plot(FSAE{:,'Time'},G_overall_grip, 'r'); % x axis is supposed to be distance.
title("Overall Combined Acceleration against Time");
%So, figure out why the distance data is so weird

% Cornering Grip

GForceLat_cornering = FSAE{:,'GForceLat'};
GForceLong_cornering = FSAE{:,'GForceLong'};

% Here, we define cornering conditions as when lat G > 0.5. Thus, we want
% to negate all the G forces when lat G <0.5. Hence, the following
% function:
for i=1:length(GForceLat_cornering)
    if GForceLat_cornering(i) < 0.5
        GForceLat_cornering(i) = 0;
        GForceLong_cornering(i) = 0;
    end
end

% Once again, note that we can define the cornering condition however we
% want. 

G_comb_cornering = [];

for i=1:length(GForceLat_cornering);
    G_comb_cornering(i) = sqrt(GForceLat_cornering(i)^2+GForceLong_cornering(i)^2);
end

figure;
plot(FSAE{:,'Time'},G_comb_cornering, 'g');
title("Combined Acceleration when Cornering against Time")

% Braking Grip

GForceLat_braking = FSAE{:,'GForceLat'};
GForceLong_braking = FSAE{:,'GForceLong'};

% Here, we define braking conditions as when long G < -1.0 . Thus, we want
% to negate all the G forces when long G > -1.0. Hence, the following
% function:
for i=1:length(GForceLat_braking)
    if GForceLong_braking(i) > -1.0
        GForceLong_braking(i) = 0;
        GForceLat_braking(i) = 0;
    end
end

G_comb_braking = [];

for i=1:length(GForceLat_braking);
    G_comb_braking(i) = sqrt(GForceLat_braking(i)^2+GForceLong_braking(i)^2);
end

figure;
plot(FSAE{:,'Time'},G_comb_braking, 'b'); 
title("Combined Acceleration when Braking against Time")

% Traction Grip
GForceLat_traction = FSAE{:,'GForceLat'};
GForceLong_traction = FSAE{:,'GForceLong'};

% Here, we define traction conditions as when long G > 0 and at the same
% time the lat G > 0.5. Thus, we want to negate all the G forces when long
% G < 0 and lat G <0.5. Hence, the following function:
for i=1:length(GForceLat_traction)
    if GForceLat_traction(i) < 0.5
        if GForceLong_traction(i) < 0.0
            GForceLat_traction(i) = 0;
            GForceLong_traction(i) = 0;
        end
    end
end

G_comb_traction = [];

for i=1:length(GForceLat_traction);
    G_comb_traction(i) = sqrt(GForceLat_traction(i)^2+GForceLong_traction(i)^2);
end

figure;
plot(FSAE{:,'Time'},G_comb_traction, 'k');
title("Combined Acceleration (Traction) against Time")
% My Combined Acceleration (Traction) and Overall G force looks very
% similar. Is this supposed to be the case? What is the definition of
% traction? If it is supposed to be the same, explain why. 

% TO_DO LIst next: Now, since I have partitioned the forces based on the
% situation I can integrate to calculate the overall grip in each situation
% Also, toy with the idea if I can use these facts to split the time
% intervals in the cornering sequences. 

%% Working with Tire Pressure Monitoring System 

% We will first plot tire temperature over time and compare their relation 
figure;
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFL"},'r');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFR"},'g');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRL"},'b');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRR"},'k');
title('Tire Temperature (Overall) against Time');

% We will first plot tire temperature (Inner) over time and compare their
% relation
figure;
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFLInner"},'r');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFRInner"},'g');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRLInner"},'b');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRRInner"},'k');
title('Tire Temperature (Inner) against Time');

% We will first plot tire temperature (Center) over time and compare their
% relation

%Plotting tire temperature Front Left against Time 
figure;
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFLCentre"},'r');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFRCentre"},'g');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRLCentre"},'b');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRRCentre"},'k');
title('Tire Temperature (Center) against Time');

% We will first plot tire temperature (Outer) over time and compare their
% relation

%Plotting tire temperature Front Left against Time 
figure;
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFLOuter"},'r');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempFROuter"},'g');
hold on;
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRLOuter"},'b');
hold on; 
plot(FSAE{:,"Time"},FSAE{:,"TyreTempRROuter"},'k');
title('Tire Temperature (Outer) against Time');

%Figure out why the graph is so weird?? We can see that the column values
%seem weird too. 

%I seem to be missing tire pressure data, ask for that. 


