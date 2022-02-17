clear; close all;

fourthOrderMdl = zpk(-4,[-9+5i;-9-5i;-2+50i;-2-50i],5e5);
[stepResponse,stepTime] = step(fourthOrderMdl);

signalType = 'rgs'; % Gaussian 
signalLength = 5000; % Number of points in the signal
fs = 100; % Sampling frequency
signalAmplitude = 1; % Maximum signal amplitude

urgs = idinput(signalLength,signalType);
urgs = (signalAmplitude/max(urgs))*urgs';

trgs = 0:1/fs:length(urgs)/fs-1/fs;

yrgs = lsim(fourthOrderMdl,urgs,trgs);
yrgs = yrgs';

xval = idinput(100,signalType);
yval = lsim(fourthOrderMdl,xval,trgs(1:100));