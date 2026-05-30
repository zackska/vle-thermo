function k = influencePar(subst, T)

switch subst
    case 'hexadecane'    
        k0 = -1.821;
        k1 = -.493;
        k2 = -.108;
        %%Liessmann, G.; Schmidt, W.; Reiffarth, S. Data compilation of the Saechsische
        % Olefinwerke Boehlen, Germany, p. 68 (1995)
        
    case 'propane'
        k0 = -.856;
        k1 = -.327;
        k2 = -.028;
        
    case 'dodecane'
        k0 = -.856;
        k1 = -.327;
        k2 = -.028;
        
    case 'butanol'
        k0 = -.856;
        k1 = -.327;
        k2 = -.028;
        
        %% influence parameter
t = 1-T/Tc;

k = ((a*b^2/3)/N^(8/3))*exp(k0 + k1*log(t) + k2*(log(t))^2);

end
