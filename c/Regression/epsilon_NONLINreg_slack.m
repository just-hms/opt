%% Regression problems - Exercise 6.5

close all; clear; clc;

%% data

data = [
    -3.0000 4.58
-2.8000 7.19
-2.6000 8.22
-2.4000 16.06
-2.2000 16.42
-2.0000 17.53
-1.8000 11.48
-1.6000 14.10
-1.4000 16.82
-1.2000 16.15
-1.0000 11.68
-0.8000 6.00
-0.6000 7.82
-0.4000 2.82
-0.2000 2.71
0 1.16
0.2000 -1.42
0.4000 -3.84
0.6000 -4.71
0.8000 -8.15
1.0000 -7.33
1.2000 -13.64
1.4000 -15.26
1.6000 -14.87
1.8000 -9.92
2.0000 -10.50
2.2000 -7.72
2.4000 -11.78
2.6000 -10.26
2.8000 -7.13
3.0000 -2.11
];

x = data(:,1) ;
y = data(:,2) ;
l = length(x) ; % number of points

%% nonlinear regression - dual problem

epsilon = 3;
C = 5;

% define the problem
X = zeros(l,l);
for i = 1 : l
    for j = 1 : l
        X(i,j) = kernel(x(i),x(j)) ;
    end
end


%% gaussian function matrix 

%{
sigma = 0.5
H = zeros(n,n);
s2=2*sigma*sigma;

for i = 1:n
    H(i,i)=1;
        for j=1 : i-1 
            H(i,j)=exp(- norm( X(i) -X(j))^2 /s2);
            H(j,i)=H(i,j);
        end
end 

%}



Q = [ X -X ; -X X ];   
c = epsilon*ones(2*l,1) + [-y;y]; 

% solve the problem
sol = quadprog(Q,c,[],[],...
    [ones(1,l) -ones(1,l)],0,...
    zeros(2*l,1),C*ones(2*l,1));
lap = sol(1:l);
lam = sol(l+1:2*l);

% compute b
ind = find(lap > 1e-3 & lap < C-1e-3);
if isempty(ind)==0
    i = ind(1);
    b = y(i) - epsilon;
    for j = 1 : l
        b = b - (lap(j)-lam(j))*kernel(x(i),x(j));
    end
else
    ind = find(lam > 1e-3 & lam < C-1e-3);
    i = ind(1);
    b = y(i) + epsilon ;
    for j = 1 : l
        b = b - (lap(j)-lam(j))*kernel(x(i),x(j));
    end
end

% find regression and epsilon-tube
z = zeros(l,1);
for i = 1 : l
    z(i) = b ;
    for j = 1 : l
        z(i) = z(i) + (lap(j)-lam(j))*kernel(x(i),x(j));
    end
end
zp = z + epsilon ;
zm = z - epsilon ;

%% plot the solution

% find support vectors
sv = [find(lap > 1e-3);find(lam > 1e-3)]; 
sv = sort(sv);

plot(x,y,'b.',x(sv),y(sv),...
    'ro',x,z,'k-',x,zp,'r-',x,zm,'r-');

legend('Data','Support vectors',...
    'regression','\epsilon-tube',...
    'Location','NorthWest')

%% kernel function

function v = kernel(x,y)

p = 4 ;
v = (x'*y + 1)^p;

end

% per trovare sv guarda sv e scrivi data[sv], lam[sv] lap[sv]

% per trovare i mis classified cerca gli sv con lam o lap = C




