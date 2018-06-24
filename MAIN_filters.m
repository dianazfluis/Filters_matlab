clear; close all;

Fs = 250.0; % MSPS
Ts = 1/Fs; % in microsec
% Wn = 0.004;
Wn = 0.001;
C = 5; % moving average taps
F = 250; % int(1/Wn) %usually %equivalent to the leading edge of the signal
L = uint32(Fs*90);  % number total samples=50 microsec
t = (0:L-1)*Ts-10;
n1 = uint32(10*Fs);
noise1 = 0.01; % 5%
[x1,y1] = gauge_signal(L,n1,Wn,noise1);

y1_int = uint16(y1*512.0); 

n2 = uint32(40.0*Fs);
noise2 = 0.01; % 5%
x2 = [zeros(n2,1)',ones(L-n2,1)'];
y2 = lp_filter_resp(x2,2,Wn)+randn(1,length(x2))*noise2;

n3 = uint32(70.0*Fs);
noise3 = 0.02; % 5%
x3 = [zeros(n3,1)',ones(L-n3,1)'];
y3 = lp_filter_resp(x3,2,Wn)+randn(1,length(x3))*noise3;

y3m = mavg_fir(y3,C);
y3f = diff_fir(y3m,F);
y3ff = diff_fir(y3f,F);


figure()
hold on
l1 = plot(t,x1, t,y1);
l3 = plot(t,x2, t,y2);
l5 = plot(t,x3, t,y3, t,y3ff);

plot([0,40], [0.6,0.6], 'k-.');

legend([l1(1),l3(1),l5(1)],[{'Sensor 1'},{'Sensor 2'},{'Sensor 3'}], ...
    'Interpreter','Latex','location','Southwest');
xlabel('t ($\mu s$)','Interpreter','Latex')
ylabel('p (Pa)','Interpreter','Latex')
xlim([-5,85])
title('Section 7 Pressures $v = 10 km/s$','FontSize',15,'Interpreter','latex')