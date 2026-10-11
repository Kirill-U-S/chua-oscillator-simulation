function require_params(p)
%REQUIRE_PARAMS Finite real alpha, beta, sigma, a1, a2.
if ~isstruct(p) || numel(p) ~= 1
    error('chua:params', 'поле alpha: ожидалась скалярная структура параметров');
end
names = ["alpha", "beta", "sigma", "a1", "a2"];
for name = names
    if ~isfield(p, name)
        error('chua:params', 'нет поля %s', char(name));
    end
    value = p.(name);
    if ~isnumeric(value) || ~isscalar(value) || ~isreal(value) || ~isfinite(value)
        error('chua:params', 'поле %s не конечное вещественное число', char(name));
    end
end
end
