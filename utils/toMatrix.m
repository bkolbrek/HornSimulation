% M = toMatrix(a, b, c, d)
%
% Turns the individual matrix coefficients into 3D matrix.
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function M = toMatrix(a, b, c, d)
	M = zeros(2,2,length(a));
	M(1,1,:) = a;
	M(1,2,:) = b;
	M(2,1,:) = c;
	M(2,2,:) = d;