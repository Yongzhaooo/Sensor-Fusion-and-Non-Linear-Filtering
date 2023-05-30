clear;
clc;
close all;
load('final_all.mat');


[t_filter, filter] = myclear(xhat.t, xhat.x);
[t_measure, phone] = myclear(meas.t, meas.orient);

figure;
hold on;
subplot(3,1,1);
hold on;
plot(t_filter,filter(1,:),'LineWidth',2,'LineStyle',':');
plot(t_measure,phone(1,:), 'LineWidth',2)
legend('filter','phone\_measurement')
ylabel('x');

subplot(3,1,2);
hold on;
plot(t_filter,filter(2,:),'LineWidth',2,'LineStyle',':');
plot(t_measure,phone(2,:), 'LineWidth',2)
legend('filter','phone\_measurement')
ylabel('y');

subplot(3,1,3);
hold on;
plot(t_filter,filter(3,:),'LineWidth',2,'LineStyle',':');
plot(t_measure,phone(3,:), 'LineWidth',2)
legend('filter','phone\_measurement')
ylabel('z');

