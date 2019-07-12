function [Kask_3,Kask_12]=kask_model(vjerojatnosti,t,dataset)


Kask_3=[];
Kask_12=[];
top_threshold = 1-t;
bottom_threshold = t;
for j=1:length(vjerojatnosti)
    if j > length(vjerojatnosti)
        break
    end

if vjerojatnosti(j,1) > top_threshold               
    Kaskada(j,:) = 2;                
elseif vjerojatnosti(j,1) > bottom_threshold
    Kaskada(j,:) = 3;                 
else 
    Kaskada(j,:) = 1;
end
end

Kaskadnitesting = horzcat(dataset,Kaskada);

i = 1;
l = 1;
s=size(Kaskadnitesting);
for k = 1:length(Kaskadnitesting)                         %stvaranje dvije tablice,sa greškama(2) i bez grešaka(1)
    if Kaskadnitesting(k,s(2)) == 3
        Kask_3(i,1:s(2)-1) = Kaskadnitesting(k,1:s(2)-1); %bez greške 
        i=i+1;
     
    else 
        Kask_12(l,1:s(2)-1) = Kaskadnitesting(k,1:s(2)-1);
        l=l+1;
    end
       
end  

