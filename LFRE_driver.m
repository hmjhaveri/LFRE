%% Byzantine-Resilient Distributed Observers for LTI Systems (Mitra et. al., 2019)
% Originally Implemented in MATLAB: April 2022

% The follow sections implement the simulation results first published in
% Mitra et. al. 2019. The third section reproduces the erroneous weighted
% average filtering algorithm used in the paper, and the fourth section 
% section reproduces the results from LFRE filtering. Both sections utilize
% the same graph communication topology and simulation parameters, which 
% are implemented, respectively, in the first and section section

%% Graph Structure
% Build Graph using Adjacency Matrix and Layers Matrix
clear;

% Adjacency Matrix
% Each row represents a node, and values of 1 represent in-neighbors.
% In this example, nodes 1-3 are in neighbors for nodes 4-6. Nodes 1-3 have
% no in-neighbors as they are source nodes.
adj = [0 0 0 0 0 0 0;  % Node 1
       0 0 0 0 0 0 0;  % Node 2
       0 0 0 0 0 0 0;  % Node 3
       1 1 1 0 0 0 0;  % Node 4
       1 1 1 0 0 0 0;  % Node 5
       1 1 1 0 0 0 0;  % Node 6
       0 0 0 1 1 1 0]; % Node 7
   
% Layers matrix 
% Each row represents increasing layers of a Mode Estimation Directed
% Acyclic Graph (MEDAG). Each row will contain the IDs of the nodes that 
% are present in the corresponding layer in the graph.
% The layers matrix will be N x M, where N is the number of layers, and M 
% is the maximal number of nodes in any given layer. If a layer has less 
% than M nodes, the row is padded with -1's. This is done under the 
% assumtion that node IDs are natural numbers.
layers = [1 2 3;    % Layer 1
          4 5 6;    % Layer 2
          7 -1 -1]; % Layer 3

% Byzantine Nodes
% The first row contains the IDs of all Byzantine Nodes, and the subsequent
% rows contain the constant output of the corresponding (i.e. same column)
% node.
% For this simulation, only one node is indentified as byzantine. In the
% one-dimensional case, the byzantine matrix will be 2 x B, where B
% represents the total number of Byzantine nodes in the graph
byz = [1; 0.001];

%% Simulation Parameters
% Build Simulation Environment
A = 2;
li = 1.5;
x0 = 0.5;
t_max = 20;
F = size(byz, 2);

%% Erroneous Implementation Using Weighted Averaging - From Paper 
% As expected, the error for all nodes except the regular source nodes
% diverges
clc; close all;

% Simulate Estimation
[~, x_hat_all, error] = weighted_avg(adj, layers, byz, A, li, x0, t_max);

% Plotting trajectories and error
plot_traj_1d(x_hat_all, error, byz);

%% LFRE - From Paper 
% Now, using the LFRE algorithm, the errors of all non-Byzantine nodes
% converges to 0
clc; close all;

% Simulate Estimation
[~, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F);

% Plotting trajectories and error
plot_traj_1d(x_hat_all, error, byz);
