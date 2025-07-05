% Define medium properties (Hornresp default values)
rho = 1.205;
c = 344;

% Define frequency range
fmin = 10;
fmax = 20e3;
freq = logspace(log10(fmin), log10(fmax), 533);
k = 2*pi*freq/c;

% Define horn dimensions
S1 = 80e-4;
S2 = 5000e-4;
L12 = 150e-2;

% Calculate radiation impedance
a = sqrt(S2/pi);
Z2 = rho*c/S2 * circularPistonIB(k*a);

% Calculate horn matrix
Zrc = rho*c;
[a12,b12,c12,d12] = expoHornMatrix(k,Zrc,S1,S2,L12);

% Calculate and normalize throat impedance
Z1 = (a12.*Z2 + b12) ./ (c12.*Z2 + d12);
Z1norm = Z1*S1/(rho*c);

figure(1);
semilogx(freq, real(Z1norm), 'k', freq, imag(Z1norm), 'r');
xlim([fmin, fmax]);
ylim([-0.5, 2.5]);
xlabel('Frequency (hertz)');
title('Acoustical impedance');
grid
