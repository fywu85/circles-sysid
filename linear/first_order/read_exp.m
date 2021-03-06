function [t, acc_data, vel_data] = read_exp(exp_id)
    path = sprintf('exp_data/%03d', exp_id);
    cmd_acc_tb = readtable(sprintf('%s/cmd_acc.csv', path));
    acc_tb = readtable(sprintf('%s/acc.csv', path));
    cmd_vel_tb = readtable(sprintf('%s/cmd_vel.csv', path));
    vel_tb = readtable(sprintf('%s/vel.csv', path));
    t0 = max([...
        cmd_acc_tb.Time(1), ...
        acc_tb.Time(1), ...
        cmd_vel_tb.Time(1), ...
        vel_tb.Time(1)]);
    tf = min([...
        cmd_acc_tb.Time(end), ...
        acc_tb.Time(end), ...
        cmd_vel_tb.Time(end), ...
        vel_tb.Time(end)]);
    ts = 0.02;
    t = 0:ts:tf-t0;
    cmd_acc = interp1(cmd_acc_tb.Time - t0, cmd_acc_tb.data, t);
    acc = interp1(acc_tb.Time - t0, acc_tb.accel_linear_x, t);
    acc_data = iddata(acc', cmd_acc', [], 'SamplingInstants', t');
    cmd_vel = interp1(cmd_vel_tb.Time - t0, cmd_vel_tb.twist_linear_x, t);
    vel = interp1(vel_tb.Time - t0, vel_tb.twist_linear_x, t);
    vel_data = iddata(vel', cmd_vel', [], 'SamplingInstants', t');
end

