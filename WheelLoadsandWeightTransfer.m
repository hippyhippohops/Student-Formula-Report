FSAE = readtable('cleaned.csv');

%% Lateral Weight Transfer

W = 200; % W denotes vehicle weight in Kg
delta_W_lat = []; % delta_W_lat denotes total lateral weight transfer in Kg
h_COG = 12; % h_COG denotes center of gravity height from ground in metres
T = 45; % T denotes track weight in metres
G_lat = FSAE{:,'GForceLat'}; % G_lat denotes lateral acceleration at CoG

F = [];
for i=1:length(G_lat)
    F(i) = W * G_lat(i);
end

figure;
plot(FSAE{:,'Time'},F,'k');
title('Force against Time');

for i=1:length(G_lat)
    delta_W_lat(i) = (W * G_lat(i)*h_COG)/T;
end

figure;
plot(FSAE{:,'Time'},delta_W_lat,'k');
title('Total Lateral Weight Transfer against Time');

delta_W_uF = []; %lateral_weight_transfer_unsprung_mass front
delta_W_uR = []; %lateral_weight_transfer_unsprung_mass Rear

% For this, we need the following: (i) W_uF, W_uR (Front/Rear Unsprung
% weight), (ii) G_lat (we already have this), (iii) h_F, h_R (Front, Rear 
% unsprung center of gravity height),(iv) T_F, T_R (Front/rear track width)

W_uF = 13.15;
W_uR = 14.06;
h_F = 9;
h_R = 12; 
T_F = 45;
T_R = 50; 

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

W_sF = 0;
W_sR = 0;
a = 0;
WB = 1;
h_RCF = 0;
h_RCR = 0;
T_F = 0;
T_R = 0;

for i=1:length(G_lat)
    delta_W_gF(i) = (W_sF * G_lat(i)*(a/WB)*h_RCF)/T_F;
end

figure;
plot(FSAE{:,'Time'},delta_W_gF,'k');
title('lateral_geometric_weight_transfer_unsprung_mass front against Time');

for i=1:length(G_lat)
    delta_W_gR(i) = (W_sR * G_lat(i)*((WB-a)/WB)*h_RCR)/T_R;
end

figure;
plot(FSAE{:,'Time'},delta_W_gR,'k');
title('lateral_geometric_weight_transfer_unsprung_mass Rear against Time');
