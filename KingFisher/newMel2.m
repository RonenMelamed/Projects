function [fenergy] = newMel2(sig,fs,filters)
%this function get a signal, fs and number of filters (filters parameter).
%there is a new mel function in use here that frq=mel at 2500hz
%the function calculate and returns logarythmic filterbank spacings.
%freq scaling : freqHz = (0:1:length(sigf)-1)*fs/length(sigf)/2;  plot(freqHz,sigfft)
%     %display
%     figure(1)
%     subplot(211)
%     plot(sigfft)
%     hold on
%     plot((mlow),zeros(1,length(mlow)),'g*')
%     hold on
%     plot(mhigh,zeros(1,length(mhigh)),'r*')
%     subplot(212)
%     plot(fenergy) 
% 

if nargin<3 filters=26; end
if nargin<2 fs=16000; end


sigfft=(abs(fft(sig,1600))');                      %get sig dft
sigfft=sigfft(floor(1:length(sigfft)/2)+1);   %cut 1st half of dft
len=length(sigfft);

lowf=floor((( 1000*2 )/fs)*len ) ; 
highf=floor((( 5000*2 )/fs)*len );                         %set wanted range
midf = floor((( 3000*2 )/fs)*len ); 

% lmel=nfrq2mel(lowf);       %convert to mel
% hmel=nfrq2mel(highf);      %convert to mel
% midmel = nfrq2mel(midf);
lmel=log(lowf);       %convert to mel
hmel=log(highf);      %convert to mel
midmel = log(midf);

highstep = (hmel-midmel)/(filters/2);
lowstep = (midmel - lmel)/(filters/2);

mhigh=(midmel:highstep:(hmel)+ highstep );                      %get location points for filters
mlow=(midmel:-lowstep:lmel - lowstep);                      %get location points for filters

% mhigh=floor(nmel2frq(mhigh));                                 %convert points back to freq               
% mlow=floor(nmel2frq(mlow));                                 %convert points back to freq      
mhigh=floor(exp(mhigh));                                 %convert points back to freq               
mlow=floor(exp(mlow));                                 %convert points back to freq     
mlow(2:length(mlow)) = mlow(1)+ cumsum(flip(diff(mlow))); 
mhigh(2:length(mhigh)) = mhigh(1) + cumsum((-diff(mlow)));
fenergyHigh=zeros(1,filters/2);                     %allocation for windows storage
fenergyLow=fenergyHigh;                              %allocation for windows storage


scalar = 2;

for i=1:(filters/2)
    
    %high filters
    s = sigfft(mhigh(i):mhigh(i+2));
    t = triang(mhigh(i+2) - mhigh(i)+1)';
    st=s.*t*scalar;
    fenergyHigh(i)=sum(st)/length(st);                    %get proportional chunk of dft
    
    %low filters
    s = sigfft(mlow(i+2):mlow(i));
    t = triang(mlow(i)+1 - mlow(i+2))';
    st=s.*t*scalar;
    fenergyLow(i)=sum(st)/length(st);                    %get proportional chunk of dft
    
    scalar = scalar-0.16;
end
fenergy = [flip(fenergyLow) fenergyHigh] ; 


end

