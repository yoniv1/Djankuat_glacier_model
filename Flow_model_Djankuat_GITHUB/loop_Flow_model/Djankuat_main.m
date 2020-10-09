%% Ice flow model

% ------------------------------------------------------------------------
% Define constants and parameters
% ------------------------------------------------------------------------

% Physical parameters

rho = 917;                % Density of ice (kg m^-3)
g = 9.81;                 % Gravitational accelaration (m s^-2)

% Flow law

nflow = 3;                % Flow law constant n in Glen's flow law
fd = 6.50e-17;            % Flow parameter for internal deformation (Pa^-3 y^-1)
fs = 3.25e-13;            % Flow paramter for basal flow (Pa^-3 m^2 y^-1)

% ------------------------------------------------------------------------
% Initialize variables
% ------------------------------------------------------------------------

% Numerical paramters

deltax = 10;                      % Horizontal resolution
resolution = deltax;              % Grid resolution in m
deltat = 0.001;                   % Time resolution in years
dtdiag = 1;                       % Time step for diagnostic output
nyears = 1;                       % Number of years per mass balance loop
jmax = floor(nyears/deltat);      % Yearly time index 
jdiag = ceil(jmax*deltat/dtdiag); % Size of diagnostic vector
unstable = 0;                     % Stop if numerically unstable

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
      disp(['Time = ',num2str(time)])
                        
      % Length (m)
      
      leng=(nnz(th)+1)*deltax;
     
      % Area (km2)
      
      area=deltax.*(sum(wbed(1:leng/deltax)+(mu(1:leng/deltax).*th(1:leng/deltax))));

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
               
end % End loop

% Calculate width

wsfc = (wbed(1:leng/deltax)+(mu(1:leng/deltax).*th(1:leng/deltax)));
wsfc(leng/deltax+1:max_x_plot,1)=0;
yearly_wsfc(time,:) = wsfc;
