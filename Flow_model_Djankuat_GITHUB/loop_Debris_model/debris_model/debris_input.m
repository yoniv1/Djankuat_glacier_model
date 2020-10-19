% --------------------------------------------------------------------
% Determine the debris input location.
% --------------------------------------------------------------------

% Initialize

inoutdebris = 0;

% Debris input along flow line

inoutdebris(inputlocation_debris) = (depositionrate_debris);

% Debris output at front

inoutdebris(leng./deltax_d) = (((terminusflux_cst).*(balweh(leng./deltax_d).*h_debris(leng./deltax_d)))./(1));

inoutdebris((leng./deltax_d)+1) = (-inoutdebris(leng./deltax_d)); 

