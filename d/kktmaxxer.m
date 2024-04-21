syms alpha x1 x2

%assume(alpha>=0 & alpha<=1);

f = alpha*x1^4 + 2*x2^2 + (1-alpha)*(-1 * x1 + x2^2);

g = gradient(f, [x1, x2]);

H = hessian(f, [x1, x2]);

l = eig(H);

disp(g);
disp(H);

ha = gca;
ha.XAxisLocation = 'origin';
ha.YAxisLocation = 'origin';
fplot(ha, l, [0,1]);
hold on

sols = [];
for i = 1:length(l)
    s = solve(l(i) == 0, alpha);
    sols = [sols; s, subs(l(i), alpha, s)];
end

plot(ha, sols(:,1),sols(:,2),'o');

ha.XAxisLocation = 'origin';
ha.YAxisLocation = 'origin';