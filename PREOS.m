function [f, v, g] = PREOS(T, p, x, writefun)
% % PREOS provides symbolic expressions for the fugacity, f, volume, v, and VLE objective functions, g, of a
% pure substance or binary system. The critical temperatures,Tcf TcN2, critical
% pressures,  pcf pcN2, acentric factors, wf wN2, and the binary interaction parameter, k, are
% symbolic variables that appear in the output variables in addition to p,
% T, and x. The VLE objective function also inclues the fuel mixture
% fraction of the second phase, y. If writefun == 1, PREOS stores the
% symbolic expressions for v and g as matlab functions of the same name. 

R = 8.3144621; %% Universal gas constant in J/mol*K

syms Tcf TcN2 wf wN2 pcf pcN2 k

% % calculate A and B for individual species
[a(1), b(1)] =  PRab(Tcf, pcf, wf, T, R);
[a(2), b(2)] =  PRab(TcN2, pcN2, wN2, T, R);

%% calculate mixture A and B
x = [x; 1-x]; %% mixture fractions
[am, bm] = mixingRules(a, b, x, k);

%% construct EOS and solve
syms v
EOS = R*T/(v-bm) - am/(v^2 + 2*bm*v - bm^2) - p;
v = solve(EOS, v);

%% Calculate fugacity coefficients
syms vf
f = PRfug(vf, b, bm, a, am, p, T, x, k);
g = setupNR(f);

%% write functions
if writefun
matlabFunction(g, 'file', 'g')
matlabFunction(v, 'file', 'v')
end

end

function f = PRfug(v, b, bm, a, am, p, T, x, k)

R = 8.3144621;

cross = sqrt(a(1)*a(2))*(1-k);
a = [a(1) cross ; cross a(2)];

for i = 1:2
    for j = 1:length(v)
        
    C1 = (b(i)/(bm*R*T));
    C2 = (am/(sqrt(8)*bm*R*T))*(2*dot(x, a(i, :))/am - b(i)/bm);

t1 = (p*v(j) - R*T);

t2 = log(p*(v(j)-bm)/(R*T));

t3 = log((2*v(j) + (2+sqrt(8))*bm)/(2*v(j) + (2-sqrt(8))*bm));


f(i, j) = x(i)*exp(C1*t1-t2-C2*t3);
    end
end

end

function [a, b] = PRab(Tc, pc, w, T, R)

OmegaB = .0778;

b = OmegaB*(R*Tc/pc);


OmegaA = .45724;

m = 0.37464+1.54226*w-0.26993*w^2;

% m = .384401 + 1.522760*w - .213808*w^2 + .034616*w^3 - .017366*w^4;

alpha = (1 +  m*(1-sqrt(T/Tc)))^2;

a = OmegaA*(R^2*Tc^2/pc)*alpha;
end

function [am, bm] = mixingRules(a, b, x, k)

cross = sqrt(a(1)*a(2))*(1-k);

am = x(1)^2*a(1) + 2*x(1)*x(2)*cross + x(2)^2*a(2);

bm = x(1)*b(1) + x(2)*b(2);
end

function [gsym] = setupNR(fsym)            

syms yi xi Ti pj vv vl vf

% construct symbolic objective function
fl = subs(fsym, {xi vf}, [yi, vl]);
fv = subs(fsym, vf, vv);

gsym= fl-fv;
end
