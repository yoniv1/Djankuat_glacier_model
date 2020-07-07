% ======================================================================
% This is a script to check for the steady state criterion.
% ======================================================================

% Steady state if volume change is < 0.002% per unit time (y)

if time > 1
    if stop == 0;
        if vol_years(time)-vol_years(time-1) < vol_years(time)*0.00002;
            steady_state_time = vol_years(time);
            disp(sprintf('Steady state time is after %d years',steady_state_time));
            stop = 1;
        end
    end
end
