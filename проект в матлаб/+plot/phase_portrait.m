function fig = phase_portrait(trajs, eq, plotcfg)
%PHASE_PORTRAIT Four tiles for already computed series. No integration.
p = params_of(trajs);
series = cut_series(trajs, plotcfg);

fig = figure;
layout = tiledlayout(fig, 2, 2);
colors = lines(numel(series));
mark = [0 0 0];

ax = nexttile(layout);
style_axes(ax, 'фазовый портрет', 'x', 'y', 'z');
for k = 1:numel(series)
    s = series{k};
    plot3(ax, s(:, 1), s(:, 2), s(:, 3), 'Color', colors(k, :));
end
draw_eq(ax, eq, mark, [1 2 3]);

ax = nexttile(layout);
style_axes(ax, '(x, y)', 'x', 'y', '');
for k = 1:numel(series)
    s = series{k};
    line(ax, s(:, 1), s(:, 2), 'Color', colors(k, :));
end
draw_eq(ax, eq, mark, [1 2]);

ax = nexttile(layout);
style_axes(ax, '(x, z)', 'x', 'z', '');
for k = 1:numel(series)
    s = series{k};
    line(ax, s(:, 1), s(:, 3), 'Color', colors(k, :));
end
draw_eq(ax, eq, mark, [1 3]);

ax = nexttile(layout);
style_axes(ax, '(y, z)', 'y', 'z', '');
for k = 1:numel(series)
    s = series{k};
    line(ax, s(:, 2), s(:, 3), 'Color', colors(k, :));
end
draw_eq(ax, eq, mark, [2 3]);

sgtitle(layout, sprintf('\\alpha = %g, \\beta = %g, \\sigma = %g', ...
    p.alpha, p.beta, p.sigma), 'Interpreter', 'tex');
end

function p = params_of(trajs)
p = trajs(1).p;
names = ["alpha", "beta", "sigma"];
for k = 1:numel(names)
    if ~isstruct(p) || ~isfield(p, names(k))
        error('plot:params', 'нет поля %s', char(names(k)));
    end
end
end

function series = cut_series(trajs, plotcfg)
use_cut = isstruct(plotcfg) && isfield(plotcfg, 't_from') && ~isempty(plotcfg.t_from);
n = numel(trajs);
series = cell(1, n);
for k = 1:n
    time = trajs(k).t(:);
    state = trajs(k).state;
    if use_cut
        keep = time >= plotcfg.t_from;
        time = time(keep);
        state = state(keep, :);
    end
    if isempty(time)
        error('plot:time', 'после среза не осталось точек');
    end
    series{k} = state;
end
end

function style_axes(ax, name, hx, hy, hz)
title(ax, name, 'Interpreter', 'none');
xlabel(ax, hx, 'Interpreter', 'none');
ylabel(ax, hy, 'Interpreter', 'none');
if strlength(hz) > 0
    zlabel(ax, hz, 'Interpreter', 'none');
end
grid(ax, 'on');
hold(ax, 'on');
end

function draw_eq(ax, eq, color, cols)
if isempty(eq)
    return
end
n = numel(eq);
pts = zeros(n, 3);
labels = strings(n, 1);
for k = 1:n
    state = eq(k).state;
    pts(k, 1) = state(1);
    pts(k, 2) = state(2);
    pts(k, 3) = state(3);
    labels(k) = string(eq(k).name);
end
if numel(cols) == 3
    plot3(ax, pts(:, 1), pts(:, 2), pts(:, 3), ...
        'LineStyle', 'none', 'Marker', 'o', ...
        'MarkerFaceColor', color, 'Color', color);
else
    line(ax, pts(:, cols(1)), pts(:, cols(2)), ...
        'LineStyle', 'none', 'Marker', 'o', ...
        'MarkerFaceColor', color, 'Color', color);
end
for k = 1:n
    xyz = num2cell(pts(k, cols));
    text(ax, xyz{:}, labels(k), ...
        'Color', color, 'Interpreter', 'none', ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');
end
end
