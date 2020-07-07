% --------------------------------------------------------------------
% Determine the debris input location.
% --------------------------------------------------------------------

% Initialize

inoutdebris = 0;

% Debris input along flow line

if time >= tdebris && yearly_wsfc(time,inputlocation_debris) > wsfc_xinput_tdebris*width_shrinkage
    
inoutdebris(inputlocation_debris) = (depositionrate_debris);

end

% Debris output at terminus

inoutdebris(leng./deltax_d) = (((terminusflux_cst).*(balweh(leng./deltax_d).*h_debris(leng./deltax_d)))./(1));

inoutdebris((leng./deltax_d)+1) = (-inoutdebris(leng./deltax_d)); 
