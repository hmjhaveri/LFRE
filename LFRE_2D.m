function [x_truth, x_hat_all, error] = LFRE_2D(adj, layers, byz, A, li, x0, t_max, F)

    % Holder variables
    x_truth = zeros(2, t_max+1);
    x_truth(:, 1) = x0;
    x_hat_all = zeros(length(adj), t_max+1, 2); % each state corresponds to node number
    
    % Initialize states
    x_hat_all(1:end, 1, :) = rand([length(adj), 1, 2]);
    
    % Iterate for time steps
    for i = 1:t_max
        y_k = x_truth(:, i);
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
                    x_hat_all(current_node, i+1, :) = byz(2:3, byz_idx);
                    continue
                end
                
                % Operate on source nodes (layer 1)
                if l == 1
                    % Create luenberger observer
                    old_state = x_hat_all(current_node, i, :);
                    x_hat_all(current_node, i+1, :) = A * old_state(:) + li * (y_k - old_state(:));  
                    
                % All other layers - LFRE Filtering
                else
                    % Collect States of strictly immediate in-neighbors
                    nodes = 1:length(adj);
                    source_nodes = nodes(logical(adj(current_node, :)));
                    
                    in_states = [x_hat_all(source_nodes, i, 1) x_hat_all(source_nodes, i, 2)];
                    
                    % Sort
                    in_state_norm = vecnorm(in_states');
                    [~, in_state_idx] = sort(in_state_norm);
                    
                    % Remove top F and bottom F states
                    in_state_idx = in_state_idx(F+1:end-F);
                    in_states = in_states(in_state_idx, :);
                    in_states = in_states';
                    
                    % Produce xi_bar proposal
                    weights = 1./size(in_states, 2);
                    xi_bar = sum(weights * in_states, 2);
                    
                    % Update xi_hat
                    x_hat_all(current_node, i+1, :) = diag(eig(A)) * xi_bar;
                    
                end % if - operation on nodes depending on layer
            end % M nodes for each layer
        end % Each layer
        
        % Apply state transition matrix to x_truth
        x_truth(:, i+1) = A * x_truth(:, i);
    end % t_max reached
    
    % Compute error
    x_truth = reshape(x_truth', [1, 21, 2]);
    error = x_hat_all - repmat(x_truth, length(adj), 1);
end