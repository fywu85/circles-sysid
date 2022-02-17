clear; close all;

load('data.mat');
sim_out = sim('sysid_models_v0_2016a');
figure;
hold on;
plot(t, cmd_acc(:, 2), 'LineWidth', 2);
plot(sim_out.tout, sim_out.yout{1}.Values.Data, 'LineWidth', 2);
plot(t, acc(:, 2), 'LineWidth', 2);
hold off;
legend('cmd acc', 'tuned acc', 'obs acc', 'FontSize', 18);

figure;
hold on;
plot(t, cmd_vel(:, 2), 'LineWidth', 2);
plot(sim_out.tout, sim_out.yout{2}.Values.Data, 'LineWidth', 2);
plot(sim_out.tout, sim_out.yout{3}.Values.Data, 'LineWidth', 2);
plot(t, vel(:, 2), 'LineWidth', 2);
hold off;
legend('cmd vel', 'pid vel', 'tuned vel', 'obs vel', 'FontSize', 18);