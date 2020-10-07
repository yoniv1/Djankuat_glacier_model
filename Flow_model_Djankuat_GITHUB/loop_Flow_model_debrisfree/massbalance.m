% ====================================================================
% This subroutine calculates the surface mass balance.
% ====================================================================

% --------------------------------------------------------------------
% Mass balance profile 
% --------------------------------------------------------------------

% Mass balance (m y^-1 w.e. m^-1)

balweh = betah2*(sur_obs-ELA);
balweh(1:nelh)=betah1*(sur_obs(1:nelh)-ELA); 

acc_prof = 0.00250*(sur_obs-ELA) + 2.52444;
acc_prof(1:nelh) = 0.00140*(sur_obs(1:nelh)-ELA) + 2.59444;
abl_prof = -0.00550*(sur_obs-ELA) + 2.66776;
abl_prof(1:nelh) = -0.00474*(sur_obs(1:nelh)-ELA) + 2.66776;
mb_prof = acc_prof-abl_prof;

balweh = mb_prof;

% Convert to ice equivalent

balh = balweh./0.91;
