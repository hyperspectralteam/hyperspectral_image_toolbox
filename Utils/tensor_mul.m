function M = tensor_mul(T, v, d, mode)
%TENSOR_MUL is the tensor multiply function
%   T is a tensor
%   v is a vector
%   d is the dimension
    shape = size(T);
    if mode == 0
        shape_T = int32(ones([1, d]));
        shape_T(1:length(shape)) = shape;
        T = reshape(T, shape_T);
        shape_v = int32(ones([1, d]));
        shape_v(d) = length(v);
        v = reshape(v, shape_v);
        M = T .* v;
    elseif mode == 1
        shape_v = int32(ones([1, length(shape)]));
        shape_v(d) = length(v);
        v = reshape(v, shape_v);
        M = squeeze(sum(T .* v, d));
    elseif mode == 2
        shape_v = size(v);
        len = shape_v(2);
        M = [];
        for i = 1:len
            shape_v = int32(ones([1, length(shape)]));
            shape_v(d) = length(v);
            v_ = reshape(v(:, i), shape_v);
            M = cat(d, M, sum(T .* v_, d));
        end
    end
end

