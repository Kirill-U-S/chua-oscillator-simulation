function require_state(x)
%REQUIRE_STATE Column state of length 3. A row is not transposed.
if ~isnumeric(x) || ~isequal(size(x), [3, 1])
    error('chua:state', 'ожидался столбец размера 3x1');
end
end
