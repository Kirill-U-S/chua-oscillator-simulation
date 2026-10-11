function sys = system()
%SYSTEM Descriptor of the smooth Chua generator.
sys.name = "chua";
sys.n = 3;
sys.state_names = ["x", "y", "z"];
sys.param_names = ["alpha", "beta", "sigma", "a1", "a2"];
sys.rhs = @chua.rhs;
sys.jacobian = @chua.jacobian;
sys.equilibria = @chua.equilibria;
sys.symmetry = @chua.symmetry;
end
