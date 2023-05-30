function data_interp = interpNaN(t, data)
    valid_idx = ~isnan(data); % 找出不含NaN的数据点
    data_interp = interp1(t(valid_idx), data(valid_idx), t, 'linear', 'extrap'); % 线性插值
end
