function y = medianS(v)

    d=0;
    flag=0;
    for i=1:length(v)-1
        if (sum(v(1:i))==sum(v(i+1:end)))
            d=i;
            flag=1;
            break
        end
        if(sum(v(1:i))<=sum(v(i+1:end)) && sum(v(1:i+1))>=sum(v(i+2:end)))
            d=i;
            flag=1;
            break
        end
    end
    
    if (flag==1)
        y=d;
    else
        y=floor(length(v)/2)+mod(length(v),2);
    end
    
end
       