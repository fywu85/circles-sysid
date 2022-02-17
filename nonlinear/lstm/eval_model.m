clear; close all; 
set(0, 'defaultAxesFontName', 'FreeSans');
set(0, 'defaultTextFontName', 'FreeSans');
load 'lstm_model.mat' lstm_model data;
%load '2021-06-11.mat' data;

t_raw = data(:, 1);
[t, ia, ic] = unique(t_raw);
a = data(ia, 4); 
a_cmd = data(ia, 5);

t_interp = 0:0.05:t(end);
a_interp = interp1(t, a, t_interp);
a_cmd_interp = interp1(t, a_cmd, t_interp);

a_lstm = predict(lstm_model, a_cmd_interp) - 0.01;

s = tf('s');
sys = 562.4 / (s^4 + 3.896*s^3 + 94.32*s^2 + 296*s + 666);
a_lin = lsim(sys, a_cmd_interp, t_interp);

fig = figure;
fig.Position = [100 100 1200 300];
plot(...
    t_interp, a_interp, 'r', ...
    t_interp, a_lstm, 'g', ...
    t_interp, a_lin, 'b', ...
    'LineWidth', 2);
xlim([t(1), t(end)])
legend('True', 'LSTM', '4th-Order Linear')
xlabel('Time (s)')
ylabel('Accel (m/s2)')
exportgraphics(gca, 'eval_model.png', 'Resolution', 300);