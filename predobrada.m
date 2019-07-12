function  [dataset,n,Testing] = predobrada(dataset,Testing)
    s = size(dataset);
    i=1;
    n=[];
    p=1;
    while i < s(2)
       try
        if max(dataset(:,i))-min(dataset(:,i)) <= 0
            dataset(:,i)=[];
            Testing(:,i)=[];
            n(p)=i;
            p=p+1;
            i=i-1;
        end
        i=i+1;
       catch
           break;
       end
end
    
 