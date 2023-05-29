function plotRead(data, t, name, ori)
len = length(t);
figure;hold on;clf;
plot(t(:,1:len-10),data(:,1:len-10));
if ~ori
legend('x','y','z')
else
    legend('p1','p2','p3','p4');
end
title(sprintf('%s', name));
end