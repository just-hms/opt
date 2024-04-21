clear all

C1=[-5 0;0 -1];
C2=[-1 0;0 -5]; 
[m,n] = size(C1);

H=[zeros(m,m),C1+C2,ones(m,1), zeros(m,1); C1'+C2',zeros(n,n),zeros(n,1),ones(n,1); ones(1,m), zeros(1,n+2); zeros(1,m),ones(1,n),0,0];

% There are many possibilities to chose X0

%X0=[0,1,1,0,1,1]'; % m+n+2 vector

% randomize x and y
%X0=[rand(4,1);-1;-20]

%randomize also mu1 and mu2
% this is usually the best one
X0=[rand(4,1);10-20*rand(2,1)]

% here you randomize all with a different variability

%X0=[0,0,1,0,-10*rand(1,2)]';

%  rats(sol(m+n+1:m+n+2)) with this commands you can obtain the mu
% fval is the optimal value found

Ain=[-C2', zeros(n,n),zeros(n,1),-ones(n,1);zeros(m,m), -C1,-ones(m,1),zeros(m,1)]; bin=zeros(n+m,1);

Aeq=[ones(1,m),zeros(1,n+2);zeros(1,m),ones(1,n),0,0];

beq=[1;1]; LB=[zeros(m+n,1);-Inf;-Inf]; 

UB=[ones(m+n,1);Inf;Inf];

% is important that we pass the function with the @(X)

[sol,fval,exitflag,output]=fmincon(@(X) 0.5*X'*H*X, X0, Ain,bin, Aeq,beq,LB,UB)

x = rats(sol(1:m))

y = rats(sol(m+1:m+n))
         
 
