function [Yall_at1,Yall_at2,Yall_at3,Yall_at4,Yall_at5,Yall_at6,...
    Yall_at7,Yall_at8] = SIGNAL_fig(min_range,max_range,stepp)
%clear; close all
load data_fig;

% min_range = 1500;
% max_range = 1900;
% stepp = 0.008; %0.05 microseconds = 20MHz
noise_level = 0.5; %in kPa

%%%%%%%%%%%%%%%%%%% Determining the sine function for the signal %%%%%%%%%%%%%%%%%%%
x_at3 = at3raw(1,1):stepp:at3raw(size(at3raw,1),1);

% at3raw1 = unique(at3raw,'rows'); %no funciona
at3raw1 = at3raw;
at3raw1(234,:) = []; %remove repeated value
y_at3 = interp1(at3raw1(:,1),at3raw1(:,2),x_at3,'pchip');

% L = length;
Fs = 1./0.05e-6;
L_at3 = size(y_at3,2);
NFFT  =  2^nextpow2(L_at3); % Next power of 2 from length of y
y1_at3  =  fft(y_at3,NFFT)/L_at3;
f  =  Fs/2*linspace(0,1,NFFT/2+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
damping = (3.5./102.8); %damping in micro-s steps
freq = 0.285; %is actually 285KHz but we have Y units in micro-s, not second
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A = 4; %non-damped
A = 4-damping.*stepp.*[1:L_at3]; %damped, fitted through trial and error
A(A<0) = 0; %fully damped

% figure
% % plot raw signal from engauge
% plot(at3(:,1),at3(:,2),at3raw(:,1),at3raw(:,2))
% hold on
% plot(at3raw(:,1),at3raw(:,2),x_at3,y_at3)
% figure
% % Plot single-sided amplitude spectrum.
% plot(1e-3.*f,2*abs(y1_at3(1:NFFT/2+1)),'k')
% axis([0 500 0 2])
% phase = -3.8; %through trial and error
% wave = A.*sin(2.*pi.*freq.*x_at3+phase);
% Y_at3 = interp1(at3(:,1),at3(:,2),x_at3,'pchip');
% figure
% plot(at3(:,1),at3(:,2),'b',at3raw1(:,1),at3raw1(:,2),'k',x_at3,Y_at3+wave,'r')
% return
%%%%%%%%%%%%%%%%%%% Determining the sine function for the signal %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phase = -3.8; %through trial and error

% we sample on a proper equispaced grid with step
x_at3_i = nearest(at3raw(1,1)./stepp).*stepp;
x_at3_f = nearest(at3raw(size(at3raw,1),1)./stepp).*stepp;

x_at3 = x_at3_i:stepp:x_at3_f;
L_at3 = size(x_at3,2);

A = 4-damping.*stepp.*[1:L_at3]; %damped, fitted through trial and error
A(A<0) = 0; %fully damped
wave = A.*sin(2.*pi.*freq.*x_at3+phase);
Y_at3 = interp1(at3(:,1),at3(:,2),x_at3,'pchip');
%left of signal: pre-shock noise
xl_at3 = min_range:stepp:x_at3_i-stepp;
yl_at3 = rand(1,size(xl_at3,2)).*noise_level;
yl_at3 = abs(yl_at3-noise_level);
%right of signal: 0
xr_at3 = x_at3_f+stepp:stepp:max_range;
yr_at3 = 0.*xr_at3;
% merge all
Yall_at3 = [yl_at3 Y_at3+wave yr_at3];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phase = -3.9.*5; %through trial and error
damping = (5.7./102.8); %damping in micro-s steps

% we sample on a proper equispaced grid with step
x_at1_i = nearest(at1(1,1)./stepp).*stepp;
x_at1_f = nearest(at1(size(at1,1),1)./stepp).*stepp;

x_at1 = x_at1_i:stepp:x_at1_f;
L_at1 = size(x_at1,2);

A = 4-damping.*stepp.*[1:L_at1]; %damped, fitted through trial and error
A(A<0) = 0; %fully damped
wave = A.*sin(2.*pi.*freq.*x_at1+phase);
Y_at1 = interp1(at1(:,1),at1(:,2),x_at1,'pchip');
%left of signal: pre-shock noise
xl_at1 = min_range:stepp:x_at1_i-stepp;
yl_at1 = rand(1,size(xl_at1,2)).*noise_level;
yl_at1 = abs(yl_at1-noise_level);
%right of signal: 0
xr_at1 = x_at1_f+stepp:stepp:max_range;
yr_at1 = 0.*xr_at1;
% merge all
Yall_at1 = [yl_at1 Y_at1+wave yr_at1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phase = -3.5.*5; %through trial and error
damping = (4.8./102.8); %damping in micro-s steps

% we sample on a proper equispaced grid with step
x_at2_i = nearest(at2(1,1)./stepp).*stepp;
x_at2_f = nearest(at2(size(at2,1),1)./stepp).*stepp;

x_at2 = x_at2_i:stepp:x_at2_f;
L_at2 = size(x_at2,2);

A = 4-damping.*stepp.*[1:L_at2]; %damped, fitted through trial and error
A(A<0) = 0; %fully damped
wave = A.*sin(2.*pi.*freq.*x_at2+phase);
Y_at2 = interp1(at2(:,1),at2(:,2),x_at2,'pchip');
%left of signal: pre-shock noise
xl_at2 = min_range:stepp:x_at2_i-stepp;
yl_at2 = rand(1,size(xl_at2,2)).*noise_level;
yl_at2 = abs(yl_at2-noise_level);
%right of signal: 0
xr_at2 = x_at2_f+stepp:stepp:max_range;
yr_at2 = 0.*xr_at2;
% merge all
Yall_at2 = [yl_at2 Y_at2+wave yr_at2];
Yall_at2(Yall_at2<0) = 0; %one sinusoid goes below 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phase = -3.5.*5; %through trial and error
damping = (4.0./102.8); %damping in micro-s steps

% we sample on a proper equispaced grid with step
x_at4_i = nearest(at4(1,1)./stepp).*stepp;
x_at4_f = nearest(at4(size(at4,1),1)./stepp).*stepp;

x_at4 = x_at4_i:stepp:x_at4_f;
L_at4 = size(x_at4,2);

A = 4-damping.*stepp.*[1:L_at4]; %damped, fitted through trial and error
A(A<0) = 0; %fully damped
wave = A.*sin(2.*pi.*freq.*x_at4+phase);
Y_at4 = interp1(at4(:,1),at4(:,2),x_at4,'pchip');
%left of signal: pre-shock noise
xl_at4 = min_range:stepp:x_at4_i-stepp;
yl_at4 = rand(1,size(xl_at4,2)).*noise_level;
yl_at4 = abs(yl_at4-noise_level);
%right of signal: 0
xr_at4 = x_at4_f+stepp:stepp:max_range;
yr_at4 = 0.*xr_at4;
% merge all
Yall_at4 = [yl_at4 Y_at4+wave yr_at4];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phase = -3.*5; %through trial and error
damping = (3.2./102.8); %damping in micro-s steps

% we sample on a proper equispaced grid with step
x_at5_i = nearest(at5(1,1)./stepp).*stepp;
x_at5_f = nearest(at5(size(at5,1),1)./stepp).*stepp;

x_at5 = x_at5_i:stepp:x_at5_f;
L_at5 = size(x_at5,2);

A = 4-damping.*stepp.*[1:L_at5]; %damped, fitted through trial and error
A(A<0) = 0; %fully damped
wave = A.*sin(2.*pi.*freq.*x_at5+phase);
Y_at5 = interp1(at5(:,1),at5(:,2),x_at5,'pchip');
%left of signal: pre-shock noise
xl_at5 = min_range:stepp:x_at5_i-stepp;
yl_at5 = rand(1,size(xl_at5,2)).*noise_level;
yl_at5 = abs(yl_at5-noise_level);
%right of signal: 0
xr_at5 = x_at5_f+stepp:stepp:max_range;
yr_at5 = 0.*xr_at5;
% merge all
Yall_at5 = [yl_at5 Y_at5+wave yr_at5];
Yall_at5(Yall_at5<0) = 0; %one sinusoid goes below 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phase = -3.*5; %through trial and error
damping = (3.2./102.8); %damping in micro-s steps

% we sample on a proper equispaced grid with step
x_at6_i = nearest(at6(1,1)./stepp).*stepp;
x_at6_f = nearest(at6(size(at6,1),1)./stepp).*stepp;

x_at6 = x_at6_i:stepp:x_at6_f;
L_at6 = size(x_at6,2);

A = 4-damping.*stepp.*[1:L_at6]; %damped, fitted through trial and error
A(A<0) = 0; %fully damped
wave = A.*sin(2.*pi.*freq.*x_at6+phase);
Y_at6 = interp1(at6(:,1),at6(:,2),x_at6,'pchip');
%left of signal: pre-shock noise
xl_at6 = min_range:stepp:x_at6_i-stepp;
yl_at6 = rand(1,size(xl_at6,2)).*noise_level;
yl_at6 = abs(yl_at6-noise_level);
%right of signal: 0
xr_at6 = x_at6_f+stepp:stepp:max_range;
yr_at6 = 0.*xr_at6;
% merge all
Yall_at6 = [yl_at6 Y_at6+wave yr_at6];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phase = -3.51.*5; %through trial and error
damping = (3.2./102.8); %damping in micro-s steps

% we sample on a proper equispaced grid with step
x_at7_i = nearest(at7(1,1)./stepp).*stepp;
x_at7_f = nearest(at7(size(at7,1),1)./stepp).*stepp;

x_at7 = x_at7_i:stepp:x_at7_f;
L_at7 = size(x_at7,2);

A = 4-damping.*stepp.*[1:L_at7]; %damped, fitted through trial and error
A(A<0) = 0; %fully damped
wave = A.*sin(2.*pi.*freq.*x_at7+phase);
Y_at7 = interp1(at7(:,1),at7(:,2),x_at7,'pchip');
%left of signal: pre-shock noise
xl_at7 = min_range:stepp:x_at7_i-stepp;
yl_at7 = rand(1,size(xl_at7,2)).*noise_level;
yl_at7 = abs(yl_at7-noise_level);
%right of signal: 0
xr_at7 = x_at7_f+stepp:stepp:max_range;
yr_at7 = 0.*xr_at7;
% merge all
Yall_at7 = [yl_at7 Y_at7+wave yr_at7];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

phase = -4.2.*5; %through trial and error
damping = (3.2./102.8); %damping in micro-s steps

% we sample on a proper equispaced grid with step
x_at8_i = nearest(at8(1,1)./stepp).*stepp;
x_at8_f = nearest(at8(size(at8,1),1)./stepp).*stepp;

x_at8 = x_at8_i:stepp:x_at8_f;
L_at8 = size(x_at8,2);

A = 4-damping.*stepp.*[1:L_at8]; %damped, fitted through trial and error
A(A<0) = 0; %fully damped
wave = A.*sin(2.*pi.*freq.*x_at8+phase);
Y_at8 = interp1(at8(:,1),at8(:,2),x_at8,'pchip');
%left of signal: pre-shock noise
xl_at8 = min_range:stepp:x_at8_i-stepp;
yl_at8 = rand(1,size(xl_at8,2)).*noise_level;
yl_at8 = abs(yl_at8-noise_level);
%right of signal: 0
xr_at8 = x_at8_f+stepp:stepp:max_range;
yr_at8 = 0.*xr_at8;
% merge all
Yall_at8 = [yl_at8 Y_at8+wave yr_at8];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% at7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure
% plot(at3(:,1),at3(:,2),'b',at3raw1(:,1),at3raw1(:,2),'k',x_at3,Y_at3+wave,'r')
% plot(x_at3,Y_at3+wave,'r')
% plot(xl_at3,yl_at3,'b',x_at3,Y_at3+wave,'r')
% plot([xl_at3 x_at3],[yl_at3 Y_at3+wave],'r')
plot(min_range:stepp:max_range,Yall_at1,...
     min_range:stepp:max_range,Yall_at2,...
     min_range:stepp:max_range,Yall_at3,...
     min_range:stepp:max_range,Yall_at4,...
     min_range:stepp:max_range,Yall_at5,...
     min_range:stepp:max_range,Yall_at6,...
     min_range:stepp:max_range,Yall_at7,...
     min_range:stepp:max_range,Yall_at8)

axis([1470 1870 -0.1 11])

set(gca,'FontSize',12)
xlabel('Time (\mus)')
ylabel('Pressure (kPa)')
set(gca,'XMinorTick','on')
set(gca,'YMinorTick','on')
set(gca,'Box','on')
grid on
pbaspect([11 4 4])

%  figure
% plot(at3(:,1),at3(:,2),'b',at3raw1(:,1),at3raw1(:,2),'k',x_at3,Y_at3+wave,'r')
% plot(x_at3,Y_at3+wave,'r')
% plot(xl_at3,yl_at3,'b',x_at3,Y_at3+wave,'r')
% plot([xl_at3 x_at3],[yl_at3 Y_at3+wave],'r')
% plot(min_range:step:max_range,Yall_at8)

% print -depsc2 Fig21_James2017
print -dpdf Fig21_James2017

porra = [(min_range:stepp:max_range)' ...
     Yall_at1' Yall_at2' Yall_at3' Yall_at4' ...
     Yall_at5' Yall_at6' Yall_at7' Yall_at8'];
 
save 'Fig21.txt' porra -ascii

%end