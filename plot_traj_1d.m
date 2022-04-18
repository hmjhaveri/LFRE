function [] = plot_traj_1d(x_hat_all, error, byz)
    % PLOT_TRAJ_1D - a utility function used plot the error and trajectory
    % of non-byzantine nodes
    %
    % INPUTS:
    %   x_hat_all - N x T matrix of node states, N = nodes, T = time steps
    %   error - the error in each node state with respect to ground truth
    %   byz - the definition of byzantine nodes and their outputs
    %
    % Returns:
    %   None. Figures created
    
    % Create Index Vector and Remove Byzantine Agents
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