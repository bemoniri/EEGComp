clc
clear all
close all

for subj = 1 : 196
    close all
    subj
    %addpath('New_Shuffled_Train(disorder)')
    addpath('EEGTools')
    EEGstruct = load(['New_Shuffled_Train(normal)/subj_',num2str(subj),'.mat']);
    names = fieldnames(EEGstruct);
    EEG_Sig = EEGstruct.(names{1});
    feq = 512 ;

    h = BPF(200,eps,45,feq);
    New_Sig = doFilt(h, EEG_Sig);

    offset = max(abs(EEG_Sig(:)')) ;
    %disp_eeg(EEG_Sig',offset,feq, 1:19);

    offset = max(abs(New_Sig(:)')) ;
    %disp_eeg(New_Sig',offset,feq, 1:19);

    figure
    hold on
    plot(abs(fftshift(fft(EEG_Sig(:, 2)))))
    plot(abs(fftshift(fft(New_Sig(:, 2)))))
    New_Sig = New_Sig(1:4:end, :);
    feq = 512/4;
    name = ['subj', num2str(subj), '.mat'];
    save(name, 'New_Sig');
end


%%
clc
% Plot Data
X = EEG_Sig' ;
offset = max(abs(EEG_Sig(:))) ;
disp_eeg(X,offset,feq, 1:19);

% Apply ICA
P = 21 ; % Number of components
Xc = centre(X);  % Remove dc component
[Acom2] = COM2R(Xc,P) ; % Mixing matrix
Scom2 = pinv(Acom2)*X ; % Independent Sources

offset = max(abs(Scom2(:))) ;
feq = 512 ;
disp_eeg(Scom2,offset, feq, 1:19);
Sel_Sources = 1:19;

%%
% Select sources of interest (noise-free sources)
Sel_Sources([]) = []
X_new = Acom2(:,Sel_Sources)*Scom2(Sel_Sources,:) ; % Denoised Signal

% Plot denoised signal
offset = max(abs(X_new(:))) ;
disp_eeg(X_new,offset,feq,1:19);
name = ['subj', num2str(subj), '.mat'];
save(name, 'X_new');
