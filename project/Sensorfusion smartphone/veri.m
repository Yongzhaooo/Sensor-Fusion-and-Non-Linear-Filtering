clc;
clear;
close all;
showIP;
startup;
% load('final_all.mat')
figPosition = [744.2000  300.2000  872.8000  749.6000];
f = @GyroandMag;

[xhat, meas] = f();
close all;

[t_filter, filter] = myclear(xhat.t, xhat.x);
[t_measure, phone] = myclear(meas.t, meas.orient);

newFig = figure;
set(newFig, 'Position', figPosition);

% sgtitle('Compare filter and phone with MAG ACC GYRO'); % 添加总标题
hold on;

subplot(3,1,1);
hold on;
plot(t_filter,filter(1,:),'LineWidth',2,'LineStyle',':');
plot(t_measure,phone(1,:), 'LineWidth',2)
legend('filter','phone\_measurement')
ylabel('yaw');

subplot(3,1,2);
hold on;
plot(t_filter,filter(2,:),'LineWidth',2,'LineStyle',':');
plot(t_measure,phone(2,:), 'LineWidth',2)
legend('filter','phone\_measurement')
ylabel('pitch');

subplot(3,1,3);
hold on;
plot(t_filter,filter(3,:),'LineWidth',2,'LineStyle',':');
plot(t_measure,phone(3,:), 'LineWidth',2)
legend('filter','phone\_measurement')
ylabel('roll');




% end
% 