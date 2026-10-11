function traj = trim(traj, t_from)
%TRIM Keep samples with time at or after t_from. Does not integrate again.
keep = traj.t >= t_from;
if ~any(keep)
    error('traj:trim', 'не осталось ни одного отсчёта');
end
traj.t = traj.t(keep);
traj.state = traj.state(keep, :);
end
