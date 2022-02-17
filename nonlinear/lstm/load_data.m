clear; close all;

filename = 'data.csv';
data = csvread(filename, 2);
t = data(:, 1);
data(:, 1) = t - t(1);
t = data(:, 1);
v = data(:, [1, 2]);
vcmd = data(:, [1, 3]);
a = data(:, 4); 
acmd = data(:, 5);
