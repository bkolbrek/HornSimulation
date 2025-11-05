% [a,b,c,d] = conicalHornMatrix(k,Zrc,S1,S2,L, use12)
%
% A function to calculate the matrix for a conical horn.
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function [a,b,c,d] = conicalHornMatrix(k,Zrc,S1,S2,L, use12)
if nargin < 6
	use12 = true;
end
if S1==S2
	% if a straight duct is specified, we use the matrix function directly,
	% since otherwise we would get a division by zero when calculating x1.
	a = ductMatrix(k,Zrc,S1,L,use12);
	if nargout > 1
		[a,b,c,d] = getMatCoeff(a);
	end
	return;
end

kL = k*L;
x1 = L/(sqrt(S2/S1)-1);
x2 = x1+L;
kx1 = k*x1;
kx2 = k*x2;
sinkL = sin(kL);
coskL = cos(kL);
if use12
	a = x2/x1 * coskL - sinkL./kx1;
	b = Zrc*1i/S2*x2/x1*sinkL;
	c = 1i/Zrc* S1*((x2/x1 + 1./(kx1.*kx1)).*sinkL - coskL.*L./(kx1*x1));
	d = x1/x2.*coskL + sinkL./kx2;
else
	a = x1/x2 * coskL + sinkL./kx2;
	b = -Zrc*1i/S1*x1/x2*sinkL;
	c = -1i/Zrc* S2*((x1/x2 + 1./(kx2.*kx2)).*sinkL - coskL.*L./(kx2*x2));
	d = x2/x1.*coskL - sinkL./kx1;
end

if nargout == 1
	a = toMatrix(a, b, c, d);
end