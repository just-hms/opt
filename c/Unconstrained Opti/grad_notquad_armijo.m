%% Unconstrained optimization -- Exercise 3.2
format long

clear; close all;  

%% data 
% settiamo tutti i parametri

% min f(x(1),x(2))= 2*x(1)^4 + 3*x(2)^4 + 2*x(1)^2 + 4*x(2)^2 + x(1)*x(2) - 3*x(1) - 2*x(2)

alpha = 0.1;
gamma = 0.8;
tbar = 1;
x0 = [-10;8];
tolerance = 1e-6 ;

%% method

%disp('Gradient method with Armijo inexact line search');



x = x0 ;

for ITER=0:100
    % adesso abbiamo una funzione generica 
    [v, g] = f(x);
    
    % stopping criterion
    if norm(g) < tolerance
        break
    end
    
    % search direction
    d = -g;
    
    % Armijo inexact line search
    t = tbar ;
    while f(x+t*d) > v + alpha*g'*d*t
        t = gamma*t ;
    end

        
    % new point
    x = x + t*d;

    disp(ITER)
    disp(x)
    disp("cazzi")

end

x
v
norm(g)
ITER

function [v, g] = f(x) 

v = 2*x(1)^2 + x(2)^2 - x(1)*x(2) + exp(x(1)+2*x(2));

g = [
    4*x(1)-x(2)+exp(x(1)+2*x(2))
    2*x(2)-x(1)+2*exp(x(1)+2*x(2))
];

end