FSAE = readtable('cleaned.csv');

%% Lateral Weight Transfer

W = 200; % W denotes vehicle weight in Kg
delta_W_lat = []; % delta_W_lat denotes total lateral weight transfer in Kg
h_COG = 12; % h_COG denotes center of gravity height from ground in metres
T = 45; % T denotes track weight in metres
G_lat = FSAE{:,'GForceLat'}; % G_lat denotes lateral acceleration at CoG


%Calculating Reacting Inertial Force
F = [];
for i=1:length(G_lat)
    F(i) = W * G_lat(i);
end

figure;
plot(FSAE{:,'Time'},F,'k');
title('Reacting Inertial Force against Time');


% Calculating Weight Transfer due to Cornering
for i=1:length(G_lat)
    delta_W_lat(i) = (W * G_lat(i)*h_COG)/T;
end

figure;
plot(FSAE{:,'Time'},delta_W_lat,'k');
title('Total Lateral Weight Transfer against Time');
%Once again, this will work out better once I identify the left and the
%right turns. Then, plot those in order to see the lateral weight transfer
%during actual turns. 

delta_W_uF = []; %lateral_weight_transfer_unsprung_mass front
delta_W_uR = []; %lateral_weight_transfer_unsprung_mass Rear

% For this, we need the following: (i) W_uF, W_uR (Front/Rear Unsprung
% weight), (ii) G_lat (we already have this), (iii) h_F, h_R (Front, Rear 
% unsprung center of gravity height),(iv) T_F, T_R (Front/rear track width)

W_uF = 13.15; %Change this after getting actual number
W_uR = 14.06; %Change this after getting actual number
h_F = 9; %Change this after getting actual number
h_R = 12; %Change this after getting actual number
T_F = 45; %Change this after getting actual number
T_R = 50; %Change this after getting actual number

for i=1:length(G_lat)
    delta_W_uF(i) = (W_uF * G_lat(i)*h_F)/T_F;
end

figure;
plot(FSAE{:,'Time'},delta_W_uF,'k');
title('lateral_weight_transfer_unsprung_mass front against Time');

for i=1:length(G_lat)
    delta_W_uR(i) = (W_uR * G_lat(i)*h_R)/T_R;
end

figure;
plot(FSAE{:,'Time'},delta_W_uR,'k');
title('lateral_weight_transfer_unsprung_mass Rear against Time');

delta_W_gF = []; %lateral_geometric_weight_transfer_unsprung_mass front
delta_W_gR = []; %lateral_geometric_weight_transfer_unsprung_mass Rear

% For this, we need the following: (i) W_sF, W_sR (Front/Rear sprung
% weight), (ii) G_lat (we already have this), (iii) a (Distance between
% rear axle centerline and sprung mass center of gravity), (iv) WB
% (wheelbase) (v) h_RCF, h_RCR (Front, Rear roll center height from
% ground),(iv) T_F, T_R (Front/rear track width)

W_sF = 1; %Change this after getting actual number
W_sR = 1; %Change this after getting actual number
a = 1; %Change this after getting actual number
WB = 1; %Change this after getting actual number
h_RCF = 1; %Change this after getting actual number
h_RCR = 1; %Change this after getting actual number
T_F = 1; %Change this after getting actual number
T_R = 1; %Change this after getting actual number

for i=1:length(G_lat)
    delta_W_gF(i) = (W_sF * G_lat(i)*(a/WB)*h_RCF)/T_F;
end

figure;
plot(FSAE{:,'Time'},delta_W_gF,'k');
title('Lateral Geometric Weight Transfer Unsprung Mass Front against Time');

for i=1:length(G_lat)
    delta_W_gR(i) = (W_sR * G_lat(i)*((WB-a)/WB)*h_RCR)/T_R;
end

figure;
plot(FSAE{:,'Time'},delta_W_gR,'k');
title('Lateral Geometric Weight Transfer Unsprung Mass Rear against Time');

% Calculating Sprung Mass Center of Gravity  (h_SCOG)

h_COG = 12; %Change this after getting actual number
h_F = 9; %Change this after getting actual number
h_R = 12; %Change this after getting actual number
h_RCF = 0; %Change this after getting actual number
h_RCR = 0; %Change this after getting actual number
b = 1; % I am not sure what b is. Find out what it is actually
wheel_base = 60; %Change this after getting actual number

h_SCOG = 2*h_COG - (h_F + h_R)/2;

% Calculating h_roll

h_roll = h_SCOG - h_RCF-(b/wheel_base)*(h_RCR-h_RCF);

% Calculating front and rear roll gradient (RG_F and RG_R) in order to
% calculate the suspension roll stiffness, (q)

roll_angle_front = 10; % I am stating this as 10 for the sake of 
% calculations. Change this after getting actual number 
roll_angle_rear = 12; % I am stating this as 10 for the sake of 
% calculations. Change this after getting actual number 

RG_F = gradient(roll_angle_front)/gradient(FSAE{:,"GForceLat"});
RG_R = gradient(roll_angle_rear)/gradient(FSAE{:,"GForceLat"});

q = 0.2; % actual formula is but once I get the actual data add in this 
% actual RG_R/(RG_R+RG_F)

% COME BACK TO THIS ONCE I AM DONE WITH CHAPTER 9

%% Longitudinal Weight Transfer

h_COG = 12; %Change this after getting actual number
wheel_base = 60; %Change this after getting actual number
W = 200; % W denotes vehicle weight in Kg

longitudinal_weight_transfer = [];

for i=1:length(FSAE{:,'GForceLong'})
    longitudinal_weight_transfer(i) = (W*FSAE{:,'GForceLong'}(i)*h_COG)/wheel_base;
end

figure;
plot(FSAE{:,'Time'},longitudinal_weight_transfer);
title("Plotting Longitudinal Weight Transfer against Time");

%% Banking and Grade Effects

% How to calculate banking angle???
