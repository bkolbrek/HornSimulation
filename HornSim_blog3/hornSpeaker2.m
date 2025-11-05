% hornspeaker2.m
% 
% This file demonstrates how to simulate a simple exponential horn using 
% a full T-matrix approach
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

% Define front and rear chamber
Vrc = 14e-3; %14 litres
Vtc = 900e-6; %900 cu cm

% Define driver parameters (MKS units)
Sd = 350e-4;
Bl = 18;
Cms = 4.0e-4;
Rms = 4.0;
Mmd = 20e-3;
Le = 1e-3;
Re = 6.0;

% Define input voltage
eg = 2.83;

%% Calculations
freq = logspace(log10(fmin), log10(fmax), 533);
w = 2*pi*freq;
k = w/c;

% Driver calculations
TD = drivermatrix(freq, Sd, Re, Le, Bl, Rms, Cms, Mmd);

% Front and rear chamber calculations
Cab = Vrc / (rho*c^2);
Caf = Vtc / (rho*c^2);
Zcab = 1./(1i*w * Cab);
Zcaf = 1./(1i*w * Caf);
Tvrc = eye(2,2,length(freq));
Tvrc(1,2,:) = Zcab;
Tvtc = eye(2,2,length(freq));
Tvtc(2,1,:) = 1./Zcaf;

% Calculate radiation impedance
a = sqrt(S3/pi);
Z3 = rho*c/S3 * circularPistonIB(k*a);

% Calculate horn matrix
Zrc = rho*c;
Me = expoHornMatrix(k,Zrc,S2,S3,L23);
Mc = conicalHornMatrix(k,Zrc,S1,S2,L12);

% Calculate composite horn matrix
Th = Mc*Me;

% Total system matrix

T = TD * Tvrc * Tvtc * Th;

Ze = getZ1(Z3, T);

Iin = eg./Ze.';
egv = ones(1,length(freq)) * eg;

inputs = [egv; Iin];
outputs = inv(T) * inputs;
driverOut = inv(TD) * inputs;
pm = outputs(1,:);
Um = outputs(2,:);

% Power into the load
Pa = real(pm.*conj(Um));

% Convert power to SPL
I = Pa / (2*pi);
prad = sqrt(I*rho*c);

% Diaphragm displacement
UaL = driverOut(2,:);
x = UaL./w / Sd * sqrt(2);

HRdata = readHornrespExported('conexp.txt');
pos = [419   353   682   388];
f = figure(1);
set(f, "position", pos)
semilogx(freq, 20*log10(prad/2e-5), HRdata.freq, HRdata.SPLdB,'--');
xlim([fmin, fmax]);
ylim([70 120]);
xlabel('Frequency (hertz)');
title('Acoustical Power (dB)');
legend('Matlab','Hornresp');
grid



f = figure(2);
set(f, "position", pos)
semilogx(freq, abs(x)*1000, HRdata.freq, HRdata.Xdmm,'--');
xlim([fmin, fmax]);
xlabel('Frequency (hertz)');
title('Diaphragm Displacement (mm)');
legend('Matlab','Hornresp');
grid


% Electrical impedance
f = figure(3);
set(f, "position", pos)
semilogx(freq, abs(Ze), HRdata.freq, HRdata.Ze,'--');
xlim([fmin, fmax]);
xlabel('Frequency (hertz)');
title('Electrical Impedance (ohms)');
legend('Matlab','Hornresp');
grid


