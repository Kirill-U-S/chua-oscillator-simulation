function require_scalar(x)
%REQUIRE_SCALAR Scalar argument of f and df.
if ~isnumeric(x) || ~isscalar(x)
    error('chua:state', 'ожидался скаляр размера 1x1');
end
end
