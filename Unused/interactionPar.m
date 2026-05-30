function K = interactionPar(T, w)
% % interactionPar calculates the binary interaction parameter for a
% mixture of a hydrocarbon fuel and pure nitrogen according to  Avlonitis 
% et al, Fluid Phase Equilibria, 1994


TcN2 = 126; %%K
TrN2 = T/TcN2;

A = 7.54008*w + 6.98737;
C = 194.591*w + 9.55783;
Q = .00393074/w - .0328572*w + .309785;

% % interaction parameter
K = Q - (TrN2^2 + A)/(TrN2^3 + C);
