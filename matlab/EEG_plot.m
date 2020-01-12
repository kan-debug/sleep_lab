% data import and initialization, start is the start of figure display in
% seconds
clear all
close all
file = load('1113EEG_nofoil.data');
title_name = 'test';
start = 20;

%generate x axis
sampling_rate = 500; 
period = 1/sampling_rate;
t_file = linspace(period, length(file)*period, length(file));

%process
EEG_error_reduce = file(start*sampling_rate:end,1)+ file(start*sampling_rate:end,2);

spectrum = fft(EEG_error_reduce);
P2 = abs(spectrum/length(EEG_error_reduce));
P1 = P2(1:length(EEG_error_reduce)/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = sampling_rate*(0:(length(EEG_error_reduce)/2))/length(EEG_error_reduce);
%spectrum_x=(0:length(spectrum)-1)*(sampling_rate/length(spectrum));

%plot
ax(1)=subplot(4,1,1);
plot(t_file(:,start*sampling_rate:end),file(start*sampling_rate:end,1));
title(title_name);
ylabel('Ch1');
ax(2)=subplot(4,1,2);
plot(t_file(:,start*sampling_rate:end),file(start*sampling_rate:end,2));
ylabel('Ch2');
ax(3)=subplot(4,1,3);
plot(t_file(:,start*sampling_rate:end),EEG_error_reduce);
ylabel('Error cancelation');
xlabel('Time (seconds)');
ax(4)=subplot(4,1,4);
plot(f,20*log(P1));
ylabel('amplitude (dB)');
xlabel('Frequency (Hz)');

%plot beta
Fs1=12.5;
fp1=17;
Rs1=.0001;
Rp=0.057501127785;
wn=[Fs1 fp1]/(sampling_rate/2);
[Or, F, po, w] = firpmord(wn, [0 1], [Rs1, Rp]);
b1 = firpm(Or, F, po, w);
F1 = dfilt.dffir(b1);
x1=filter(F1,EEG_error_reduce);
xl = smooth(x1,30);
figure(2)
plot(t_file(:,start*sampling_rate:end),x1,'r')
title('beta in time domain')
xlabel('time(S)-->')
ylabel('amplitude(db)-->')

