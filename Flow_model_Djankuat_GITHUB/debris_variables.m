%% Debris model

leng_years = zeros(1,numberofyears);
area_years = zeros(1,numberofyears);
vol_years = zeros(1,numberofyears);
debris_th_years = zeros(1,numberofyears);
debris_ar_years = zeros(1,numberofyears);

% ----------------------------------------------------------
% Parameter values
% ----------------------------------------------------------

% Variables 

rho_debris = 2600;			          % Density of debris p_debris (kg m^-3)
concentration_debris = 1.05;          % Englacial debris concentratin C_debris (kg m^-3)
phi_debris = 0.43;                    % Porosity of debris material phi_debris (-)
terminusflux_cst = 0.50;              % Manipulate flux into foreland to reach steady state
hstar = 1.15;                         % Characteristic debris thickness H*debris (m)
inputlocation_debris = 168;           % Input location x_debris (grid point, m/deltax)
depositionrate_debris = 0.62;         % Debris input flux F_debris (m yr-1)
load('glacier_surface_width.dat');    % Surface width at x_debris (m)
wsfc_xinput_tdebris = glacier_surface_width(inputlocation_debris);   
tdebris = 1;                          % Time of source release t_debris (y)
width_shrinkage = 0.9;                % Critical width to stop debris contribution

% Grid and time resolution

deltax_d = 10;              	  	       % Horizontal resolution
resolution_d = deltax_d;         	       % Grid resolution in m
deltat_d = 0.005;                     	   % Time resolution in years
dtdiag_d = 1;                              % Time step for diagnostic output
nyears_d = 1;                              % Number of years in calculation
jmax_d = floor(nyears_d/deltat_d);         % Maximum time index 
jdiag_d = ceil(jmax_d*deltat_d/dtdiag_d);  % Size of diagnostic vector
no_gridpoints_d = 640;                     % Total number of grid points
x_data_d = linspace(1,640,640);
xnum_d = no_gridpoints_d - 1;              % Number of grid points - 1
max_x_d = no_gridpoints_d - 1;             % Length of flow line profile - 1
unstable_d = 0;                            % Stop if numerically unstable
stop_d = 0;                                % Stop if steady state

% ------------------------------------------------------------------------
% Declare and initialize variables
% ------------------------------------------------------------------------

% Geometric variables

h_debris =zeros(xnum_d+1,1);                    % Debris thickness
fl_debris = zeros(xnum_d+1,1);	          		% Derbis volume flux
fl_debrisperunitwidth = zeros(xnum_d+1,1);      % Derbis flux per unit width
meltout_debris = zeros(xnum_d+1,1);             % Meltout debris from ice
inoutdebris = zeros(xnum_d+1,1);                % Input and output of debris on flow line
debrisarea_d_past = zeros(numberofyears,no_gridpoints_d);

% Debris parameter values

mean_h = zeros(jdiag_d,1);
mean_h_hist = zeros(jdiag_d,1);          % Diagnostic output: mean debris thickness
mean_h_index = 0;
mean_h_time = zeros(jdiag_d,1);

mean_h_front = zeros(jdiag_d,1);
mean_h_front_hist = zeros(jdiag_d,1);    % Diagnostic output: mean debris thickness
mean_h_front_index = 0;
mean_h_front_time = zeros(jdiag_d,1);

yearly_h = zeros(jdiag_d,xnum_d+1);
yearly_h_hist = zeros(jdiag_d,xnum_d+1); % Diagnostic output: debris thickness along flow line
yearly_h_index = 0;
yearly_h_time = zeros(jdiag_d,xnum_d+1);

% Initialize parameter values for debris

yearly_height_debris = zeros(numberofyears,no_gridpoints_d);
yearly_fractarea_debris = zeros(numberofyears,no_gridpoints_d);
yearly_total_area_debris = zeros(numberofyears,no_gridpoints_d);
yearly_totalglacier_area_debris = zeros(numberofyears,1);
yearly_fractglacier_area_debris = zeros(numberofyears,1);

% Initialize growth factor for debris area change

yearly_growthfactor_area_d_past = zeros(jdiag_d,1);
yearly_growthfactor_area_d_index_past = 0;
yearly_growthfactor_area_d_hist_past = zeros(numberofyears,1);
yearly_growthfactor_area_d_time_past = zeros(jdiag_d,1);
