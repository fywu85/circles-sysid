clear; close all;

s = tf('s');
kp = 1.0467641274631;
ki = 0.134074922947779;
kd = 1.14032900506104;
kn = 2.31488315878784;
pid = kp + ki / s + kd * kn / (1 + kn / s);
sys = 0.652 / (s + 0.797);
cl_sys = feedback(pid * sys * 1/s, 1);

exp_id = 10;
path = sprintf('exp_data/%03d', exp_id);
t = 7:0.02:65;
cmd_acc_tb = readtable(sprintf('%s/cmd_acc.csv', path));
cmd_acc = interp1(...
    cmd_acc_tb.Time - cmd_acc_tb.Time(1), cmd_acc_tb.data, t);
acc_tb = readtable(sprintf('%s/acc.csv', path));
acc = interp1(...
    acc_tb.Time - cmd_acc_tb.Time(1), acc_tb.accel_linear_x, t);
cmd_vel_tb = readtable(sprintf('%s/cmd_vel.csv', path));
cmd_vel = interp1(...
    cmd_vel_tb.Time - cmd_acc_tb.Time(1), cmd_vel_tb.twist_linear_x, t);
vel_tb = readtable(sprintf('%s/vel.csv', path));
vel = interp1(...
    vel_tb.Time - cmd_acc_tb.Time(1), vel_tb.twist_linear_x, t);

acc_data = iddata(acc', cmd_acc', [], 'SamplingInstants', t');
tuned_sys = tfest(acc_data, sys);
sim_acc = lsim(sys, cmd_acc', t');
tuned_sim_acc = lsim(tuned_sys, cmd_acc', t');
figure;
hold on;
plot(t, cmd_acc, 'LineWidth', 2);
plot(t, sim_acc, 'LineWidth', 2);
plot(t, tuned_sim_acc, 'LineWidth', 2);
plot(t, acc, 'LineWidth', 2);
hold off;
legend('cmd acc', 'sim acc', 'tuned sim acc', 'acc');

vel_data = iddata(vel', cmd_vel', [], 'SamplingInstants', t');
tuned_cl_sys_v1 = feedback(pid * tuned_sys * 1/s, 1);
tuned_cl_sys_v2 = tfest(vel_data, cl_sys);
sim_vel = lsim(cl_sys, cmd_vel', t');
tuned_sim_vel_v1 = lsim(tuned_cl_sys_v1, cmd_vel', t');
tuned_sim_vel_v2 = lsim(tuned_cl_sys_v2, cmd_vel', t');
figure;
hold on;
plot(t, cmd_vel, 'LineWidth', 2);
%plot(t, sim_vel, 'LineWidth', 2);
%plot(t, tuned_sim_vel_v1, 'LineWidth', 2);
plot(t, tuned_sim_vel_v2, 'LineWidth', 2);
plot(t, vel, 'LineWidth', 2);
hold off;
%legend('cmd vel', 'sim vel', 'tuned sim vel v1', 'tuned sim vel v2', 'vel');
legend('cmd vel', 'tuned sim vel v2', 'vel');
