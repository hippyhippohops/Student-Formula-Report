FSAE = readtable('cleaned.csv');

% We will perform all of these analysis on each of the following:
% (i) Damper Position Front Left 
% (ii) Damper Position Front Right 
% (iii) Damper Position Rear Left 
% (iv) Damper Position Rear Right

% Shock Absorber == Damper

%% Shock Absorber Velocity Analysis


% Calculating Spring Force for each dampener

SR = 150; % SR denotes the spring rate. I assume 150 but get the actual no
F_spring_FL = [];
F_spring_FR = [];
F_spring_RL = [];
F_spring_RR = [];

% Spring Force FL
for i=1:length(FSAE{:,"DamperPosFL"})
    F_spring_FL(i) = SR*FSAE{:,"DamperPosFL"}(i);
end

figure;
plot(FSAE{:,"Time"},F_spring_FL);
title("Plotting Damper Position (Front Left) against Time");

% Spring Force FR
for i=1:length(FSAE{:,"DamperPosFR"})
    F_spring_FR(i) = SR*FSAE{:,"DamperPosFR"}(i);
end

figure;
plot(FSAE{:,"Time"},F_spring_FR);
title("Plotting Damper Position (Front Right) against Time");

% Spring Force RL
for i=1:length(FSAE{:,"DamperPosRL"})
    F_spring_RL(i) = SR*FSAE{:,"DamperPosRL"}(i);
end

figure;
plot(FSAE{:,"Time"},F_spring_RL);
title("Plotting Damper Position (Right Left) against Time");

% Spring Force RR
for i=1:length(FSAE{:,"DamperPosRR"})
    F_spring_RR(i) = SR*FSAE{:,"DamperPosRR"}(i);
end

figure;
plot(FSAE{:,"Time"},F_spring_RR);
title("Plotting Damper Position (Rear Right) against Time");

%Calculating damper velocity for each dampener

damper_velocity_FL = gradient(FSAE{:,"DamperPosFL"});
damper_velocity_FR = gradient(FSAE{:,"DamperPosFR"});
damper_velocity_RL = gradient(FSAE{:,"DamperPosRL"});
damper_velocity_RR = gradient(FSAE{:,"DamperPosRR"});

% Calculating the shock absorpber Force

dampening_rate = 0.5; %Arbitrary initial value but change this once I get
% actual values

shock_absorber_force_FL = [];
shock_absorber_force_FR = [];
shock_absorber_force_RL = [];
shock_absorber_force_RR = [];

% Shock Absorber Force (Front Left)
for i=1:length(damper_velocity_FL)
    shock_absorber_force_FL(i) = dampening_rate * damper_velocity_FL(i);
end

figure;
plot(FSAE{:,"Time"},shock_absorber_force_FL);
title("Shock Absorber Force (Front Left) against Time")

% Shock Absorber Force (Front Right)
for i=1:length(damper_velocity_FR)
    shock_absorber_force_FR(i) = dampening_rate * damper_velocity_FR(i);
end

figure;
plot(FSAE{:,"Time"},shock_absorber_force_FR);
title("Shock Absorber Force (Front Right) against Time")

% Shock Absorber Force (Rear Left)
for i=1:length(damper_velocity_RL)
    shock_absorber_force_RL(i) = dampening_rate * damper_velocity_RL(i);
end

figure;
plot(FSAE{:,"Time"},shock_absorber_force_RL);
title("Shock Absorber Force (Rear Left) against Time")

% Shock Absorber Force (Rear Right)
for i=1:length(damper_velocity_RR)
    shock_absorber_force_RR(i) = dampening_rate * damper_velocity_RR(i);
end

figure;
plot(FSAE{:,"Time"},shock_absorber_force_RR);
title("Shock Absorber Force (Rear Right) against Time");

% Plotting the Spring Force and Shock Force of the same wheel

figure;
hold on;
plot(FSAE{:,"Time"},F_spring_FL, 'r');
hold on;
plot(FSAE{:,"Time"},shock_absorber_force_FL, 'b');
title("Spring Force and Shock Force (Front Left) against Time");

figure;
hold on;
plot(FSAE{:,"Time"},F_spring_FR, 'r');
hold on;
plot(FSAE{:,"Time"},shock_absorber_force_FR, 'b');
title("Spring Force and Shock Force (Front Right) against Time");

figure;
hold on;
plot(FSAE{:,"Time"},F_spring_RL, 'r');
hold on;
plot(FSAE{:,"Time"},shock_absorber_force_RL, 'b');
title("Spring Force and Shock Force (Rear Left) against Time");

figure;
hold on;
plot(FSAE{:,"Time"},F_spring_RR, 'r');
hold on;
plot(FSAE{:,"Time"},shock_absorber_force_RR, 'b');
title("Spring Force and Shock Force (Rear Right) against Time");

% Calculate roll angle and roll speed after completing chapters 9 and 10 
% Then, go through pages 258-260.

%% Determining in which Range to Tune the Shock Absorbers

% Plot shock force against vehicle speed

figure;
hold on;
plot(FSAE{:,"VehicleSpeed"},shock_absorber_force_FL);
hold on;
plot(FSAE{:,"VehicleSpeed"},shock_absorber_force_FR);
hold on;
plot(FSAE{:,"VehicleSpeed"},shock_absorber_force_RL);
hold on;
plot(FSAE{:,"VehicleSpeed"},shock_absorber_force_RR);
title("Shock Absorbers (each wheel) against Vehicle Speed");

%% Shock Speed Ranges

for i=1:4
    if i==1
        histogram(shock_absorber_force_FL);
    end
    if i == 2
        histogram(shock_absorber_force_FR);
    end
    if i == 3
        histogram(shock_absorber_force_RL);
    end
    if i ==4 
        histogram(shock_absorber_force_RR);
    end
end
%Figure out a way to plot all 4
