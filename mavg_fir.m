function y = mavg_fir(x,C)
% FIR moving average with length C
a = [1,-1];
b = [1,zeros(C-1,1)',-1]/C;
y = filter(b,a,x);
end