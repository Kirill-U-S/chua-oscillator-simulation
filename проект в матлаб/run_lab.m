function out = run_lab(cfg)
%RUN_LAB Apply the preset, run the study, optionally draw, print the summary.
if nargin < 1
    cfg = lab_config();
end
cfg = studies.apply_preset(cfg);
sys = studies.system(cfg.system);
out = studies.dispatch(sys, cfg);
if cfg.plot.draw
    out.fig = plot.show(out, cfg.plot);
    out.checks.n_axes = numel(findall(out.fig, 'Type', 'axes'));
    if out.checks.n_axes ~= 4
        out.checks.pass = false;
    end
else
    out.fig = [];
    out.checks.n_axes = 0;
end

fprintf('preset: %s\n', cfg.preset);
fprintf('model_ok: %d\n', out.checks.model_ok);
fprintf('anchor_err: %.3e\n', out.checks.anchor_err);
fprintf('anchor_31_48: %.3e\n', out.checks.anchor_31_48);
fprintf('eq_coord_err: %.3e\n', out.checks.eq_coord_err);
fprintf('eq_residual: %.3e\n', out.checks.eq_residual);
fprintf('jacobian_err: %.3e\n', out.checks.jacobian_err);
fprintf('n_traj: %d\n', numel(out.trajs));
for k = 1:numel(out.trajs)
    fprintf('traj %d dist_to_O1: %.3e\n', k, out.checks.dist_to_O1(k));
    fprintf('traj %d dist_to_O3: %.3e\n', k, out.checks.dist_to_O3(k));
    fprintf('traj %d x_min_late: %.6g\n', k, out.checks.x_min_late(k));
    fprintf('traj %d x_max_late: %.6g\n', k, out.checks.x_max_late(k));
    fprintf('traj %d x_span_late: %.6g\n', k, out.checks.x_span_late(k));
end
fprintf('large_cycle: %d\n', out.checks.large_cycle);
fprintf('n_axes: %d\n', out.checks.n_axes);
fprintf('pass: %d\n', out.checks.pass);
end
