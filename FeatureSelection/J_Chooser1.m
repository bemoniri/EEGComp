function [Data_J , Indices] = J_Chooser1( Data , J_Scores , N_Feats )

    [Js , inds] = sort(J_Scores, 'descend');
    Indices = inds(1 : N_Feats);
    Data_J = Data(:,Indices);
    
    
    figure
    area(Js);
    title ([' Sorted J-Values - We Choose ',num2str(N_Feats), ' Features (Until Red line)']);
    ylabel('J-Value')
    
    hold on
    
    y = zeros(1,length(J_Scores));
    y(N_Feats) = max(J_Scores);
    plot(y,'r');
    

end