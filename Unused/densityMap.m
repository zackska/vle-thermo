
close all
clear all

subst = 'nitrogen';

R = 8.3144621;
n = 50;

[Tc, pc, w] = propData(subst);

p = linspace(100000, 2*pc, n);
t = linspace(25, 2*Tc, n);

hold on
for i = 1:n
for j = 1:n
    
[v] = PREOS(t(i), p(j), subst, 1);

v1(i, j) = v(1);

if size(v)==2
v2(i, j) = v(2);
else
v2(i, j) = 0;
end

end
end

surf(p, t, v1)
title('Root 1')
xlabel('Pressure(Pa)')
ylabel('Temperature(K)')
zlabel('Molar Volume')

figure()
surf(p, t, v2)
title('Root 2')
xlabel('Pressure(Pa)')
ylabel('Temperature(K)')
zlabel('Molar Volume')