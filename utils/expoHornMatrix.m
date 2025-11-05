% [a,b,c,d] = expoHornMatrix(k,Zrc,S1,S2,L, use12)
%
% A function to calculate the matrix for an exponential horn.
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function [a,b,c,d] = expoHornMatrix(k,Zrc,S1,S2,L, use12)
if nargin < 6
	use12 = true;
end

m = log(S2/S1)/(2*L);
gamma = sqrt(k.^2-m^2);
gL = gamma*L;

singl = sin(gL);
cosgl = cos(gL);

emL = exp(m*L);
if use12
	a = emL*(cosgl-m./gamma.*singl);
	b = emL*1j*Zrc/S2*k./gamma.*singl;
	c = emL*1j*S1/Zrc*k./gamma.*singl;
	d = emL*S1/S2*(cosgl+m./gamma.*singl);
else
	a = emL*(cosgl + m./gamma.*singl);
	b = -emL*1j*Zrc/S1*k./gamma.*singl;
	c = -emL*1j*S2/Zrc*k./gamma.*singl;
	d = emL*S2/S1*(cosgl - m./gamma.*singl);
end


if nargout == 1
	a = toMatrix(a, b, c, d);
end
