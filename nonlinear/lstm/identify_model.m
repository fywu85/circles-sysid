clear; close all; load_data;

numResponses = 1;
featureDimension = 1;
numHiddenUnits = 200;
maxEpochs = 1000;
miniBatchSize = 200;

Networklayers = [sequenceInputLayer(featureDimension) ...
    lstmLayer(numHiddenUnits) ...
    lstmLayer(numHiddenUnits) ...
    fullyConnectedLayer(numResponses) ...
    regressionLayer];

options = trainingOptions('adam', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'GradientThreshold',10, ...
    'Shuffle','once', ...
    'Plots','training-progress',...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropPeriod',100,...
    'Verbose',0);

lstm_model = trainNetwork(acmd', a', Networklayers, options);