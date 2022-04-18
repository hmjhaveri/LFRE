function [x_truth, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F)
    % LFRE - distributed state estimation using LFRE filtering on an MEDAG
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
    %   F - the maximum number of byzantine agents that can be handled by
    %       the graph topology (decided by topology design)
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
                    
                % All other layers - LFRE Filtering
                else
                    % Collect States of strictly immediate in-neighbors
                    nodes = 1:length(adj);
                    source_nodes = nodes(logical(adj(current_node, :)));
                    in_states = x_hat_all(source_nodes, i);
                    
                    % Sort
                    in_states = sort(in_states);
                    
                    % Remove top F and bottom F states
                    in_states = in_states(F+1:end-F);
                    
                    % Produce xi_bar proposal
                    weights = ones(size(in_states))./length(in_states);
                    xi_bar = sum(weights .* in_states);
                    
                    % Update xi_hat
                    x_hat_all(current_node, i+1) = diag(eig(A)) * xi_bar;
                    
                end % if - operation on nodes depending on layer
            end % M nodes for each layer
        end % Each layer
        
        % Apply state transition matrix to x_truth
        x_truth(i+1) = A * x_truth(i);
    end % t_max reached
    
    % Compute error
    error = x_hat_all - repmat(x_truth, length(adj), 1);
end