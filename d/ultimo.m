clear all
syms alpha x1 x2 x3 l1 l2 l3

assume(l1 >= 0);
assume(l2 >= 0);
assume(l3 >= 0);
assume(alpha >= 0 & alpha <= 1);

% funzione obbiettivo
f =  alpha*(x1 - x2 - x3) + (1 - alpha )*(x1 - 2*x2 );

% vincoli
g1 = x1 + x2 + x3 - 4;
g2 = -x1;
g3 = x2;

% gradiente
l = f + l1*g1 + l2*g2 + l3*g3;
g = gradient(l, [x1, x2, x3]);

eqs = [
    g(1,1) == 0
    g(2,1) == 0
    g(3,1) == 0

    l1*g1 == 0
    l2*g2 == 0
    l3*g3 == 0

    g1 <= 0
    g2 <= 0
    g3 <= 0
];

sol = solve(eqs, 'ReturnConditions',1);
