function cfg = apply_preset(cfg)
%APPLY_PRESET Overwrite only p, x0, x0_list and tspan.
name = string(cfg.preset);
if name == "equilibria"
    cfg.p = params(4, 15);
    cfg.tspan = [0 150];
    cfg.x0 = [0.5; 0; 0];
    cfg.x0_list = [0.5, -0.5; 0, 0; 0, 0];
elseif name == "cycle"
    cfg.p = params(6.2, 10);
    cfg.tspan = [0 200];
    cfg.x0 = [1.8; 0.1; -1.5];
    cfg.x0_list = zeros(3, 0);
else
    error('lab:preset', 'неизвестный пресет: %s', char(name));
end
end

function p = params(alpha, beta)
p.alpha = alpha;
p.beta = beta;
p.sigma = 0;
p.a1 = 1/16;
p.a2 = -1/6;
end
