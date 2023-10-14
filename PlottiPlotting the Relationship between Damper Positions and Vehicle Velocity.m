I = readtable('FSAE.csv');
I = rmmissing(I);


I(:,67); %outputs the first column as a table
I{:,1}; %outputs the first column as an array

%% Pairwise relation on velocity and damper speed

%Vehicle Velocity against Front Left
figure;
plot(I{:,67},I{:,90},'black')
title("Graph: Front Left Damper Position against Vehicle Velocity")

%Vehicle Velocity against Front Right
figure;
plot(I{:,67},I{:,91},'green')
title("Graph: Front Right Damper Position against Vehicle Velocity")

%Vehicle Velocity against Rear Left
figure;
plot(I{:,67},I{:,92},'blue');
title("Graph: Rear Left Damper Position against Vehicle Velocity")

%Vehicle Velocity against Rear Right
figure;
plot(I{:,67},I{:,93},'red');
title("Graph: Rear Right Damper Position against Vehicle Velocity")


% Left damper against Right Damper (Front)
figure;
plot(I{:,90},I{:,91},'red');
title("Graph: Front Left Damper Position against Front Right Damper Position")

% Left damper against Right Damper (Back)
figure;
plot(I{:,92},I{:,93},'red');
title("Graph: Rear Left Damper Position against Rear Right Damper Position")

% Front Left damper against Rear Left Damper (Back)
figure;
plot(I{:,90},I{:,92},'red');
title("Graph: Front Left Damper Position against Rear Left Damper Position")

% Front Right damper against Rear Right Damper (Back)
figure;
plot(I{:,91},I{:,93},'red');
title("Graph: Front Right Damper Position against Rear Right Damper Position")




%% Superimposing the 4 graphs representing the relationship between the damper and the velocity
figure;
plot(I{:,67},I{:,90},'black',I{:,67},I{:,91},'green',I{:,67},I{:,92},'blue',I{:,67},I{:,93},'red')
title("Graph: Relationship between the 4 damper positions against Vehicle Velocity")

% The following 8 lines were just for me to play with. This shows there are
% 2 ways to superimpose multiple graphs into the same plot

%figure;
%plot(I{:,67},I{:,90},'black')
%hold on 
%plot(I{:,67},I{:,91},'green')
%hold on 
%plot(I{:,67},I{:,92},'blue')
%hold on 
%plot(I{:,67},I{:,93},'red')

%% Learning how the bumpers behave over time

%How front bumpers behave over velocity
surface = [I{:,90} I{:,91} I{:,67}];
figure;
surf(surface);
title("Graph: Relationship between front dampers positions against Vehicle Velocity")

%How front bumpers behave over time
surface = [I{:,90} I{:,91} I{:,1}];
figure;
surf(surface);
title("Graph: Relationship between the front damper positions against Time")

%How rear bumpers behave over velocity
surface = [I{:,92} I{:,93} I{:,67}];
figure;
surf(surface);
title("Graph: Relationship between the rear damper positions against Vehicle Velocity")

%How rear bumpers behave over time
surface = [I{:,92} I{:,93} I{:,1}];
figure;
surf(surface);
title("Graph: Relationship between the rear damper positions against Time")
