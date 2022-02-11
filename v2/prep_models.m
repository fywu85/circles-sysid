clear;
close all;
set(0,'defaultAxesFontName', 'FreeSans')
set(0,'defaultTextFontName', 'FreeSans')

filename = 'data.csv';
data = csvread(filename, 2);
t = data(:, 1);
data(:, 1) = t - t(1);
t = data(:, 1);
v = data(:, [1, 2]);
vcmd = data(:, [1, 3]);
a = data(:, [1, 4]); 
acmd = data(:, [1, 5]);

% figure;
% set(gca, 'FontSize', 18);
% hold on;
% plot(v(750:end, 1), v(750:end, 2))
% plot(vcmd(750:end, 1), vcmd(750:end, 2))
% xlabel('Time (s)');
% ylabel('Velocity (m/s)');
% legend('true', 'cmd', 'Location', 'best');
% hold off;
%exportgraphics(gca, 'valid_velocity.png', 'Resolution', 300);

% figure;
% set(gca, 'FontSize', 18);
% hold on;
% plot(a(750:end, 1), a(750:end, 2))
% plot(acmd(750:end, 1), acmd(750:end, 2))
% xlabel('Time (s)');
% ylabel('Acceleration (m/s2)');
% legend('true', 'cmd', 'Location', 'best');
% hold off;
