%% LFRE Examples for Two Dimensional States
% The structure of each simulation is similar to that outlined in
% LFRE_driver.m. Refer to the documentation in that file for more details

%% LFRE 2D - Example 1
% Using graph topology from paper
% Formulated with 1 byzantine source node
% This works! This is the same simulation as outlined in the paper, but now
% with a two-dimensional state
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
% Node 1, constant output of [0.001; 0.001]
byz = [1; 0.001; 0.001];

% Build Simulation Environment
A = diag([2 2]); % Diagonal state matrix
li = 1.5;
x0 = [0.5; 0.5]; % Initial state [0.5; 0.5]
t_max = 20;
F = 1;

% Simulate Estimation
% The LFRE function is now updated to work with two-dimensional states
[~, x_hat_all, error] = LFRE_2d(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
% The plotting function is now updated to work with two-dimensional states
plot_traj_2d(x_hat_all, error, byz);
