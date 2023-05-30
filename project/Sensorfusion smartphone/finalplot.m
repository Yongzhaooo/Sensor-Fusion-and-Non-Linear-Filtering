function void = finalplot(t_filter, filter, t_measure, measurement)

figure;
hold on;
subplot(1,3,1);
plot(t_filter,filter(1,:),'LineWidth',2,'LineStyle',':');
plot(t_measure,measurement(1,:), 'LineWidth',2)
legend('filter','phone_measurement')
ylabel('yaw');

subplot(1,3,2);
plot(t_filter,filter(2,:),'LineWidth',2,'LineStyle',':');
plot(t_measure,measurement(2,:), 'LineWidth',2)
legend('filter','phone_measurement')
ylabel('pitch');

subplot(1,3,3);
plot(t_filter,filter(3,:),'LineWidth',2,'LineStyle',':');
plot(t_measure,measurement(3,:), 'LineWidth',2)
legend('filter','phone_measurement')
ylabel('roll');
end