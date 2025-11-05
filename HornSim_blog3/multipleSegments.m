% multipleSegments.m
% 
% This file demonstrates how to simulate a two-segment horn using
% T-matrices
% 
% Copyright (c) 2025 Bjørn Kolbrek
% 
% This code is provided free of charge under the MIT license (see LICENSE file).

addpath("..\utils\")
% Define medium properties (Hornresp default values)
rho = 1.205;
c = 344;

% Define frequency range
fmin = 10;
fmax = 20e3;

% Define horn dimensions
S1 = 80e-4;
S2 = 350e-4;
L12 = 60e-2;
S3 = 5000e-4;
L23 = 75e-2;

%% Calculations
freq = logspace(log10(fmin), log10(fmax), 533);
w = 2*pi*freq;
k = w/c;

% Calculate radiation impedance
a = sqrt(S3/pi);
Z3 = rho*c/S3 * circularPistonIB(k*a);

% Calculate horn matrix
Zrc = rho*c;
Me = expoHornMatrix(k,Zrc,S2,S3,L23);
Mc = conicalHornMatrix(k,Zrc,S1,S2,L12);

% Calculate composite horn matrix
Mh = Mc*Me;


% Calculate and normalize throat impedance
Z1 = getZ1(Z3, Mh);
Z1norm = Z1*S1/(rho*c);

HRdata = readHornrespExported('conexp.txt');

pos = [419   353   682   388];
f = figure(1);
set(f, "position", pos)
semilogx(freq, real(Z1norm), 'k', freq, imag(Z1norm), 'r', HRdata.freq, real(HRdata.ZaNorm), 'b--', HRdata.freq, imag(HRdata.ZaNorm), 'k--');
xlim([fmin, fmax]);
ylim([-1, 3.5]);
xlabel('Frequency (hertz)');
title('Acoustical impedance');
legend('\Re(Za)','\Im(Za)','\Re(Z_{hr})','\Im(Z_{hr})')
grid