% testZrad.m
% 
% This file demonstrates the function for calculating the normalized
% radiation impedance of a circular piston in an infinite baffle.
% 
% Copyright (c) 2025 Bjørn Kolbrek
% 
% This code is provided free of charge under the MIT license (see LICENSE file).

ka = logspace(-1,2,500);
Z = circularPistonIB(ka);

figure(1);
loglog(ka, real(Z), ka, imag(Z));