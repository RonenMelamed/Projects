function [fenergy] = newFilters(sig,fs,filters)

%this function get a signal,fs,  and number of filters (filters var)
%the function calculate and returns dft bins with linear filterbank spacings.
%freq scaling : freqHz = (0:1:length(sigf)-1)*fs/length(sigf)/2;  plot(freqHz,sigfft)

if nargin<3 filters=26; end
if nargin<2 fs=16000; end

sigfft=(abs(fft(sig))');                       %get sig dft
sigfft=sigfft(round(1:length(sigfft)/2)+1);    %cut 1st half of dft
lowf=100; highf=6000;                          %set wanted range
lowLoc=floor(lowf/(fs/2-2)*length(sigfft));    %get rational freq locations LOW
highLoc=floor(highf/(fs/2-2)*length(sigfft));  %get rational freq locations HIGH
step=(highLoc-lowLoc)/filters;                 %calc step size 
m=lowLoc:step:(highLoc+step);                  %get points for filters
fenergy=zeros(1,filters);                      %allocation for windows storage

scalar = 1;
for i=1:filters 
    s=sigfft(:,floor(m(i))+1 : floor(m(i+2))+1) ;
    t=triang((floor(m(i+2))+1) - (floor(m(i))))';
    st=s.*t*scalar;
    fenergy(i)=sum(st)/length(st);  %get proportional chunk of the dft
    %fenergy(i)=sum(s)/length(s);  %get proportional chunk of the dft
    
    if i <filters/2
        scalar = scalar+0.25;
    else
        scalar = scalar-0.25;
    end
end

%{
subplot(211)
plot(fenergy);
title('Energy per segment');

subplot(212)
freqHz = (0:1:length(sigf)-1)*fs/length(sigf)/2; 
plot(freqHz,sigfft)
title('Frequency domain');
%}
end

