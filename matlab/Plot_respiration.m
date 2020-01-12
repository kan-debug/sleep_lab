data = csvread('teraterm.csv',0,1);

img_t = linspace(1,179,179);
ax(1)=subplot(3,1,1);
plot(img_t(14:end),data(14:end,1));
title('respiration test');
ylabel('temperature(T)');
ax(2)=subplot(3,1,2);
plot(img_t(14:end),data(14:end,2));
ylabel('Humidity(%)');
ax(3)=subplot(3,1,3);
plot(img_t(14:end),data(14:end,3));
ylabel('Pressure(kPa)');
xlabel('Time imaginary');

