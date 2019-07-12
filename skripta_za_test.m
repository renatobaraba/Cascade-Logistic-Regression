skripta_za_ucenje

[Trening,nan,Testing]=predobrada(Trening,Testing);
Klasa = Klas(Trening);
s=size(Trening);
koeficijenti = mnrfit(Trening(:,1:s(2)-1),Klasa);           %uèenje koeficijenata ,gradi se model

Provjera_f = tabulate(Klasa);                               %provjera frekvencije seta za trening

Klasatest = Klas(Testing);
Klasatest_f = tabulate(Klasatest);                          %provjera frekvencije seta za testing

[GM,TPR,TNR,vjerojatnostitest] = korak1(Klasatest,koeficijenti,Testing);

[M,I] = max(GM);
I = I/10;
top_threshold = I;
bottom_threshold = 1-I;

korak2  %skripta za drugi korak



