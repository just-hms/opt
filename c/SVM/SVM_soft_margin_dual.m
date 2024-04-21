close all; clear; clc;

% DATA
A = [6.55 0.85; 6.55 1.71; 7.06 0.31; 2.76 0.46; 0.97 8.23; 9.5 0.34; 4.38 3.81; 1.86 4.89; 2.76 6.79; 6.55 1.22];

B = [9.59 3.40; 5.85 2.23; 7.51 2.55; 5.05 7; 8.9 9.59; 8.40 2.54; 8.14 2.43; 9.3 3.45; 6.16 4.73; 3.51 8.30];

nA = size(A,1);
nB = size(B,1);

% training points
T = [A ; B]; 

%% Linear SVM - dual model (soft margin) - Exercise 5.4

% define the problem
C = 10;

y = [ones(nA,1) ; -ones(nB,1)]; % labels
l = length(y);
Q = zeros(l,l);
for i = 1 : l
    for j = 1 : l
        Q(i,j) = y(i)*y(j)*(T(i,:))*T(j,:)' ;
    end
end

% solve the problem
% the difference is that now we have a upper bound C*ones(l,1)
% which is the vector C multiplied for a vector of ones
la = quadprog(Q,-ones(l,1),[],[],y',0,zeros(l,1),C*ones(l,1),[]);

% compute vector w
wD = zeros(2,1);
for i = 1 : l
   wD = wD + la(i)*y(i)*T(i,:)'; 
end

% compute scalar b

% first of all we find an index that gives lambda > 0
% then the ones < C
% we select the first index that fullfils both
indpos = find(la > 10^(-3));
ind = find(la(indpos) < C - 10^(-3));
i = indpos(ind(1));

bD = 1/y(i) - wD'*T(i,:)';

%% plot the solution 

xx = 0:0.1:10;
uuD = (-wD(1)/wD(2)).*xx - bD/wD(2);
vvD = (-wD(1)/wD(2)).*xx + (1-bD)/wD(2);
vvvD = (-wD(1)/wD(2)).*xx + (-1-bD)/wD(2);


plot(A(:,1),A(:,2),'bo',B(:,1),B(:,2),'r*',...
     xx,uuD,'k-',xx,vvD,'b-',xx,vvvD,'r-','Linewidth',1)
axis([0 10 0 10])
title('Optimal separating hyperplane with soft margin')

% from this point on we compute the errors


% Compute the support vectors

supp = find(la > 10^(-3));
suppA = supp(supp <= nA);
suppB = supp(supp > nA);

% Compute the errors xi (is the letter csi of the error)

%we consider all the index that if lambda_i is > 0
% then we can compute xi by the complementarity 
% slide 25 pacco 5

for i=1:nA+nB
    if la(i) > 0.001 
        xi(i)= 1 - y(i)*(T(i,:)*wD +bD);
    else xi(i)=0;
    end
end


% you can look at the xi for the positive index
% the ones strictly greater than 1 are the ones which are misclassified
% in particular the second and the last of the 5 points 

% the duality allows us to do all this calculations in an easy way
