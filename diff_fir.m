% Dif  node where time of dif-ferentiation (parameter F) is usually 
%equivalent to the leading edge of the signal from the pre- amplifier. 
function y = diff_fir(x,F)
a = 1;
b = [1,zeros(F-1,1)',-1];
y = filter(b,a,x);
end