% ======================================================================
% This is a script to check for the steady state criterion.
% ======================================================================

% Steady state if volume change is < 0.002% per unit time (y)

if vol_index > 1
    if stop == 0;
        if vol_hist(vol_index)-vol_hist(vol_index-1) < vol_hist(vol_index)*0.00002;
            steady_state_time = vol_time(vol_index);
            disp(sprintf('Steady state glacier is reached after %d years',steady_state_time));
            stop = 1;
        end
    end
end
