% hornspeaker1.m
% 
% This file demonstrates how to simulate a simple exponential horn using 
% a T-matrix and a simple lumped model of the driver, front and rear chambers.
% 
% Copyright (c) 2025 Bjørn Kolbrek
% 
% This code is provided free of charge under the MIT license (see LICENSE file).

% Define medium properties (Hornresp default values)
rho = 1.205;
c = 344;

% Define frequency range
fmin = 10;
fmax = 20e3;

% Define horn dimensions
S1 = 80e-4;
S2 = 5000e-4;
L12 = 150e-2;

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
% 1. Calculate the mechanical equivalent of Ze
Ze = Re + 1i*w * Le;
Zme = Bl^2./Ze;

% 2. Calculate total mechanical impedance
Zm = Rms + 1i*w * Mmd + 1./(1i*w * Cms);
Zmt = Zme + Zm;

% 3. Calculate total acoustical source impedance
Zas = Zmt ./ Sd^2;

% 4. Calculate the acoustic source pressure
ps = eg*Bl ./ (Sd * Ze);

% Front and rear chamber calculations
Cab = Vrc / (rho*c^2);
Caf = Vtc / (rho*c^2);
Zcab = 1./(1i*w * Cab);
Zcaf = 1./(1i*w * Caf);

% Calculate radiation impedance
a = sqrt(S2/pi);
Z2 = rho*c/S2 * circularPistonIB(k*a);

% Calculate horn matrix
Zrc = rho*c;
[a12,b12,c12,d12] = expoHornMatrix(k,Zrc,S1,S2,L12);

% Calculate and normalize throat impedance
Z1 = (a12.*Z2 + b12) ./ (c12.*Z2 + d12);
Z1norm = Z1*S1/(rho*c);

% Total load impedance
Zf = Z1.*Zcaf ./ (Z1 + Zcaf);
Zr = Zcab;
Zal = Zf + Zr;

% Volume velocity into the load
UaL = ps ./ (Zas + Zal);

% Power into the load
pth = UaL .* Zf;
Uth = pth ./ Z1;
Pa = abs(Uth).^2 .* real(Z1);

% Convert power to SPL
I = Pa / (2*pi);
prad = sqrt(I*rho*c);

HRdata = readHornrespExported('blog2.txt');
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

% Diaphragm displacement
x = UaL./w / Sd * sqrt(2);

f = figure(2);
set(f, "position", pos)
semilogx(freq, abs(x) * 1000, HRdata.freq, HRdata.Xdmm,'--');
xlim([fmin, fmax]);
xlabel('Frequency (hertz)');
title('Diaphragm Displacement (mm)');
legend('Matlab','Hornresp');
grid

% Electrical impedance
Zma = Zal * Sd^2;
Zmt = Zma + Zm;
Zem = Bl^2 ./ Zmt;
Zet = Zem + Ze;

f = figure(3);
set(f, "position", pos)
semilogx(freq, abs(Zet), HRdata.freq, HRdata.Ze,'--');
xlim([fmin, fmax]);
xlabel('Frequency (hertz)');
title('Electrical Impedance (ohms)');
legend('Matlab','Hornresp');
grid


