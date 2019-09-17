function [Data_J , Indices] = J_Chooser2( Data , J_Scores , Threshold )

    Indices = [];
    
    for i = 1 : length(J_Scores)
        if (J_Scores(i) >= Threshold)
            Indices = [Indices , i];
        end
    end
    
    Data_J = Data(:,Indices);
    
    y = Threshold * ones(1,length(J_Scores));
    
    figure
    plot(J_Scores);
    hold on
    plot(y,'r')
    
    ylabel('J-Value');
    title('We Choose Features with J-Values more than Threshold (Red Line)');
    


end