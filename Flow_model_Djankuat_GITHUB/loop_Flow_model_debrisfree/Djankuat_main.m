% ------------------------------------------------------------------------
% This program is a 1D glacier ice flow model. It uses bedrock geometry
% together with the mass balance for the Djankuat glacier to calculate ice 
% thickness on a grid with spatial resolution deltax.
% ------------------------------------------------------------------------

clear all;
close all;
tic;

% ------------------------------------------------------------------------
% Load input data
% ------------------------------------------------------------------------

load('x_data.mat');              % Horizontal distance (m) as 'x'
load('bed_data.mat');            % Bedrock elevation (m asl) as 'bed'
load('wbed_data.mat');           % Observed bed width (m) as 'wbed'
load('mu_data.mat');             % Sum of tangens of valley angles (-) as 'mu'
load('th_obs_data.mat');         % Observed ice thickness (m) as 'th_obs'
load('sur_obs_data.mat');        % Observed surface elevation (m asl) 'sur_obs'

% ------------------------------------------------------------------------
% Parameter values
% ------------------------------------------------------------------------

% Physical parameters

rho = 917;                % Density of ice (kg m^-3)
g = 9.81;                 % Gravitational accelaration (m s^-2)

% Flow laws

nflow = 3;                % Flow law constant n in Glen's flow law
fd = 6.50e-17;            % Flow parameter for internal deformation (Pa^-3 y^-1) = TUNING PARAMETER
fs = 3.25e-13;            % Flow paramter for basal flow (Pa^-3 m^2 y^-1) = TUNING PARAMETER

% Numerical resolution

deltax = 10;                 % Horizontal resolution
resolution = deltax;         % Grid resolution in m
deltat = 0.001;              % Time resolution in years
dtdiag = 1;                  % Time step for diagnostic output
nyears = 200;                % Number of years in calculation
xnum = nnz(th_obs)+301;      % Number of grid points with ice + 1
xnum_plot = nnz(th_obs)+1;   % Used for plotting
max_x = length(th_obs)+300;  % Length of flow line profile
max_x_plot = length(th_obs); % Used for plotting

% Mass balance profile

ELA = 3191;                       % Equilibrium line altitude (m asl)
betah1 = 0.0056;                  % Mass balance gradient above ELA (vs. elevation h) (m w.e. y^-1 m^-1)
betah2 = 0.0083;                  % Mass balance gradient below ELA (vs. elevation h) (m w.e. y^-1 m^-1)

% Find grid point position of ELA

[~, ela_pos] = min(abs(sur_obs - ELA));
nel_value = sur_obs(ela_pos);
nelh = find(sur_obs==nel_value);  % Grid position of ELA

% ------------------------------------------------------------------------
% Declare variables
% ------------------------------------------------------------------------

% Initialize variables to be calculated

sur = zeros(xnum+1,1);            % Surface elevation (m asl)
df = zeros(xnum+1,1);	          % Diffusivity (m^3 y^-1)
dfperunitwidth = zeros(xnum+1,1); % Diffusivity per unit width (m^2 y^-1)
fl = zeros(xnum+1,1);	          % Ice volume flux (m^3 y^-1)
flperunitwidth = zeros(xnum+1,1); % Ice flux per unit width (m^2 y^-1)
th = zeros(xnum+1,1);		      % Ice thickness (m)
surgrad = zeros(xnum+1,1);        % Surface gradient 
sur = bed;                        % Initialization of ice thickness field (th = 0)
bal = zeros(xnum+1,1);		      % Mass balance (m i.e. y^-1)

% Numerical variables

jmax = floor(nyears/deltat);      % Maximum time index 
jdiag = ceil(jmax*deltat/dtdiag); % Size of diagnostic vector
stop = 0;                         % Warning if steady state is reached
unstable = 0;                     % Warning if numerically unstable

% Initialize geometric variables to be stored

vol_hist = zeros(jdiag,1);        % Diagnostic output: volume
vol_index = 0;
vol_time = zeros(jdiag,1);
leng_hist = zeros(jdiag,1);       % Diagnostic output: length
leng_index = 0;
leng_time = zeros(jdiag,1);
area_hist = zeros(jdiag,1);       % Diagnostic output: area
area_index = 0;
area_time = zeros(jdiag,1);

% --------------------------------------------------------------------
% Loop over time
% --------------------------------------------------------------------

for j=1:jmax      % jmax
   
   % ------------------------------------------------------------------
   % Call for routine which calculates the mass balance profile
   % ------------------------------------------------------------------

   massbalance % Calculate surface mass balance
   
   % ------------------------------------------------------------------
   % Call for subroutine which calculates the diffusive term D
   % ------------------------------------------------------------------

   diffusivity % Calculate diffusion
          
   % ------------------------------------------------------------------
   % Perform check for stability 
   % ------------------------------------------------------------------
   
   stabilitycheck % Check stability

   % ------------------------------------------------------------------
   % Call for subroutine to calculate the new ice thickness
   % ------------------------------------------------------------------

   thicknesscalc % Calculate new ice thickness

   % ------------------------------------------------------------------
   % Write diagnostic output (geometric properties)
   % ------------------------------------------------------------------

   if(mod((j),floor(dtdiag/deltat))==0)
      disp(['Time = ',num2str(j*deltat)])
      
      % Volume (m^3)
      
      vol=((nnz(th))*deltax)*sum(th(2:xnum))*sum(wbed(2:xnum+1)+(mu(2:xnum+1).*th(2:xnum+1))); 
      vol_index = vol_index + 1;
      vol_hist(vol_index) = vol/(1e6);
      vol_time(vol_index) = j*deltat;
            
      % Length (m)
      
      leng=(nnz(th))*deltax;
      leng_index = leng_index + 1;
      leng_hist(leng_index) = leng;
      leng_time(leng_index) = j*deltat;
     
      % Area (km2)
      
      area=deltax.*(sum(wbed(1:leng/deltax)+(mu(1:leng/deltax).*th(1:leng/deltax))));
      area_index = area_index + 1;
      area_hist(area_index) = area;
      area_time(area_index) = j*deltat;
      
   end

   % ------------------------------------------------------------------
   % Renew variables 
   % ------------------------------------------------------------------
   
   sur(2:xnum+1)=bed(2:xnum+1)+th(2:xnum+1);
   
   % ------------------------------------------------------------------
   % Update boundary conditions
   % ------------------------------------------------------------------
   
   df(1) = 0;
   fl(1) = 0;
   th(1) = 0;
   ud(1) = 0;
   us(1) = 0;
   u(1) = 0;
   usfc(1) = 0;
   df(xnum+1) = 0;
   fl(xnum+1) = 0;
   th(xnum+1) = 0;
   ud(xnum+1) = 0;
   us(xnum+1) = 0;
   u(xnum+1) = 0;
   usfc(xnum+1) = 0;
      
   % ------------------------------------------------------------------
   % Check the time when steady state is reached
   % ------------------------------------------------------------------
   
   steadystatecheck;
      
end % End loop

toc

width_steady_state = (wbed(1:leng/deltax)+(mu(1:leng/deltax).*th(1:leng/deltax)));

