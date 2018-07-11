clear; close all;

%% Signal
min_range = 1500;
max_range = 1900;
stepp = 0.008; %0.05 microseconds = 20MHz

%% Filter
Fs = 125; % %
Ts = 1/Fs; % in microsec
% Wn = 0.004;
Wn = 0.001;
C = 5; % moving average taps
F = 250; % int(1/Wn) %usually %equivalent to the leading edge of the signal
L = uint32(Fs*90);  % number total samples=50 microsec
t = min_range:stepp:max_range;
% t = (0:L-1)*Ts-10;

%%
[x1,x2,x3,x4,x5,x6,x7,x8] = SIGNAL_fig(min_range,max_range,stepp);

n1 = uint32(10*Fs);
noise1 = 0.01; % 5%
y1 = gauge_signal(Wn,noise1,x1);
y1_int = uint16(y1*512.0); 

n2 = uint32(40.0*Fs);
noise2 = 0.01; % 5%
% x2 = [zeros(n2,1)',ones(L-n2,1)'];
% y2 = lp_filter_resp(x2,2,Wn)+randn(1,length(x2))*noise2;
y2 = gauge_signal(Wn,noise2,x2);

n3 = uint32(70.0*Fs);
noise3 = 0.02; % 5%
% x3 = [zeros(n3,1)',ones(L-n3,1)'];
% y3 = lp_filter_resp(x3,2,Wn)+randn(1,length(x3))*noise3;
y3 = gauge_signal(Wn,noise1,x3);

y3m = mavg_fir(y3,C);
y3f = diff_fir(y3m,F);
y3ff = diff_fir(y3f,F);

%%
figure()
hold on
l1 = plot(t,x1, t,y1);
l3 = plot(t,x2, t,y2);
l5 = plot(t,x3, t,y3, t,y3ff);

% plot([0,40], [0.6,0.6], 'k-.');

legend([l1(1),l3(1),l5(1)],[{'Sensor 1'},{'Sensor 2'},{'Sensor 3'}], ...
    'Interpreter','Latex','location','Southwest');
xlabel('t ($\mu s$)','Interpreter','Latex')
ylabel('p (kPa)','Interpreter','Latex')
% xlim([-5,85])
title('Section 7 Pressures $v = 10 km/s$','FontSize',15,'Interpreter','latex')