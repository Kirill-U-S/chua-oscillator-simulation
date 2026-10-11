function require_time(t)
%REQUIRE_TIME Scalar time argument. The system is autonomous.
if ~isnumeric(t) || ~isscalar(t)
    error('chua:time', 't должен быть скаляром');
end
end
