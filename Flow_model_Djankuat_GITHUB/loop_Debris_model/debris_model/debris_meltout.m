% --------------------------------------------------------------------
% Calculation of meltout of debris from the ice.
% --------------------------------------------------------------------

for i = 2:xnum_d
	if balweh(i) < 0 
        meltout_debris(i) = (concentration_debris.*balweh(i)) / ((1-phi_debris).*rho_debris);
    elseif balweh(i) >= 0
        meltout_debris(i) = 0;
    end
end

meltout_debris(1)=0;