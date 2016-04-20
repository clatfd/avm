function peaknodeindex=findAngPeak(RLvoltlist)
ang=RLvoltlist(2:end,2);
dang=diff(ang);
figure;
subplot(2,1,1);
plot(ang);
subplot(2,1,2);
plot(dang);
[peakval,peaknodeindex]=findpeaks(-dang,'MinPeakHeight',1);
for pi=1:size(peakval)
    hold on
    plot(peaknodeindex(pi),-peakval(pi),'o'); 
end
end