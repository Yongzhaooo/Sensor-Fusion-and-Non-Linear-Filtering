function data = removeNaN(datax)
    dataX = datax(1, 1:end-10);
    data = dataX(~isnan(dataX));
end