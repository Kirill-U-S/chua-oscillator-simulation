function s = symmetry(p)
%SYMMETRY Central symmetry (x, y, z) -> (-x, -y, -z), enabled only at sigma == 0.
require_params(p);
s.enabled = p.sigma == 0;
s.map = @(state) -state;
end
