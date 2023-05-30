function [tout, eulerout] = myclear(t, data)
    valid_idx = ~isnan(data(1,:));
    tout = t(valid_idx);
%     data_out = zeros(4,length(valid_idx));
    for i =1:4
    data_out(i,:) = data(i,valid_idx);
    end
    eulerout = q2euler(data_out) * 180/pi;
end
