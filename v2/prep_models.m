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

