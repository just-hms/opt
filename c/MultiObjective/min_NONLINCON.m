
A = [-1 1 0 1 0; 0 0 -1 0 1; 0 0 0 -1 1];
b = [1;0;0];
lb=[0,0,0,0,- Inf]';
ub=[5 5 Inf Inf Inf]';



    FUN=@(x) -x(5);
   
    NONLINCON= @(x) const(x);

    [x,fval,exitflag,output,lambda] = fmincon(FUN,[0;0;0;0;0],A,b,[],[],lb,ub,NONLINCON) ; 


function [C,Ceq]=const(x)
C=x(1)^2 +x(2)^2 -4*x(1) -14*x(2) +40+ x(3);
Ceq=[];
end
