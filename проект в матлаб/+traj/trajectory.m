function traj = trajectory(sys, p, x0, tspan, odeopts)
%TRAJECTORY One long state trajectory. No time cut and no figure.
n = sys.n;
if ~isnumeric(x0) || ~isequal(size(x0), [n, 1])
    error('traj:x0', 'ожидался столбец размера %dx1', n);
end

span_ok = isnumeric(tspan) && isreal(tspan) && ...
    (isequal(size(tspan), [1, 2]) || isequal(size(tspan), [2, 1]));
if ~span_ok || ~(tspan(2) > tspan(1))
    error('traj:tspan', ...
        'tspan: два числа размера 1x2 или 2x1, второе строго больше первого');
end
tspan = reshape(tspan, 1, 2);

nv = {};
if isfield(odeopts, 'RelTol') && ~isempty(odeopts.RelTol)
    nv = [nv, {'RelTol', odeopts.RelTol}];
end
if isfield(odeopts, 'AbsTol') && ~isempty(odeopts.AbsTol)
    nv = [nv, {'AbsTol', odeopts.AbsTol}];
end
if isfield(odeopts, 'MaxStep') && ~isempty(odeopts.MaxStep) && ...
        isnumeric(odeopts.MaxStep) && all(isfinite(odeopts.MaxStep(:)))
    nv = [nv, {'MaxStep', odeopts.MaxStep}];
end
opts = odeset(nv{:});

[t, yout] = ode45(@(t, x) sys.rhs(t, x, p), tspan, x0, opts);

if ~isnumeric(yout) || ndims(yout) > 2 || size(yout, 2) ~= n
    error('traj:state', 'ожидалась матрица размера N x %d', n);
end

traj.t = t;
traj.state = yout;
traj.x0 = x0;
traj.tspan = tspan;
traj.p = p;
traj.odeopts = odeopts;
traj.solver = "ode45";
end
