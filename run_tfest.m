clear; close all;

s = tf('s');
kp = 1.0467641274631;
ki = 0.134074922947779;
kd = 1.14032900506104;
kn = 2.31488315878784;
pid = kp + ki / s + kd * kn / (1 + kn / s);
sys = 0.652 / (s + 0.797);
cl_sys = feedback(pid * sys * 1/s, 1);

[t, acc_data, vel_data] = read_exp(10);
cmd_acc = [t', acc_data.InputData];
acc = [t', acc_data.OutputData];
cmd_vel = [t', vel_data.InputData];
vel = [t', vel_data.OutputData];

tuned_sys = tfest(acc_data, sys);

sim_out = sim('valid_model');
figure;
hold on;
plot(t, acc_data.InputData, 'LineWidth', 2);
plot(sim_out.tout, sim_out.yout{3}.Values.Data, 'LineWidth', 2);
plot(t, acc_data.OutputData, 'LineWidth', 2);
hold off;
legend('cmd acc', 'tuned acc', 'obs acc', 'FontSize', 18);

figure;
hold on;
plot(t, vel_data.InputData, 'LineWidth', 2);
plot(sim_out.tout, sim_out.yout{2}.Values.Data, 'LineWidth', 2);
plot(t, vel_data.OutputData, 'LineWidth', 2);
hold off;
legend('cmd vel', 'comp vel', 'obs vel', 'FontSize', 18);

[t, acc_data, vel_data] = read_exp(3);
cmd_acc = [t', acc_data.InputData];
acc = [t', acc_data.OutputData];
cmd_vel = [t', vel_data.InputData];
vel = [t', vel_data.OutputData];

sim_out = sim('valid_model');
figure;
hold on;
plot(t, acc_data.InputData, 'LineWidth', 2);
plot(sim_out.tout, sim_out.yout{3}.Values.Data, 'LineWidth', 2);
plot(t, acc_data.OutputData, 'LineWidth', 2);
hold off;
legend('cmd acc', 'tuned acc', 'obs acc', 'FontSize', 18);

figure;
hold on;
plot(t, vel_data.InputData, 'LineWidth', 2);
plot(sim_out.tout, sim_out.yout{2}.Values.Data, 'LineWidth', 2);
plot(t, vel_data.OutputData, 'LineWidth', 2);
hold off;
legend('cmd vel', 'comp vel', 'obs vel', 'FontSize', 18);
