% ------------------------------------------------------------------------
% This is the main script of the 1D coupled ice flow-debris cover model. 
% Constructed by: Verhaegen et al. (2020) Modelling the evolution of  
% Djankuat Glacier, North Caucasus, from 1752 until 2100 AD 
% ------------------------------------------------------------------------

clear all
close all
delete area_hist_debrisfree.dat leng_hist_debrisfree.dat glacier_surface_width.dat glacier_surface_elevation.dat

% ------------------------------------------------------------------------
% Initialize the flow model for the case of a debris-free glacier 
% ------------------------------------------------------------------------

% Run the model

disp('Initializing the model with a debris-free steady state glacier...')

flow_model = 'loop_Flow_model_debrisfree/Djankuat_main.m';
run(flow_model);

% Save the geomtric variables after steady state

dlmwrite('leng_hist_debrisfree.dat',leng_hist)
dlmwrite('area_hist_debrisfree.dat',area_hist)
dlmwrite('glacier_surface_width.dat',width_steady_state)
dlmwrite('glacier_surface_elevation.dat',sur)

% ------------------------------------------------------------------------
% Impose a debris cover on the glacier 
% ------------------------------------------------------------------------

% Start for loop with debris: insert number of years to be considered

numberofyears = 400;

% Define variables for the debris model

debris_variables;
    
% Execute the loop

disp('Starting the loop for an evovling supraglacial debris cover...')

for time = 1:numberofyears
    
    % Execute flow model
    
    flow_model = 'loop_Flow_model/Djankuat_main.m';
    run(flow_model);
    
    % Execute debris model
    
    debris_model = 'loop_Debris_model/debris_model/Debris_cover_main.m';
    run(debris_model);
    
    % Save geometric variables and debris parameters
    
    leng_years(1,time) = leng;             % Glacier length
    area_years(1,time) = area./1000000;    % Glacier area
    
    debris_th_years(1,time) = mean_h;      % Mean debris thickness glacier
    debris_ar_years = (transpose ...       % Fractional debris-covered area
    (yearly_totalglacier_area_debris) ...
    ./area_years);
    
end

rename;

% ------------------------------------------------------------------------
% Plot output - flow model
% ------------------------------------------------------------------------

flow_plot_output;

% ------------------------------------------------------------------------
% Plot output - debris model
% ------------------------------------------------------------------------

debris_plot_output;

toc

