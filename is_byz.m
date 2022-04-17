function [byz_tf, byz_idx] = is_byz(current_node, byz)
    idx = 1:size(byz, 2);
    byz_tf = 0;
    byz_idx = -1;
    
    % Logical mask of equality - if current_node is byz, will return 1 in
    % exactly one spot
    is_byz_mask = current_node == byz(1,:);
    
    if sum(is_byz_mask) == 1
        byz_idx = idx(is_byz_mask);
        byz_tf = 1;
    elseif sum(is_byz_mask) > 1
        printf('Error In is_byz calculation');
    end
    
end