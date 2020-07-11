function [fenergy] = newMel(sig,fs,filters)
%this function get a signal, fs and number of filters (filters parameter).
%there is a new mel function in use here that frq=mel at 2500hz
%the function calculate and returns logarythmic filterbank spacings.
%freq scaling : freqHz = (0:1:length(sigf)-1)*fs/length(sigf)/2;  plot(freqHz,sigfft)

if nargin<3 filters=26; end
if nargin<2 fs=16000; end


sigfft=(abs(fft(sig,1600))');                      %get sig dft
sigfft=sigfft(floor(1:length(sigfft)/2)+1);   %cut 1st half of dft
len=length(sigfft);

lmel=frq2mel(1000);       %convert to mel
hmel=frq2mel(6000);      %convert to mel

melstep=(hmel-lmel)/(filters);                %set mel unit steps
m=(lmel:melstep:(hmel));                      %get location points for filters
m=floor(mel2frq(m));                                 %convert points back to freq               
m = floor(( (m*2)/fs)*len );

fenergy=zeros(1,filters);                     %allocation for windows storage
fl=floor(( (200*2)/fs)*len ); fh=floor(( (1000*2)/fs)*len );              %calculate 1st filter ratio
s1=sigfft(fl:fh);   
fenergy(1)=sum(s1)/length(s1);                      %1st filter


scalar = 0.5;
for i=2:(filters)
    
    s = sigfft(m(i-1): m(i+1));
    t = triang(m(i+1) - m(i-1)+1)'*scalar;
    st=s.*t;
    fenergy(i)=sum(st)/length(st);                    %get proportional chunk of dft
    %fenergy(i)=sum(s)/length(s); 
    
    if (i<(filters/2+1))
        scalar = scalar+0.1;
    else
        scalar = scalar-0.1;
    end
    
    hold on , plot(m(i-1):m(i+1),t,'b');
end

end

