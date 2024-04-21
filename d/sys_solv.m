clear; clear all;

syms x1 x2 alfa lambda
eqns = [alfa*x2 + 2*(1-alfa)*x1 == 0,
    alfa*x1 + (1-alfa)*(4*x2 -2) == 0,
    alfa >= 0,
    alfa <= 1];

assume(x1,'real')
assume(x2,'real')
[a,b,parameters,conditions] = solve(eqns,[x1 x2],'ReturnConditions',true);
a
b
conditions

%s = solve(eqns,[x1,x2],'ReturnConditions',true)

clear figure
figure(1)
text(0.1,0.9,['$$', latex(a), '$$'], "Interpreter", "latex", "FontSize",30)
text(0.1,0.5,['$$', latex(b), '$$'], "Interpreter", "latex", "FontSize",30)

text(0.1,0.1,['$$', latex(conditions), '$$'], "Interpreter", "latex", "FontSize",30)

