function scores = J_Value( Data, Label )

u_tot = mean(Data,1);

scores = zeros(1,size(Data,2));

for i = 1 : size(Data,2)
    
    u0 = 0; n0 = 0; u0_2 = 0;
    u1 = 0; n1 = 0; u1_2 = 0;
    
    for j = 1 : size(Data,1)
        
        if ( Label(j) == 0 )
            n0 = n0 + 1;
            u0 = u0 + Data(j,i);
            u0_2 = u0_2 + Data(j,i)^2;
        else
            n1 = n1 + 1;
            u1 = u1 + Data(j,i);
            u1_2 = u1_2 + Data(j,i)^2;
        end
    end
    
    scores(i) = ( ( u_tot(i) - (u0/n0) )^2 + ( u_tot(i) - (u1/n1) )^2 ) / ( (u0_2/n0 - (u0/n0)^2) + (u1_2/n1 - (u1/n1)^2) );
    
end



end