% C = mtimes(A,B)
%
% Overloaded matrix multiplication for 3D matrices
%
% Copyright (c) 2025 Bjørn Kolbrek
%
% This code is provided free of charge under the MIT license (see LICENSE file).

function C = mmtimes(A,B)

if isscalar(A) || isscalar(B) || (ismatrix(A) && ismatrix(B))
	C = builtin('mtimes',A,B);
elseif (size(A,3) > 1) && (size(B,3) == 1) && (size(B,2) == size(A,3)) && (size(A,2) == size(B,1))
	% multiply with an array of vectors
	C=zeros(size(B));
	% loop over submatrices
	for ii = 1:size(A,3)
		C(:,ii) = builtin('mtimes', A(:,:,ii), B(:,ii));
	end
elseif (size(A,3) > 1) && (size(B,3) == 1)
	% B is a simple 2D matrix
	C=zeros(size(A,1), size(B,2), size(A,3));
	for ii = 1:size(A,3)
		C(:,:,ii) = builtin('mtimes', A(:,:,ii), B(:,:,1));
	end
elseif (size(B,3) > 1) && (size(A,3) == 1)
	% A is a simple 2D matrix
	C=zeros(size(A,1), size(B,2), size(B,3));
	% loop over submatrices
	for ii = 1:size(B,3)
		C(:,:,ii) = builtin('mtimes', A(:,:,1), B(:,:,ii));
	end
elseif size(B,3) == size(A,3)
	C=zeros(size(A,1), size(B,2), size(B,3));
	% loop over submatrices
	for ii = 1:size(B,3)
		C(:,:,ii) = builtin('mtimes', A(:,:,ii), B(:,:,ii));
	end
else
	error('Matrix multiplication error: dimension mismatch.')
end


