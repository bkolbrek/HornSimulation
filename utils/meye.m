% E = eye(varargin)
%
% Overloaded function to generate a 3D identity matrix
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function E = meye(varargin)
narginchk(1,3);
switch nargin
    case 1
        m = varargin{1};
        n = m;
        p = 1;
    case 2
        [m,n] = deal(varargin{:});
        p = 1;
    case 3
        [m,n,p] = deal(varargin{:});
end

% For normal 2D case, defer to builtin
if p == 1
    E = builtin('eye', m, n);
    return;
end

E = zeros(m, n, p);
I = builtin('eye', m, n);
for k = 1:p
    E(:,:,k) = I;
end
