% ====================================================================
% This subroutine calculates the surface mass balance.
% ====================================================================

% --------------------------------------------------------------------
% Mass balance profile 
% --------------------------------------------------------------------

% Mass balance (m y^-1 w.e. m^-1)

balweh = betah2*(sur_obs-ELA);
balweh(1:nelh) = betah1*(sur_obs(1:nelh)-ELA); 

%% Adjust for debris

if time > 1
    
% Parameterize amount that is ice melt (M_ice)

abl_ice = zeros(size(balweh));

abl_ice(1:nelh) = 0;
abl_ice(nelh+1:end) = balweh(nelh+1:end);

% Calculate fdebris

fdebris = exp(-(yearly_h_hist(time-1,:)./hstar));

% Calculate debris-related melt (M*(A_debris/A)*fdebris) + (M*(A-A_debris/A))

debrismelt_debris = abl_ice.*(transpose(debrisarea_d_past(time-1,:))).*(transpose(fdebris));
debrismelt_debrisfree = abl_ice.*(transpose(1-debrisarea_d_past(time-1,:)));
debrismelt = debrismelt_debris + debrismelt_debrisfree;

% New mass balance profile

mb_prof_new = zeros(size(balweh));

mb_prof_new(1:nelh) = balweh(1:nelh);
mb_prof_new(nelh+1:end) = debrismelt(nelh+1:end);

balweh = mb_prof_new;

end

% Convert to ice equivalent

balh = balweh./0.91; 
