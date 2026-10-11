function cfg = lab_config()
%LAB_CONFIG Numbers and study name. The preset fills p, x0 and tspan.
cfg.study = "phase_portrait";
cfg.system = "chua";
cfg.preset = "cycle";
cfg.plot.draw = true;
cfg.plot.t_from = 0;
cfg.section.coord = "y";
cfg.section.value = 0;
cfg.section.dir = +1;
cfg.ode.RelTol = 1e-8;
cfg.ode.AbsTol = 1e-9;
cfg.ode.MaxStep = [];
cfg.sweep.param = "alpha";
cfg.sweep.from = 5;
cfg.sweep.to = 8;
cfg.sweep.n = 200;
cfg.sweep.directions = ["up", "down"];
cfg = studies.apply_preset(cfg);
end
