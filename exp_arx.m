clear; close all;

s = tf('s');
kp = 1.0467641274631;
ki = 0.134074922947779;
kd = 1.14032900506104;
kn = 2.31488315878784;
pid = kp + ki / s + kd * kn / (1 + kn / s);
sys = 0.652 / (s + 0.797);
cl_sys = feedback(pid * sys * 1/s, 1);

exp_id = 5;
path = sprintf('exp_data/%03d', exp_id);
t = 7:0.02:66;
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
acc_data_train = acc_data(1:2000);
acc_data_valid = acc_data(2000:end);
tuned_sys = tfest(acc_data_train, sys);
V = arxstruc(acc_data_train, acc_data_valid, struc(1:5, 1:5,1:5));
order = selstruc(V, 'aic');
arx_lin = arx(acc_data_train, order);
figure;
compare(acc_data, sys, tuned_sys, arx_lin);

vel_data = iddata(vel', cmd_vel', [], 'SamplingInstants', t');
vel_data_train = vel_data(1:2000);
vel_data_valid = vel_data(2000:end);
tuned_cl_sys = tfest(vel_data, cl_sys);
V = arxstruc(vel_data_train, vel_data_valid, struc(1:5, 1:5,1:5));
order = selstruc(V, 'aic');
arx_lin = arx(vel_data_train, order);
figure;
compare(vel_data, tuned_cl_sys);
