function report = self_check(p)
%SELF_CHECK Algebraic checks of the model. No figures.
require_params(p);
special = p.sigma == 0 && abs(p.a1 - 1/16) <= 1e-15 && abs(p.a2 + 1/6) <= 1e-15;

x_anchor = [1; 0; 0];
dx = chua.rhs(0, x_anchor, p);
if special
    anchor_err = max(abs(dx - [p.alpha * (5/48); 1; 0]));
else
    anchor_err = NaN;
end
if special && abs(p.alpha - 6.2) <= 1e-12
    anchor_31_48 = max(abs(dx - [31/48; 1; 0]));
else
    anchor_31_48 = NaN;
end

eq = chua.equilibria(p);
if special
    if numel(eq) == 3
        s = sqrt(8/3);
        expected = [-s, 0, s; 0, 0, 0; s, 0, -s];
        got = [eq.state];
        eq_coord_err = max(abs(got(:) - expected(:)));
    else
        eq_coord_err = Inf;
    end
else
    eq_coord_err = NaN;
end

eq_residual = 0;
for k = 1:numel(eq)
    eq_residual = max(eq_residual, max(abs(chua.rhs(0, eq(k).state, p))));
end

x_jac = [1; 0.2; -0.5];
h = 1e-6;
J = chua.jacobian(0, x_jac, p);
J_num = zeros(3, 3);
for j = 1:3
    step = zeros(3, 1);
    step(j) = h;
    J_num(:, j) = (chua.rhs(0, x_jac + step, p) - chua.rhs(0, x_jac - step, p)) / (2 * h);
end
jacobian_err = max(abs(J(:) - J_num(:)));

model_ok = (isnan(anchor_err) || anchor_err <= 1e-12) && ...
    (isnan(anchor_31_48) || anchor_31_48 <= 1e-12) && ...
    (eq_residual <= 1e-9) && ...
    (jacobian_err <= 1e-4) && ...
    (isnan(eq_coord_err) || eq_coord_err <= 1e-10);

report.anchor_err = anchor_err;
report.anchor_31_48 = anchor_31_48;
report.eq_coord_err = eq_coord_err;
report.eq_residual = eq_residual;
report.jacobian_err = jacobian_err;
report.model_ok = model_ok;
report.eq = eq;
end
