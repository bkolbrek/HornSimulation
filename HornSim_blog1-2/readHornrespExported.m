% function data = readHornrespExported(fn)
% 
% Simple function to read Hornresp exported data into a struct.
% 
% Copyright (c) 2025 Bjørn Kolbrek
% 
% This code is provided free of charge under the MIT license (see LICENSE file).

function data = readHornrespExported(fn)
HRdata = importdata(fn);
matrix = HRdata.data;
data.freq = matrix(:,1);
data.ZaNorm = matrix(:,2) + 1i*matrix(:,3);
data.SPLdB = matrix(:,5);
data.Ze = matrix(:,6);
data.Xdmm = matrix(:,7);
data.Wphase = matrix(:,8);
data.Uphase = matrix(:,9);
data.Cphase = matrix(:,10);
data.Delayms = matrix(:,11);
data.Efficiency = matrix(:,12);
data.Ein = matrix(:,13);
data.Pin = matrix(:,14);
data.Iin = matrix(:,15);
data.ZePhase = matrix(:,16);