% [a1,b1,c1,d1] = getMatCoeff(M1)
%
% Extracts the individual matrix coefficients as vectors from a 3D matrix.
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function [a1,b1,c1,d1] = getMatCoeff(M1)
	a1 = squeeze(M1(1,1,:));
	b1 = squeeze(M1(1,2,:));
	c1 = squeeze(M1(2,1,:));
	d1 = squeeze(M1(2,2,:));