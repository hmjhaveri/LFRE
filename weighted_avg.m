function [x_truth, x_hat_all, error] = weighted_avg(adj, layers, byz, A, li, x0, t_max)
    % WEIGHTED_AVG - distributed state estimation based on a weighted
    %   average of all incoming states. No filtering is used.
    %
    % INPUTS:
    %   adj - the adjacency matrix for the graph topology. This is defined
    %       in LFRE_driver.m
    %   layers - a matrix defining which nodes are in each layer. This is
    %       defined in LFRE_driver.m
    %   byz - the definition of byzantine nodes and their outputs
    %   A - An LTI state transition matrix
    %   li - Gain for the Luenberger observer
    %   x0 - The initial state
    %   t_max - the maximum number of time steps to simulate for
    %
    % Returns:
    %   x_truth - the ground truth trajectory for t_max time steps
    %   x_hat_all - N x T matrix of node states, N = nodes, T = time steps
    %   error - the error in each node state with respect to ground truth
    
    % Holder variables
    x_truth = zeros(1, t_max+1);
    x_truth(1) = x0;
    x_hat_all = zeros(length(adj), t_max+1);
    
    % Initialize states
    x_hat_all(1,1) = x0;
    x_hat_all(1:end, 1) = rand([length(adj) 1]);
    
    % Iterate for time steps
    for i = 1:t_max
        y_k = x_truth(i);
        % Operate on layers
        for l = 1:size(layers, 1)
            % Operate on nodes in each layer
            for m = 1:size(layers, 2)
                
                % Compute current node ID
                current_node = layers(l,m);
                
                % If not a node, continue
                if current_node == -1
                    continue
                end
                
                % Operate on Byzantine nodes (no dynamics update)
                [byz_tf, byz_idx] = is_byz(current_node, byz);
                if byz_tf
                    x_hat_all(current_node, i+1) = byz(2, byz_idx);
                    continue
                end
                
                % Operate on source nodes (layer 1)
                if l == 1
                    % Create luenberger observer
                    x_hat_all(current_node, i+1) = A * x_hat_all(current_node, i) + li * (y_k - x_hat_all(current_node, i));  
                    
                % All other layers - Weighted Average Filtering
                else
                    % Collect States of strictly immediate in-neighbors
                    nodes = 1:length(adj);
                    source_nodes = nodes(logical(adj(current_node, :)));
                    in_states = x_hat_all(source_nodes, i);
                    
                    % Update xi_hat
                    weights = ones(size(in_states))./length(in_states);
                    x_hat_all(current_node, i+1) = sum(weights .* in_states);
                    
                end % if - operation on nodes depending on layer
            end % M nodes for each layer
        end % Each layer
        
        % Apply state transition matrix to x_truth
        x_truth(i+1) = A * x_truth(i);
        
    end % t_max reached
    
    % Compute error
    error = x_hat_all - repmat(x_truth, length(adj), 1);
end