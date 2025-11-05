% Ainv = inv(A)
%
% Overloaded function for inverting 3D matrices
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function Ainv = inv(A)

Ainv= zeros(size(A));
for ii = 1:size(A,3)
    Ainv(:,:,ii) = builtin('inv', A(:,:,ii));
end