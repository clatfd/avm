function peaknodeindex=findAngPeak(RLvoltlist)
ang=RLvoltlist(2:end,2);
dang=diff(ang);
sdang=smooth(dang,3);
figure;
subplot(2,2,1);
plot(ang);
title('Imaginary');
subplot(2,2,3);
plot(sdang);
[peakval,peaknodeindex]=findpeaks(sdang,'Threshold',0.02);%'MinPeakHeight',1,'Threshold',0.05
%IndMax=find(diff(sign(diff(dang)))<0)+1;
for pi=1:size(peakval)
    hold on
    %plot(IndMax(pi),dang(IndMax(pi)),'o'); 
    plot(peaknodeindex(pi),peakval(pi),'o'); 
end
title('Imaginary diff');
subplot(2,2,2);
plot(RLvoltlist(2:end,1));
title('real');
subplot(2,2,4);
sddrp=smooth(diff(diff((RLvoltlist(2:end,1)))),2);
plot(sddrp);
title('real diff2');
[peakvalr,peaknodeindexr]=findpeaks(sddrp,'MinPeakHeight',0.25);
for pi=1:size(peakvalr)
    hold on
    plot(peaknodeindexr(pi),peakvalr(pi),'o'); 
end
end