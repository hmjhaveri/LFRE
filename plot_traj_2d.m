function [] = plot_traj_2d(x_hat_all, error, byz)
    % PLOT_TRAJ_2D - a utility function used plot the error and trajectory
    % of non-byzantine nodes
    %
    % INPUTS:
    %   x_hat_all - N x T x 2 matrix of node states, N = nodes, T = time 
    %       steps
    %   error - the error in each node state with respect to ground truth
    %   byz - the definition of byzantine nodes and their outputs
    %
    % Returns:
    %   None. Figures created
    
    % Create Indexes and Remove Byzantine Agents
    idx = 1:size(x_hat_all, 1);
    idx(byz(1,:)) = [];
    legendStrings = "Node: " + string(idx);
    
    % Plot trajectories as (x,y) coordinate pairs
    figure();
    hold on;
    
    for i = idx
        plot(x_hat_all(i, :, 1), x_hat_all(i, :, 2));
    end
    
    legend(legendStrings, 'location', 'NorthEastOutside');
    xlabel('k');
    ylabel('State');
    title('Trajectory vs. k')

    % Plot norm of x-y errors
    figure();
    hold on;
    
    for i = idx
        diff = [error(i,:, 1); error(i,:, 2)];
        diff = vecnorm(diff);
        plot(diff);
    end
   
    legend(legendStrings, 'location', 'NorthEastOutside');
    xlabel('$k$','Interpreter','latex');
    ylabel('$e_i[k], i \in V$','Interpreter','latex')
end
