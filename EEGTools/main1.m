% Sample code for ICA denoising
clear, close all, clc 

load('subj001/EEG/task001_run001/EEG_rereferenced.mat') ;


% Plot Data
% Use function disp_eeg(X,offset,feq,ElecName)
X = EEG_Sig ;
offset = max(abs(EEG_Sig(:))) ;
feq = 250 ;
ElecName = Electrodes.labels ;
disp_eeg(X,offset,feq,ElecName);

% Apply ICA
% For example: use com2 algorithm
P = 21 ; % Number of components
Xc = centre(X);  % Remove dc component
[Acom2] = COM2R(Xc,P) ; % Mixing matrix
Scom2 = pinv(Acom2)*X ; % Independent Sources

% Check temporal, spatial and spectral signatures of each source
% Temporal 

%%%%%%% ????????????


% Spectral 
% Use [pxx,f] = pwelch(S,fs) 

%%%%%%% ????????


% Spatial
% Use plottopomap(elocsX,elocsY,elabels,data)

[elocsX,elocsY] = pol2cart(pi/180*[Electrodes.theta],[Electrodes.radius]);

figure
for i=1:21
    subplot(4,6,i)
    plottopomap(elocsX,elocsY,Electrodes.labels,Acom2(:,i)) ;
    title(num2str(i))
end

% Select sources of interest (noise-free sources)
Sel_Sources = %??????????

X_new = Acom2(:,Sel_Sources)*Scom2(Sel_Sources,:) ; % Denoised Signal

% Plot denoised signal
disp_eeg(X_new,offset,feq,ElecName);

