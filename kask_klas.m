function [Kask_3]=kask_klas(vjerojatnosti,t)


Kask_3=[];
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

Kask_3 = Kaskada;
