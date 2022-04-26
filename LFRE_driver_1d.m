%% LFRE Examples for One Dimensional States
% The structure of each simulation is similar to that outlined in
% LFRE_driver.m. Refer to the documentation in that file for more details

%% LFRE 1D - Example 1
% Using graph topology from paper
% Formulated with 2 byzantine agents, each on different layers. 
% This works!
clear; clc; close all;

% Build Graph
% Adjacency Matrix
adj = [0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       0 0 0 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       1 1 1 0 0 0 0;
       0 0 0 1 1 1 0];
   
% Layers
layers = [1 2 3; 
          4 5 6; 
          7 -1 -1];

% Byzantine Nodes
% Node 1, Constant output of 0.001
% Node 5, Constant output of 5
byz = [1 5; 0.001 5];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = 1;

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj_1d(x_hat_all, error, byz);

%% LFRE 1D - Example 2
% Using graph topology from paper
% Formulated with 2 byzantine agents, on the same layer.
% This breaks!
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
layers = [1 2 3; 
          4 5 6; 
          7 -1 -1];

% Byzantine Nodes
% Node 1, Constant output of 0.001
% Node 3, Constant output of 5
byz = [1 3; 0.001 5];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = 1;

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj_1d(x_hat_all, error, byz);

%% LFRE 1D - Example 3
% Using hand-constructured graph topology, 5 nodes in each layers 1 and 2,
%   and 2 nodes in layer 3
% Formulated with 2 byzantine agents, on the same layer
% This works! The graph is now robust for F = 2, where 2F + 1 = 5
clear; clc; close all;

% Build Graph
% Adjacency Matrix
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
layers = [1 2 3 4 5; 
          6 7 8 9 10; 
          11 12 -1 -1 -1];

% Byzantine Nodes
% Node 1, Constant output of 0.01
% Node 5, Constant output of 0.01
byz = [1 5; 0.01 0.1];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = 2;

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj_1d(x_hat_all, error, byz);

%% LFRE 1D - Example 4
% Using hand-constructured graph topology, 5 nodes in each layers 1 and 2,
%   and 2 nodes in layer 3
% Formulated with 3 byzantine agents, two on one layer, 1 on another
% This works! The graph is now robust for F = 2, where 2F + 1 = 5. As only
% a maximum of 2 byzantine agents are on each layer, the LFRE algorithm can
% maintain robust state estimation
clear; clc; close all;

% Build Graph
% Adjacency Matrix
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
layers = [1 2 3 4 5; 
          6 7 8 9 10; 
          11 12 -1 -1 -1];

% Byzantine Nodes 
% Node 1, Constant output of 0.01
% Node 3, Constant output of 0.5
% Node 8, Constant output of 1
byz = [1 5 8; 0.01 0.5 1];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = 2;

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj_1d(x_hat_all, error, byz);

%% LFRE 1D - Example 5
% Using hand-constructured graph topology, 5 nodes in each layers 1 and 2,
%   and 2 nodes in layer 3
% Formulated with 3 byzantine agents, each on the same layer
% This breaks! The graph is now robust for F = 2, where 2F + 1 = 5. As only
% a maximum of 2 byzantine agents can be handled on each layer, the LFRE
% algorithm is unable to maintain robust state estimation
clear; clc; close all;

% Build Graph
% Adjacency Matrix
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
layers = [1 2 3 4 5; 
          6 7 8 9 10; 
          11 12 -1 -1 -1];

% Byzantine Nodes 
% Node 1, Constant output of 0.01
% Node 3, Constant output of 0.5
% Node 5, Constant output of 1
byz = [1 3 5; 0.01 0.5 1];

% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = 2;

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj_1d(x_hat_all, error, byz);
