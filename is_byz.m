function [byz_tf, byz_idx] = is_byz(current_node, byz)
    % IS_BYZ - a utility function used to determine if the current_node is
    % byzantine or not
    %
    % INPUTS:
    %   current_node - the current node ID
    %   byz - the definition of byzantine nodes and their outputs
    %
    % Returns:
    %   byz_tf - 1 if current_node is byzantine, 0 if not
    %   byz_idx - the column index of byz which the current_node
    %       corresponds to if it is byzantine. -1 if not
    
    % Precursors
    idx = 1:size(byz, 2); % all possible column indecies of byz
    byz_tf = 0;
    byz_idx = -1;
    
    % Logical mask of equality
    %   if current_node is byz, will return 1 in exactly one spot
    is_byz_mask = current_node == byz(1,:);
    
    if sum(is_byz_mask) == 1
        byz_idx = idx(is_byz_mask);
        byz_tf = 1;
    elseif sum(is_byz_mask) > 1
        printf('Error In is_byz calculation');
    end
    
end