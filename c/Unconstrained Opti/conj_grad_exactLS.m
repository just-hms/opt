clear; close all; clc;
% format short e

%% Quadratic Problem

% Problem definition
Q = [6 0 -4 0;0 6 0 -4;-4 0 6 0;0 -4 0 6]

c = [ 1 -1 2 -3]';


disp('Eigenvalues of Q:')
eig(Q)

%% Parameters

x0 = [0,0,0,0]';
tolerance = 10^(-6);


%% Conjugate Gradient method

% starting point
x = x0;
%   questo vettore salva i risultati di ogni iterazione 
X=[Inf,Inf,Inf,Inf,Inf,Inf,Inf];


for ITER=1:10

    v = 0.5*x'*Q*x + c'*x;
    g = Q*x + c ;

    X=[X;ITER,x',v,norm(g)];

    % stopping criterion
    % we have a theorem that asserts that this converges
    if norm(g) < tolerance
        break
    end
    
    %   search direction
    % difference from the traditional gradient method

    if ITER == 1
        % alla prima iterazione la inizializzi col gradiente
        d = -g; 
    else
        % poi definiao i parametri come abbiamo spiegato
        beta = (g'*Q*d_prev)/(d_prev'*Q*d_prev);
        d = -g + beta*d_prev;
    end
    
    %   step size
    t = (-g'*d)/(d'*Q*d);
    
    %   new point
    
    x = x + t*d; 
    d_prev = d ; 
end
 x
 v
 norm(g)
 ITER



