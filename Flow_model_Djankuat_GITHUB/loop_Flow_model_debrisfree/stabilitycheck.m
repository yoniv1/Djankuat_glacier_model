% =======================================================================
% This subroutine performs a check for the numerical stability
% =======================================================================

% ----------------------------------------------------------------------
% Calculate the CFL criterium
% ----------------------------------------------------------------------

% Determine average diffusivity (m^3 y^-1)

di = mean(abs(df(2:xnum+1)))/mean(wbed(2:xnum+1)+(mu(2:xnum+1).*th(2:xnum+1)));

% Apply CFL criterium

if unstable == 0
    if deltat >= ((deltax).^2)./(4.*di);
        disp('Not numerically stable')
        unstable = 1;
    end
end
