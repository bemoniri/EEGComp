function [Feat] = Feature_Extractor( Data )

Fs = 256;
L = size(Data,2);
time = [0:L-1] / Fs;
F = [-L/2:floor(L/2)-1 ] * Fs/L;

F_Delta = abs( abs(F)>= 0.5 & abs(F) <= 4) ;
F_Theta = abs( abs(F)>= 4 & abs(F) <= 8) ;
F_Alpha = abs( abs(F)>= 8 & abs(F) <= 13) ;
F_Betha = abs( abs(F)>= 13 & abs(F) <= 30) ;

Feat = [];

% Time Domain Features

for i = 1 : size(Data,1)
    
    data = Data(i,:);
    
    Feat = [Feat , mean(data)];     % Average of Each Channel
    Feat = [Feat , var(data)];      % Variance of Each Channel
    
    Feat = [Feat, (data * data')];  % Energy of Each Channel
    
    data_d1 = diff(data);
    data_d2 = diff(data_d1);
    
    Feat = [Feat , ( var(data_d2) * var(data) / (var(data_d1)^2))]; % Form Factor
    Feat = [Feat , max(data)];       % Maximum Magnitude of signal
    Feat = [Feat , skewness(data)];  % Skewness of each Channel
    Feat = [Feat , kurtosis(data)];  % Kurtosis of each channel
    
    Feat = [Feat , mean(diff(data))];   % Average Derivative of Signal
    Feat = [Feat , approximateEntropy(data)];   % Approximate Entropy
    %Hist = hist(data, 50);
    %Feat = [Feat , Hist];            % Histogram of Time Signal (50 bins)
end

for i = 1 : size(Data,1)- 1
    for j = i + 1 : size(Data,1)
        Feat = [Feat , ( (Data(i,:) - mean(Data(i,:)) ) * (Data(j,:)-mean(Data(j,:)))')];   % Covariance of Different Channels;
    end
end

Feat_T = length(Feat);  % Number of Time Domain Feature

% Frequency Domain Features

for i = 1 : size(Data,1)
    
    data = Data(i,:);
    
    data_FFT = abs( fftshift(fft(data)) ) / L;
    
    [~,I_Max] = max(data_FFT);
    Feat = [Feat , abs(F(I_Max))];  % Mode Frequency
    Feat = [Feat , ( ( F * data_FFT')/ (1 + sum(data_FFT)) )];  % Weighted Mean Frequency (Safe Mean)
    
    
    Feat = [Feat , F(medianS(data_FFT))];                % Median Frequency
    
    Feat = [Feat , ( ((F_Delta .* data_FFT) * (F_Delta .* data_FFT)')/(data_FFT * data_FFT') )];    % Delta Band Relative Energy
    Feat = [Feat , ( ((F_Theta .* data_FFT) * (F_Theta .* data_FFT)')/(data_FFT * data_FFT') )];    % Theta Band Relative Energy
    Feat = [Feat , ( ((F_Alpha .* data_FFT) * (F_Alpha .* data_FFT)')/(data_FFT * data_FFT') )];    % Alpha Band Relative Energy
    Feat = [Feat , ( ((F_Betha .* data_FFT) * (F_Betha .* data_FFT)')/(data_FFT * data_FFT') )];    % Betha Band Relative Energy
    
    [cc,~]=wavedec(data,3,'db1');
    sub1 = cc(1:32);
    sub2 = cc(33:64);
    sub3 = cc(65:128);
    sub4 = cc(129:256);
    
    % Wavelet Features
    Feat = [Feat , min(sub1) , max(sub1) , mean(sub1) , var(sub1)];
    Feat = [Feat , min(sub2) , max(sub2) , mean(sub2) , var(sub2)];
    Feat = [Feat , min(sub3) , max(sub3) , mean(sub3) , var(sub3)];
    Feat = [Feat , min(sub4) , max(sub4) , mean(sub4) , var(sub4)];
    
end

Feat_F = length(Feat) - Feat_T;    % Number of Frequency Domain Features
end