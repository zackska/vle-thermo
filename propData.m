
function [Tc, pc, w] = propData(fuel)

% % Fix critical properties, influence parameter coefficients, and
% acentric factor by substance
switch fuel
    case 'hexadecane'
        Tc = 721; %% K
        pc = 1454000; %% Pa
        w = .723;
        
        
    case 'propane'
        Tc = 369.8;
        Pc = 4249000;
        w = 0.152;
      
        
%% Ref = http://webbook.nist.gov/cgi/cbook.cgi?ID=C544763&Mask=4
%%Liessmann, G.; Schmidt, W.; Reiffarth, S. Data compilation of the Saechsische
% Olefinwerke Boehlen, Germany, p. 68 (1995)
    case 'nitrogen'
        Tc = 126; %% K
        pc = 3400000; %% Pa
        w = .039;
        
    case 'dodecane'
        Tc = 658.2; %% K
        pc = 1824000; %% Pa
        w = 0.575;
        
        
    case 'butanol'
        Tc = 562.9; %% K
        pc = 4412000; %% Pa
        w = 0.594;
       
           
end
end
 
  