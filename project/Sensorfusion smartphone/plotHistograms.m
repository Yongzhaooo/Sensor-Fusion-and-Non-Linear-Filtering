function plotHistograms(data, sensorName)
    % 处理NaN值
    dataX = data(1, 1:end-10);
    dataX = dataX(~isnan(dataX));
    dataY = data(2, 1:end-10);
    dataY = dataY(~isnan(dataY));
    dataZ = data(3, 1:end-10);
    dataZ = dataZ(~isnan(dataZ));

    % 计算均值和标准差
    meanX = mean(dataX);
    stdX = std(dataX);
    fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    fprintf('\n');
    fprintf('The mean of %s -X is %f \n, the covariance of %s -X is %f  \n\n',...
        sensorName, meanX, sensorName, stdX);

    meanY = mean(dataY);
    stdY = std(dataY);
    fprintf('The mean of %s -Y is %f \n, the covariance of %s -Y is %f \n\n',...
        sensorName, meanY, sensorName, stdY);

    meanZ = mean(dataZ);
    stdZ = std(dataZ);
    fprintf('The mean of %s -Z is %f \n, the covariance of %s -Z is %f \n\n',...
        sensorName, meanZ, sensorName, stdZ);
    % 绘制直方图
    figure;
    subplot(3,1,1);
    histogram(dataX, 'Normalization', 'pdf');
    title(sprintf('%s - X', sensorName));

    subplot(3,1,2);
    histogram(dataY, 'Normalization', 'pdf');
    title(sprintf('%s - Y', sensorName));

    subplot(3,1,3);
    histogram(dataZ, 'Normalization', 'pdf');
    title(sprintf('%s - Z', sensorName));
    fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n');
end
