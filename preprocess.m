addpath('New_Shuffled_Train(disorder)')
addpath('EEGTools')
load('subj_1.mat')
EEG_Sig = subj_1;

%%
clc
% Plot Data
X = EEG_Sig' ;
offset = max(abs(EEG_Sig(:))) ;
feq = 512 ;
disp_eeg(X,offset,feq, 1:19);

%%
% Apply ICA
P = 21 ; % Number of components
Xc = centre(X);  % Remove dc component
[Acom2] = COM2R(Xc,P) ; % Mixing matrix
Scom2 = pinv(Acom2)*X ; % Independent Sources

offset = max(abs(Scom2(:))) ;
feq = 512 ;
disp_eeg(Scom2,offset, feq, 1:19);


%%
% Select sources of interest (noise-free sources)
Sel_Sources = 1:19;

X_new = Acom2(:,Sel_Sources)*Scom2(Sel_Sources,:) ; % Denoised Signal

% Plot denoised signal
disp_eeg(X_new,offset,feq,1:19);