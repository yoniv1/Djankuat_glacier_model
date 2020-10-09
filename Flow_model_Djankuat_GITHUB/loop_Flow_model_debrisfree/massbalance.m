% ====================================================================
% This subroutine calculates the surface mass balance.
% ====================================================================

% --------------------------------------------------------------------
% Mass balance profile 
% --------------------------------------------------------------------

% Mass balance (m y^-1 w.e. m^-1)

balweh = betah2*(sur_obs-ELA);
balweh(1:nelh)=betah1*(sur_obs(1:nelh)-ELA); 

% Convert to ice equivalent

balh = balweh./0.91;
