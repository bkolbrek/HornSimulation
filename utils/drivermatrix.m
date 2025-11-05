% [a, b, c, d] = drivermatrix(freq, Sd, Re, Le, Bl, Rms, Cms, Mmd, use12)
%
% A function to calculate the matrix of a simple moving coil loudspeaker driver.
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function [a, b, c, d] = drivermatrix(freq, Sd, Re, Le, Bl, Rms, Cms, Mmd, use12)
if nargin < 9
	use12 = true;
end
jw = 2i*pi*freq(:);
Zeb = Re + jw*Le;
Zm = Rms + jw*Mmd + 1./(jw*Cms);

Nf = length(freq);
Te = eye(2,2,Nf);
Tm = Te;
if use12
	Te(1,2,:) = Zeb;
	Tm(1,2,:) = Zm;
	Tma = [Sd, 0; 0, 1/Sd];
else
	Te(1,2,:) = -Zeb;
	Tm(1,2,:) = -Zm;
	Tma = [1/Sd, 0; 0, Sd];
end
Tem = [0, Bl; 1/Bl, 0];

if isOctave()
	if use12
		TD = mmtimes(mmtimes(mmtimes(Te, Tem), Tm), Tma);
	else
		TD = mmtimes(mmtimes(mmtimes(Tma, Tm), Tem), Te);
	end
else
	if use12
		TD = Te * Tem * Tm * Tma;
	else
		TD = Tma * Tm * Tem * Te;
	end
end


if nargout == 1
	a = TD;
else
	a = squeeze(TD(1,1,:));
	b = squeeze(TD(1,2,:));
	c = squeeze(TD(2,1,:));
	d = squeeze(TD(2,2,:));
end


