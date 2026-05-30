function phaseDiagram(x, p, T, fuel, n)
%phaseDiagram plots a phase diagram in density for a binary mixture of an
%alkane
%   Detailed explanation goes here

syms Ts ps

pv = linspace(p(1), p(2), n);
Tv = linspace(T(1), T(2), n);

rhos = zeros(n);

switch fuel
        %% binary interaction parameter from Qiu & Reitz, IJMF 2014
        case 'dodecane'
            ki = .2082; 
        case 'hexadecane'
            ki = .1816;
        %% from 
        case 'butanol'
            ki = 0.059;
end

[Tcfi, pcfi, wfi] = propData(fuel);
[TcN2i, pcN2i, wN2i] = propData('nitrogen');

for i = 1:n
    for j = 1:n
        rho = v(TcN2i,Tcfi,Tv(i),ki,pcN2i,pcfi,pv(j),wN2i,wfi,x);
        rho = 1./double(rho);
        [m, ind] = min(abs(imag(rho))); %% pick density with smallest imaginary component
        rhos(i, j) = real(rho(ind));
        
    end
end

figure()
[p, T] = meshgrid(pv, Tv);
surfc(p, T, rhos);
ylabel('Temperature (K)')
xlabel('Pressure (Pa)')
zlabel('density (kg/m^3)')
view([90, -90])
colorbar('northoutside')

shading interp

end

