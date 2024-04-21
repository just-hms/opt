
%% Regression problems - Exercise 6.1

close all; clear; clc;

%% data

data = [
    -5 -284
    -4 -168
    -3 -88
    -2 -38
    -1 -12
    0 -4
    1 -8
    2 -18
    3 -28
    4 -32
    5 -24
];

x = data(:,1) ;
y = data(:,2) ;
l = length(x) ;
% number of coefficients of polynomial
% uno in più del grado perchè hai anche il termine noto
n = 4 ;

% Vandermonde matrix
A = [ ones(l,1) x x.^2 x.^3 ];

%% 2-norm problem

z2 = inv(A'*A)*(A'*y)
p2 = A*z2; % regression values at the data

%% 1-norm problem

% define the problem
c = [ zeros(n,1); ones(l,1) ];
D = [ A -eye(l); -A -eye(l) ];
d = [ y; -y ];

% solve the problem
sol1 = linprog(c,D,d) ;
z1 = sol1(1:n)
p1 = A*z1;

%% inf-norm problem

% define the problem
c = [ zeros(n,1); 1 ];
D = [ A -ones(l,1); -A -ones(l,1) ];

% solve the problem
solinf = linprog(c,D,d) ;
zinf = solinf(1:n)
pinf = A*zinf;

%% plot the solutions

plot(x,y,'b.',x,p2,'r-',x,p1,'k-',x,pinf,'g-')
legend('Data','2-norm','1-norm','inf-norm',...
    'Location','NorthWest');


% we can compute the MSE between the produced function and the real one 
MSE = y-p1
% if you obtain a zero it means it is perfect 
