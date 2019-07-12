function [GM,TPR,TNR]=Konfuzija(Klasa,vjerojatnosti)
  
    Klasa = double(Klasa);
    vjerojatnosti = double(vjerojatnosti);
    Konfuzija = confusionmat(Klasa, vjerojatnosti);
    TP = Konfuzija(1,1);
    FN = Konfuzija(2,1);
    FP = Konfuzija(1,2);
    TN = Konfuzija(2,2);

    TPR = TP/(TP+FN);
    TNR = TN/(TN+FP);
    GM = sqrt(TPR * TNR);
    fprintf('GM %g , TPR %g ,TNR %g \n',GM,TPR,TNR);

end