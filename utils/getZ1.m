% Z1 = getZ1(Z2, M1, use12)
%
% Calculates the input impedance of a system described by a matrix, given
% the load impedance at the output end.
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function Z1 = getZ1(Z2, M1, use12)
if nargin < 3
	use12 = true;
end
a1 = squeeze(M1(1,1,:));
b1 = squeeze(M1(1,2,:));
c1 = squeeze(M1(2,1,:));
d1 = squeeze(M1(2,2,:));

if use12
	Z1 = (a1.*Z2(:) + b1) ./ (c1.*Z2(:) + d1);
else
	Z1 = (d1.*Z2(:) - b1) ./ (-c1.*Z2(:) + a1);
end