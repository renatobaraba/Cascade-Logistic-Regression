function [GM,TPR,TNR,vjerojatnosti1] = korak1(Klasatest,koeficijenti,Testing)

s=size(Testing);
vjerojatnosti = mnrval(koeficijenti,Testing(:,1:s(2)-1));   %sa mrnval vrši se predviðanje

vjerojatnosti1 = vjerojatnosti(:,2);

j=0;
for i=1:9           % klasifikacija vjerojatnosti
    j = j+0.1;
    thr(i,1) = j;
    k = 0;
    while(k < length(vjerojatnosti1))
        k = k+1;
    if vjerojatnosti1(k,:) > j
        vjerojatnostitest2(k,:) = 2;
    else
        vjerojatnostitest2(k,:) = 1;
    end
    end
    

    vjerojatnosti = double(vjerojatnostitest2);
    
    Konfuzija = confusionmat(Klasatest, vjerojatnosti);     % generiranje matrice konfuzije
    TP = Konfuzija(1,1);
    FN = Konfuzija(2,1);
    FP = Konfuzija(1,2);
    TN = Konfuzija(2,2);

    TPR(i,1) = TP/(TP+FN);
    TNR(i,1) = TN/(TN+FP);
    GM(i,1) = sqrt(TPR(i,1) * TNR(i,1));
    
savefig('ROC_1_korak.fig');
figure(1);                                                  %crtanje grafova
set(gca,'fontsize',24)
hold on;
[Y,Z] = perfcurve(Klasatest,vjerojatnosti1,1);
plot(Z,Y,'LineWidth',14);
title('ROC curve');
xlabel('FPR');
ylabel('TPR');

savefig('GM_1_korak.fig');
figure(2)
set(gca,'fontsize',24)
hold on;
xlim([0 1]);
plot(thr,GM,'LineWidth',14);
ylim([0 1]);
title('GM za 1. korak');
xlabel('threshold');
ylabel('GM');

   
end