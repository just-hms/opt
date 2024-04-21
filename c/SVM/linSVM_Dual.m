
%% Classification problems - Example 5.2

close all; clear; clc;

%% data

A=[ 0.4952    6.8088
    2.6505    8.9590
%...
    0.4309    7.5763
    2.2699    7.1371];

B=[7.2450    3.4422
    7.7030    5.0965
%...
    9.8621    4.3674  ];

nA = size(A,1);
nB = size(B,1);

% training points
T = [A ; B]; 

%% Linear SVM - dual model

% define the problem
y = [ones(nA,1) ; -ones(nB,1)]; % labels
l = length(y);
Q = zeros(l,l);
for i = 1 : l
    for j = 1 : l
        Q(i,j) = y(i)*y(j)*(T(i,:))*T(j,:)' ;
    end
end

% solve the problem

la = quadprog(Q,-ones(l,1),[],[],y',0,zeros(l,1),[]);

% compute vector w
wD = zeros(2,1);
for i = 1 : l
    wD = wD + la(i)*y(i)*T(i,:)';
end
wD


% in the ind we find the elements where the multiplier is strictly positive
% so the constraints are fullfilled as EQUALITIES 
% we expect this 3 points to be ON THE SEPARATING HYPERPLANE

% this vectors are called SUPPORT VECTORS, and are the ones on the
% separating hyperplane 
% 

% compute scalar b
ind = find(la > 1e-3) ;
i = ind(1) ;
bD = 1/y(i) - wD'*T(i,:)' 

% plot the solution
xx = 0:0.1:10 ;
uuD = (-wD(1)/wD(2)).*xx - bD/wD(2);
vvD = (-wD(1)/wD(2)).*xx + (1-bD)/wD(2);
vvvD = (-wD(1)/wD(2)).*xx + (-1-bD)/wD(2);
figure
plot(A(:,1),A(:,2),'bo',B(:,1),B(:,2),'ro',...
    xx,uuD,'k-',xx,vvD,'b-',xx,vvvD,'r-','Linewidth',1.5)
axis([0 10 0 10])
title('Optimal separating hyperplane (dual model)')
