function [x_truth, x_hat_all, error] = LFRE(adj, layers, byz, A, li, x0, t_max, F)

    % Holder variables
    x_truth = zeros(1, t_max+1);
    x_truth(1) = x0;
    x_hat_all = zeros(length(adj), t_max+1); % each state corresponds to node number
    
    % Initialize states
    x_hat_all(1:end, 1) = rand([length(adj) 1]);
    
    % Iterate for time steps
    for i = 1:t_max
        y_k = x_truth(i);
        % Operate on layers
        for l = 1:size(layers, 1)
            % Operate on nodes in each layer
            for m = 1:size(layers, 2)
                current_node = layers(l,m);
                if current_node == -1
                    continue
                end
                
                % Operate on Byzantine 
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