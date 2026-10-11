function fig = show(out, plotcfg)
%SHOW Figure for out.kind. Any other kind raises plot:study and opens nothing.
kind = string(out.kind);
if kind == "phase_portrait"
    fig = plot.phase_portrait(out.trajs, out.eq, plotcfg);
else
    error('plot:study', 'исследование ещё не собрано: %s', char(kind));
end
end
