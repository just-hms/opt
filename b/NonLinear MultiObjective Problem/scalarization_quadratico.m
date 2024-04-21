% min (3X_1^2 + 2X_2^2 - X_1*X_2, 2X_1 - X_2)
% -2X_1 + X_2 - 2 <= 0
% Q1 e Q2 sono le hessiane delle obj. function
% c1 e c2 sono i coefficienti della parte lineare di ogni obj. fuction
clc, clear

Q1 = [6 -1; -1 4];
Q2 = [0 0; 0 0];
c1 = [0; 0];
c2 = [2; -1];
A = [-2 1];
b = 2;

% solve the scalarized problem with 0 ≤ alfa1 ≤ 1
MINIMA=[ ]; % First column: value of alfa1
LAMBDA=[ ]; % First column: value of alfa1
for alfa1 = 0 : 0.01 : 1
    [x, fval, exitflag, output, lambda] = quadprog(alfa1*Q1+(1-alfa1)*Q2,alfa1*c1+(1-alfa1)*c2,A,b);
    MINIMA = [MINIMA; alfa1, x'];
    LAMBDA = [LAMBDA;alfa1, lambda.ineqlin'];
end

disp("alfa - lambda");
disp(LAMBDA);
disp("alfa - soluzioni");
disp(MINIMA);

plot(MINIMA(:,2),MINIMA(:,3));