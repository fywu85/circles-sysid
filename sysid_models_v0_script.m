s = tf('s');
%% cmd_acc > acc
% Transfer function
tf_aa = 1.745 / (s + 1.566);
% State space form
[num, den] = tfdata(tf_aa);
[A_aa, B_aa, C_aa, D_aa] = tf2ss(num{1}, den{1});

%% cmd_acc > vel
% Transfer function
tf_av = tf_aa * 1 / s;
% State space form
[num, den] = tfdata(tf_av);
[A_av, B_av, C_av, D_av] = tf2ss(num{1}, den{1});

%% cmd_vel > vel
% Transfer function
tf_vv = (6.249 * s^2 + 9.31 * s + 0.8967) / ...
    (s^4 + 2.922 * s^3 + 13.64 * s^2 + 9.536 * s + 0.8998);
% State space form
[num, den] = tfdata(tf_vv);
[A_vv, B_vv, C_vv, D_vv] = tf2ss(num{1}, den{1});

%% cmd_vel > acc
% Transfer function
tf_va = tf_vv * s;
% State space form
[num, den] = tfdata(tf_va);
[A_va, B_va, C_va, D_va] = tf2ss(num{1}, den{1});

%% delta_vel > cmd_acc (pid w/o satuation and anti-windup)
% Transfer function
kp = 1.0467641274631;
ki = 0.134074922947779;
kd = 1.14032900506104;
kn = 2.31488315878784;
tf_pid = kp + ki / s + kd * kn / (1 + kn / s);
% State space form
[num, den] = tfdata(tf_pid);
[A_pid, B_pid, C_pid, D_pid] = tf2ss(num{1}, den{1});
