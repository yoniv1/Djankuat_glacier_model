% ====================================================================
% This subroutine calculates the surface mass balance.
% ====================================================================

% --------------------------------------------------------------------
% Piecewise linear mass balance profile mimicking the observed 
% --------------------------------------------------------------------

% Mass balance gradient beta (m y^-1 w.e. m^-1)

balweh = betah2*(sur_obs-ELA);
balweh(1:nelh)=betah1*(sur_obs(1:nelh)-ELA); 

% balweh = balweh + 0.5;
% 
% % Insert mass balance perturbations
% 
% if stop == 1
%     balweh(335:end) = balweh(335:end) + 0.3;
% end

acc_prof = 0.00250*(sur_obs-ELA) + 2.52444;
acc_prof(1:nelh) = 0.00140*(sur_obs(1:nelh)-ELA) + 2.59444;
abl_prof = -0.00550*(sur_obs-ELA) + 2.66776;
abl_prof(1:nelh) = -0.00474*(sur_obs(1:nelh)-ELA) + 2.66776;
mb_prof = acc_prof-abl_prof;
% plot(balweh)
% hold on, plot(mb_prof)

balweh = mb_prof;

% Convert to ice equivalent

balh = balweh./0.91;