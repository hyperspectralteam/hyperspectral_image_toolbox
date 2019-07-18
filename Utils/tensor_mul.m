function M = tensor_mul(T, v, d)
%TENSOR_MUL is the tensor multiply function
%   T is a tensor
%   v is a vector
%   d is the dimension
    shape = size(T);
    
    if length(shape) < d
        error('d should not be larger than the dimesion of T.');
    end
    
    if length(v) ~= shape(d)
        error('The dimesion of v and the corresponding dimesion of T is not consistent.');
    end
    
    shape_v = int32(ones([1, length(shape)]));
    shape_v(d) = length(v);
    disp(shape_v);
    v = reshape(v, shape_v);
    M = squeeze(sum(T .* v, d));
end

