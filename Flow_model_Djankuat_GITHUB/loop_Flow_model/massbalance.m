% ====================================================================
% This subroutine calculates the surface mass balance.
% ====================================================================

% --------------------------------------------------------------------
% Piecewise linear mass balance profile mimicking the observed 
% --------------------------------------------------------------------

% Parameterize ablation and accumulation gradients

acc_prof = 0.00250*(sur_obs-ELA) + 2.52444;
acc_prof(1:nelh) = 0.00140*(sur_obs(1:nelh)-ELA) + 2.59444;
abl_prof = -0.00550*(sur_obs-ELA) + 2.66776;
abl_prof(1:nelh) = -0.00474*(sur_obs(1:nelh)-ELA) + 2.66776;

mb_prof = acc_prof-abl_prof;
balweh = mb_prof;

% Adjust for debris

if time > 1
    
% Parameterize amount of run-off (RO) that is ice melt (M_ice)

fract_ice = min(-0.001659*(sur_obs-ELA) - 0.021334,1);
fract_ice(1:nelh) = 0;
fract_ice = max(fract_ice,0);

abl_ice = abl_prof.*(fract_ice);

% Amount of run-off (RO) that is meltwater outflow from snowpack (W_snow)

abl_snow = abl_prof.*(1-fract_ice);

% Calculate fdebris

fdebris = exp(-(yearly_h_hist(time-1,:)./hstar));

% Calculate debris-related melt (M*(A_debris/A)*fdebris) + (M*(A-A_debris/A))

debrismelt_debris = abl_ice.*(transpose(debrisarea_d_past(time-1,:))).*(transpose(fdebris));
debrismelt_debrisfree = abl_ice.*(transpose(1-debrisarea_d_past(time-1,:)));
debrismelt = debrismelt_debris + debrismelt_debrisfree;

% New ablation profile

abl_prof_new = abl_snow + debrismelt;

% New mass balance profile

mb_prof_new = acc_prof-abl_prof_new;
balweh = mb_prof_new;

end

% Convert to ice equivalent

balh = balweh./0.91;