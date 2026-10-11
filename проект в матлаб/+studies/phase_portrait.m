function out = phase_portrait(sys, cfg)
%PHASE_PORTRAIT Trajectories, equilibria and numeric checks. No figure.
eq = sys.equilibria(cfg.p);
if size(cfg.x0_list, 2) >= 1
    starts = cfg.x0_list;
else
    starts = cfg.x0;
end
n = size(starts, 2);
for k = 1:n
    trajs(k) = traj.trajectory(sys, cfg.p, starts(:, k), cfg.tspan, cfg.ode); %#ok<AGROW>
end

report = chua.self_check(cfg.p);
o1 = named_state(eq, "O1");
o3 = named_state(eq, "O3");
dist_to_O1 = nan(1, n);
dist_to_O3 = nan(1, n);
x_min_late = nan(1, n);
x_max_late = nan(1, n);
x_span_late = nan(1, n);
for k = 1:n
    last = trajs(k).state(end, :).';
    if ~isempty(o1)
        dist_to_O1(k) = norm(last - o1);
    end
    if ~isempty(o3)
        dist_to_O3(k) = norm(last - o3);
    end
    late = trajs(k).state(trajs(k).t > 100, 1);
    if ~isempty(late)
        x_min_late(k) = min(late);
        x_max_late(k) = max(late);
        x_span_late(k) = x_max_late(k) - x_min_late(k);
    end
end

preset = string(cfg.preset);
names_ok = ~isempty(o1) && ~isempty(o3);
if preset == "equilibria"
    pass = names_ok && report.model_ok && n >= 2 && ...
        dist_to_O3(1) < 1e-2 && dist_to_O1(2) < 1e-2;
elseif preset == "cycle"
    pass = names_ok && report.model_ok && n >= 1 && ...
        x_span_late(1) > 0.05 && x_min_late(1) > 0;
else
    pass = false;
end

large_cycle = false;
if preset == "cycle" && n >= 1
    large_cycle = x_min_late(1) <= 0 && x_max_late(1) > 0;
end

checks.anchor_err = report.anchor_err;
checks.anchor_31_48 = report.anchor_31_48;
checks.eq_coord_err = report.eq_coord_err;
checks.eq_residual = report.eq_residual;
checks.jacobian_err = report.jacobian_err;
checks.model_ok = report.model_ok;
checks.dist_to_O1 = dist_to_O1;
checks.dist_to_O3 = dist_to_O3;
checks.x_min_late = x_min_late;
checks.x_max_late = x_max_late;
checks.x_span_late = x_span_late;
checks.large_cycle = large_cycle;
checks.pass = pass;

out.kind = "phase_portrait";
out.trajs = trajs;
out.eq = eq;
out.checks = checks;
end

function state = named_state(eq, name)
state = [];
if isempty(eq)
    return
end
idx = find(string({eq.name}) == string(name), 1);
if ~isempty(idx)
    state = eq(idx).state;
end
end
