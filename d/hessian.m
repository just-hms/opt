close all; clear; clc;

syms x1 x2 x3 p a
f = a*x1*x2+(1-a)*(x1^2+2*x2^2-x2);
H = hessian(f, [x1, x2]);
e = eig(H);

H, e
