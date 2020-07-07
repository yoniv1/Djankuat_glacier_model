% ======================================================================
% This is a script to check for the steady state criterion.
% ======================================================================

% Steady state if debris thickness change is < 0.002% per unit time (y)

if mean_h_index > 41
    if stop_d == 0;
        if abs(mean_h_hist(mean_h_index)-mean_h_hist(mean_h_index-40)) < mean_h_hist(mean_h_index)*0.00002;
            steady_state_time = mean_h_time(mean_h_index);
            disp(sprintf('Steady state debris cover is reached after %d years',steady_state_time));
            stop_d = 1;
        end
    end
end
