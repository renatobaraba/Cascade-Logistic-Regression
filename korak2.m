
s=size(Trening);
vjerojatnosti_trening = mnrval(koeficijenti,Trening(:,1:s(2)-1));
vjerojatnosti_trening = vjerojatnosti_trening(:,2);

i = 0;
kakadni_thr = 0;
br_p = 0;
iterator = 0;
vel_kask=0;
vel_sigurno=0;
while(iterator < 9)
    iterator = iterator+1;
    kakadni_thr = kakadni_thr+0.1;
    
    [Kaskadnifit,Sigurno] = kask_model(vjerojatnosti_trening,kakadni_thr,Trening);

    Novaklasa = Klas(Kaskadnifit);
    
%  vel_sigurno(iterator)=length(Sigurno);
   if Novaklasa ==0;        %ako je matrica sa razredom 3 prazna iteracija se preskaèe
       br_p = br_p +1;
       continue;
   end
     vel_kask(iterator)=length(Kaskadnifit);
    [Kaskadnifit,nan1,Testinng] = predobrada(Kaskadnifit,Testing);
    
    s = size(Kaskadnifit);
    kaskadnikoeficijenti = mnrfit(Kaskadnifit(:,1:(s(2)-1)),Novaklasa);
    
    s = size(Testinng);
    kaskadna_vjerojatnost_testa = mnrval(kaskadnikoeficijenti, Testinng(:,1:s(2)-1));
    kaskadna_vjerojatnost_testa = kaskadna_vjerojatnost_testa(:,2);
    thr_kask(iterator) = kakadni_thr;
    
stupac = 0;
red = 0;
j=0;

for i=1:9;
    
    k = 0;
    j=j+0.1;
    thr(i,1) = j;
    l = 0;
    while(l < length(kaskadna_vjerojatnost_testa))
        l = l+1;
        if kaskadna_vjerojatnost_testa(l,:) > j
            vjerojatnostitest3(l,:) = 2;
        else
            vjerojatnostitest3(l,:) = 1;
        end
    end
    
vjero = Klas(Testing);
        
stupac = i;
red=iterator; 

Konfuzijakaskade = confusionmat(vjero, vjerojatnostitest3);
TPK = Konfuzijakaskade(1,1);
FNK = Konfuzijakaskade(2,1);
FPK = Konfuzijakaskade(1,2);
TNK = Konfuzijakaskade(2,2);

TPRK(red,stupac) = TPK/(TPK+FNK);
TNRK(red,stupac) = TNK/(TNK+FPK);
GMK(red,stupac) = sqrt(TPRK(red,stupac) * TNRK(red,stupac));

Klasificiraj_me = kask_klas(vjerojatnostitest, kakadni_thr);

c = 0;
while(c < length(Testing))                          %klasifikacija testing podataka
    c = c+1;
    if(Klasificiraj_me(c) == 3)
        Klasificiraj_me(c) = vjerojatnostitest3(c);
        roc_vjerojatnosti(c,1) = kaskadna_vjerojatnost_testa(c);
    else
    roc_vjerojatnosti(c,1) = vjerojatnostitest(c);
    end
end

Konfuzijakaskade1 = confusionmat(vjero, Klasificiraj_me);
TPK1 = Konfuzijakaskade1(1,1);
FNK1 = Konfuzijakaskade1(2,1);
FPK1 = Konfuzijakaskade1(1,2);
TNK1 = Konfuzijakaskade1(2,2);
TPRK1(red,stupac) = TPK1/(TPK1+FNK1);
TNRK1(red,stupac) = TNK1/(TNK1+FPK1);
GMK1(red,stupac) = sqrt(TPRK1(red,stupac) * TNRK1(red,stupac));

end

p=['r','g','b','y'];

figure(5);

set(gca,'fontsize',24)
hold on;
[Y,Z] = perfcurve(Klasatest,roc_vjerojatnosti,1);
naslov=sprintf('top %.2f, bottom %.2f',1-thr_kask(red),thr_kask(red));

plot(Z,Y,p(red),'DisplayName',naslov,'LineWidth',14);
title('ROC curves cascade');
xlabel('FPR');
ylabel('TPR');


figure(6)

set(gca,'fontsize',24)
hold on;
naslov = sprintf('top %.2f, bottom %.2f',1-thr_kask(red),thr_kask(red));
plot(thr,GMK1(red,:),p(red),'DisplayName',naslov,'LineWidth',14);
xlabel('threshold');
ylabel('GMC');
xlim([0 1]);
ylim([0 1]);
title('Cascade GM');

end
legend('show');
savefig(5,'ROC_2_korak.fig');
savefig(6,'GM_2_korak.fig'); 

figure(7)
set(gca,'fontsize',24)
hold on;
plot(thr_kask,vel_kask,'DisplayName','Podatci','LineWidth',14);
xlabel('threshold');
ylabel('Cascade Size');
title('Cascade Length');

%legend('show');

preciznostBezKaskade = max(GM);
preciznostSaKaskadom = max(max(GMK1));
fileID = fopen('output.txt','a');
fprintf(fileID,'\n%s\n',fname);
fprintf(fileID,'\nPreciznost bez kaskade: %f\n',preciznostBezKaskade);
fprintf(fileID,'\nPreciznost sa kaskadom: %f\n',preciznostSaKaskadom);
fclose(fileID);