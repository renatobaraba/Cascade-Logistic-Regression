function [klasa]=Klas(dataset)
    j=0;
    lim = size(dataset);
  if isempty(dataset) ==0
    while j<lim(1)
        
        if j > lim(1)
            break
        end
        j = j+1;
        s=size(dataset);
    if dataset(j,s(2)) == 0               %klasifikacija elemenata za trening
        klasa(j,:) = 1;                 %klasa 1 ako nema gre�aka
    else
        klasa(j,:) = 2;                 %klasa 2 ako su gre�ke prisutne
    end
    end
  else
      klasa=0;
  end
end