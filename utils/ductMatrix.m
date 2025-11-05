% [a,b,c,d] = ductMatrix(k,Zrc,S1,L, use12)
%
% A function to calculate the matrix for a straight uiniform duct.
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function [a,b,c,d] = ductMatrix(k,Zrc,S1,L, use12)
if nargin < 5
    use12 = true;
end
kL = k*L;
sinkL = sin(kL);
coskL = cos(kL);
if use12 
    a = coskL; 
    b = Zrc*1i/S1*sinkL;
    c = 1i/Zrc* S1*sinkL;
    d = coskL; 
else
    a = coskL; 
    b = -Zrc*1i/S1*sinkL;
    c = -1i/Zrc* S1*sinkL;
    d = coskL;
end

if nargout == 1
	a = toMatrix(a, b, c, d);
end