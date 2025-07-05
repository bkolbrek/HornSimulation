function Znorm = circularPistonIB(ka)
R = 1 - besselj(1,2*ka)./(ka);
X = struveH1(2*ka)./(ka);
Znorm = R+1i*X;


function H1 = struveH1(x)
% Using a Struve function approximation from http://mathworld.wolfram.com/StruveFunction.html
H1 = 2/pi - besselj(0,x) + (16/pi - 5)*sin(x)./x + (12-36/pi)*(1-cos(x))./x.^2;
