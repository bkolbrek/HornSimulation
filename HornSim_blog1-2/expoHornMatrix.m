function [a,b,c,d] = expoHornMatrix(k,Zrc,S1,S2,L)

m = log(S2/S1)/(2*L);
gamma = sqrt(k.^2-m^2);
gL = gamma*L;

singl = sin(gL);
cosgl = cos(gL);

emL = exp(m*L);
a = emL*(cosgl-m./gamma.*singl);
b = emL*1j*Zrc/S2*k./gamma.*singl;
c = emL*1j*S1/Zrc*k./gamma.*singl;
d = emL*S1/S2*(cosgl+m./gamma.*singl);
