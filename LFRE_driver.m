%% AE 740 - Multi Agent Control
% Mini Project 4 - Simulating Byzantine-Resilient State Estimation
% Using Local-Filtering based Resilient Estimation (LFRE)
% April 19, 2022

%% Erroneous Implementation Driver 
%(breaks for everything except Luenburger observer, as expected)
clear; clc; close all;

% Build Graph
% Adjacency Matrix - Based on In-Neighbors
adj = [0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       0 0 0 1 1 1 0];
% Layers
layers = [1 2 3; 4 5 6; 7 -1 -1]; % Pad with -1's in order to create rectangular matrix

% Byzantine Nodes - Row 1 = nodes, Row 2 = constant outputs
byz = [1; 0.001];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = size(byz, 2);

% Simulate Estimation
[~, x_hat_all, error] = weighted_avg(adj, layers, byz, A, li, x0, t_max);

% Plotting trajectories and error
plot_traj(x_hat_all, error, byz);

%% LFRE Driver - From Paper 
% (works, as expected)
clear; clc; close all;

% Build Graph
% Adjacency Matrix - Based on In-Neighbors
adj = [0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       0 0 0 1 1 1 0];
% Layers
layers = [1 2 3; 4 5 6; 7 -1 -1]; % Pad with -1's in order to create rectangular matrix

% Byzantine Nodes - Row 1 = nodes, Row 2 = constant outputs
byz = [1; 0.001];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = size(byz, 2);

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj(x_hat_all, error, byz);

%% LFRE Driver - From Paper 
% (with 2 byz, diff layers, works!)
clear; clc; close all;

% Build Graph
% Adjacency Matrix - Based on In-Neighbors
adj = [0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       0 0 0 1 1 1 0];
% Layers
layers = [1 2 3; 4 5 6; 7 -1 -1]; % Pad with -1's in order to create rectangular matrix

% Byzantine Nodes - Row 1 = nodes, Row 2 = constant outputs
byz = [1 5; 0.001 5];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = size(byz, 2);

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj(x_hat_all, error, byz);

%% LFRE Driver - From Paper 
% (with 2 byz, same layer, breaks!)
clear; clc; close all;

% Build Graph
% Adjacency Matrix - Based on In-Neighbors
adj = [0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       0 0 0 1 1 1 0];
% Layers
layers = [1 2 3; 4 5 6; 7 -1 -1]; % Pad with -1's in order to create rectangular matrix

% Byzantine Nodes - Row 1 = nodes, Row 2 = constant outputs
byz = [1 3; 0.001 5];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = size(byz, 2);

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj(x_hat_all, error, byz);

%% LFRE Driver - Hand Selected 
%(for 2 byzantine agents, works!)
clear; clc; close all;

% Build Graph
% Adjacency Matrix - Based on In-Neighbors
adj = [0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       0 0 0 0 0 1 1 1 1 1 0 0;
       0 0 0 0 0 1 1 1 1 1 0 0];
       
% Layers
layers = [1 2 3 4 5; 6 7 8 9 10; 11 12 -1 -1 -1]; % Pad with -1's in order to create rectangular matrix

% Byzantine Nodes - Row 1 = nodes, Row 2 = constant outputs
byz = [1 5; 0.01 0.1];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = size(byz, 2);

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj(x_hat_all, error, byz);

%% LFRE Driver - Hand Selected 
%(for 3 byzantine agents, breaks!)
clear; clc; close all;

% Build Graph
% Adjacency Matrix - Based on In-Neighbors
adj = [0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0;
       0 0 0 0 0 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       1 1 1 1 1 0 0 0 0 0 0 0;
       0 0 0 0 0 1 1 1 1 1 0 0;
       0 0 0 0 0 1 1 1 1 1 0 0];
       
% Layers
layers = [1 2 3 4 5; 6 7 8 9 10; 11 12 -1 -1 -1]; % Pad with -1's in order to create rectangular matrix

% Byzantine Nodes - Row 1 = nodes, Row 2 = constant outputs
byz = [1 3 8; 0.01 0.5 1];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = size(byz, 2);

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj(x_hat_all, error, byz);

%% LFRE Driver - 2D Case
clear; clc; close all;

% Build Graph
% Adjacency Matrix - Based on In-Neighbors
adj = [0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       0 0 0 1 1 1 0];
% Layers
layers = [1 2 3; 4 5 6; 7 -1 -1]; % Pad with -1's in order to create rectangular matrix

% Byzantine Nodes - Row 1 = nodes, Row 2 & 3 = constant outputs for x and y
% respectively
byz = [1; 0.001; 0.001];

% Build Simulation Environment
A = diag([2 2]);
li = 1.5;
x0 = [0.5; 0.5];
t_max = 20;
F = size(byz, 2);

% Simulate Estimation
[~, x_hat_all, error] = LFRE_2D(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj_2D(x_hat_all, error, byz);

%% Local Functions
function [] = plot_traj(x_hat_all, error, byz)
    
    % Create Indexes and Remove Byzantine Agents
    idx = 1:size(x_hat_all, 1);
    idx(byz(1,:)) = [];
    legendStrings = "Node: " + string(idx);
    
    % Plot trajectories
    figure();
    hold on;
    
    for i = idx
        plot(x_hat_all(i, :));
    end
    
    legend(legendStrings, 'location', 'NorthEastOutside');
    xlabel('k');
    ylabel('State');
    title('Trajectory vs. k')

    % Plot errors
    figure();
    hold on;
    
    for i = idx
        plot(error(i,:));
    end
   
    legend(legendStrings, 'location', 'NorthEastOutside');
    xlabel('k');
    ylabel('Error');
    title('Error vs. k')
end

function [] = plot_traj_2D(x_hat_all, error, byz)
    
    % Create Indexes and Remove Byzantine Agents
    idx = 1:size(x_hat_all, 1);
    idx(byz(1,:)) = [];
    legendStrings = "Node: " + string(idx);
    
    % Plot trajectories
    figure();
    hold on;
    
    for i = idx
        plot(x_hat_all(i, :, 1), x_hat_all(i, :, 2));
    end
    
    legend(legendStrings, 'location', 'NorthEastOutside');
    xlabel('k');
    ylabel('State');
    title('Trajectory vs. k')

    % Plot errors
    figure();
    hold on;
    
    for i = idx
        diff = [error(i,:, 1); error(i,:, 2)];
        diff = vecnorm(diff);
        plot(diff);
    end
   
    legend(legendStrings, 'location', 'NorthEastOutside');
    xlabel('k');
    ylabel('Error');
    title('Error vs. k')
end