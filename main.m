%% Healthy Subjects

clc
clear all
close all

%%
Num_Subj = 132;

for subj = 1 : Num_Subj
    subj
    load(['Filtered_Normal/subj',num2str(subj),'.mat'])
    Healthy_Feature(subj, :) = Feature_Extractor(New_Sig');
end

%%
clear all
close all
clc

%%
Feat = [Disorder_Feature; Healthy_Feature];
Label = [ones(1, 196), zeros(1, 132)]';
Jvals = J_Value(Feat, Label);
Jvals(isnan(Jvals)) = 0;
X = J_Chooser1(Feat,Jvals, 779)
Y = [X, Label]

