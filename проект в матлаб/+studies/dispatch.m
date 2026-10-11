function out = dispatch(sys, cfg)
%DISPATCH Branch on cfg.study. Other studies are not built yet.
kind = string(cfg.study);
if kind == "phase_portrait"
    out = studies.phase_portrait(sys, cfg);
else
    error('studies:study', 'исследование ещё не собрано: %s', char(kind));
end
end
