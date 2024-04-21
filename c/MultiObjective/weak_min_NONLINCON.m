A = [-1 1 0 1];
b = 1;
lb=[0,0,0,0]';
ub=[5 5 Inf Inf]';

FUN=@(x) -x(3)-x(4);

NONLINCON= @(x) const(x);

[x,fval,exitflag,output,lambda] = fmincon(FUN,[0;0;0;0],A,b,[],[],lb,ub,NONLINCON) ;

function [C,Ceq]=const(x)
    C=x(1)^2 +x(2)^2 -4*x(1) -14*x(2) +45 + x(3);
    Ceq=[];
end
