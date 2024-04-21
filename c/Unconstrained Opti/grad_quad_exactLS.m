clear; close all; 


%% Problema definition
%% insert the parameters, Q and c

% 
%Q = [6 0 -4 0;0 6 -4 0;-4 -4 6 0;0 0 0 6]
Q=[6 0 -4 0;0 6 0 -4;-4 0  6 0;0 -4 0 6]

c = [ 1 -1 2 -3]';

disp('eigenvalues of  Q:')
eig(Q)

%% Parameters
% so the starting point and the tolerance 

x0 = [0 0 0 0]';
tolerance = 10^(-6);

%% Gradient method with exact line search


% starting point
x = x0 ;

% vettore di appoggio per salvare i valori di ogni iterazione
X=[Inf,Inf,Inf,Inf,Inf,Inf,Inf];

for ITER=1:1000
    % funzione quadratica
    v = 0.5*x'*Q*x + c'*x;

    % gradient definition
    g = Q*x + c ;
    X=[X;ITER,x',v,norm(g)];

    % stopping criterion
    % is a simple boundary check 
    if norm(g) < tolerance
        break
    end
    
    %   search direction
    d = -g;
    
    %  EXACT LINE SEARCH
    % usiamo la formula chiusa vista prima che 
    % abbiamo a disposizione solo per il caso quadratico we
    % are sure the deonominator is not 0 because d is positive definite
    % and Q is not singular
    
    t = norm(g)^2/(d'*Q*d) ;

        
    %   new point
    x = x + t*d ;
end
disp('optimal solution')
x
disp('optimal value')
v
disp('gradient norm at the solution')

norm(g)



