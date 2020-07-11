function [] = plotFft(sig,fs)
%x-axis freq scale freqHz = (0:1:length(fft(x))-1)*fs/N; N is fft length
sigfft=abs(fft(sig));
N=length(sigfft);
xx=(0:1:length(sigfft)-1)*fs/N;
plot(xx(1:N/2),sigfft(1:N/2));
end

