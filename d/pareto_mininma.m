% Define your objective functions (modify as needed)
fun1 = @(x) (3*x(1)^2 + x(2)^2 - x(1)*x(2));
fun2 = @(x) (2*x(1) - x(2));

% Set up constraints (if any)
A = [-2, 1]; % Linear constraint coefficients
b = -2;      % Constraint value

% Generate Pareto front using paretosearch
rng default; % For reproducibility
x = paretosearch(@(x) [fun1(x); fun2(x)], 2, A, b);

% Display Pareto set
disp('Pareto set coordinates:');
disp(x);
