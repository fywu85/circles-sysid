clear;
close all;
set(0,'defaultAxesFontName', 'FreeSans')
set(0,'defaultTextFontName', 'FreeSans')

filename = 'data.csv';
data = csvread(filename, 2);
t = data(:, 1);
data(:, 1) = t - t(1);
dt = 0.05;

t = data(:, 1); 
a = data(:, 4); 
acmd = data(:, 5);
sys_iddata = iddata(a, acmd, [], 'SamplingInstants', t);
tf_sys = tfest(sys_iddata, 4, 0);

