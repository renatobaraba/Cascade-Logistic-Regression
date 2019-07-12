clear
close all
%Prompt user for filename
[fname, pname] = uigetfile('*.csv');  
%Create fully-formed filename as a string
filename = fullfile(pname, fname);
Tablica1 = readtable(filename);  % uèitavanje datoteke u tablicu
if (width(Tablica1)==50)
    broj_stupaca = 50;
    X =(Tablica1(:,50));
    X = table2array(X);
    P = Tablica1(1:length(X),2:50);  %set podataka za uèenje
else
    broj_stupaca = 148;
    X =(Tablica1(:,146));
    X = table2array(X);
    P =Tablica1(1:length(X),2:broj_stupaca);  %set podataka za uèenje
end

Pd = table2dataset(P);
P =  single(Pd);

P = P(randperm(size(P,1)),:); %stvaranje nasumicnih redaka

Z  = Klas(P);

Z = single(Z);              %single preciznost
j = 1;
i = 1;

for k = 1:length(X)             %stvaranje dvije tablice,sa greškama(2) i bez grešaka(1)
    if Z(k,1) == 1
        T1(i,1:broj_stupaca-1) = P(k,1:(broj_stupaca-1)); %bez greške 
        i=i+1;
    else
        T2(j,1:broj_stupaca-1) = P(k,1:(broj_stupaca-1)); %sa greškom
        j=j+1;
    end 
end  

t = tabulate(Z);                                 %frekvencija 

len_Trening = 2/3*length(X);
len_Testing = 1/3*length(X);

T11 = len_Trening * (t(1,3) / 100);   %duljina jedinica u setu
T12 = len_Trening * (t(2,3) / 100);   %duljina dvojki u setu

T11 = round(T11);
T12 = round(T12);

r1 = 1:T11;
r2 = 1:T12;

for n=1:T11
    
    M(n,:) = T1(r1(n),1:broj_stupaca-1);

end

for n=1:T12
   
    N(n,:) = T2(r2(n),1:broj_stupaca-1);
       
end

Trening=N;
Trening(length(N)+1:length(M)+length(N),1:broj_stupaca-1) = M(1:length(M),1:broj_stupaca-1);    % set za Training

r1 = length(M)+1:length(T1);
r2 = length(N)+1:length(T2);

for n=1:length(r1)
    
    Ma(n,1:broj_stupaca-1) = T1(r1(n),1:broj_stupaca-1);
   
end
for n=1:length(r2)
 
    Na(n,1:broj_stupaca-1) = T2(r2(n),1:broj_stupaca-1);
   
end

Testing=Na;
Testing(length(Na)+1:length(Ma)+length(Na),1:broj_stupaca-1) = Ma(:,1:broj_stupaca-1);   %set za testiranje

