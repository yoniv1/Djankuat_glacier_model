% ----------------------------------------------------------------------
% Calculate the CFL criterium
% ----------------------------------------------------------------------

% Determine maximum surface ice velocity

usfc_max = max(usfc);

% Apply CFL criterium for advection problems

if unstable_d == 0
    if deltat_d >= (deltax_d)./(2.*usfc_max);
        disp('Not numerically stable')
        unstable_d = 1;
    end
end
