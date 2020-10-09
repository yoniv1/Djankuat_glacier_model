% =====================================================================
% This program is a simple 1D steady state debris-covered glacier model.
% =====================================================================

% Initialize debris on last glacier gridpoint and foreland deposition

h_debris((leng./deltax_d)) = 0; %%
h_debris((leng./deltax_d)+1) = 0; %%

% --------------------------------------------------------------------
% Loop over time
% --------------------------------------------------------------------

for j_d=1:jmax_d      % jmax

   % ------------------------------------------------------------------
   % Load the debris input 
   % ------------------------------------------------------------------

   debris_input % Input for debris onto the glacier

   % ------------------------------------------------------------------
   % Calculate meltout debris from the ice
   % ------------------------------------------------------------------

   debris_meltout % Calculate meltout

   % ------------------------------------------------------------------
   % Call for subroutine which calculates the debris flux
   % ------------------------------------------------------------------

   debris_flux % Calculate debris flux
          
   % ------------------------------------------------------------------
   % Perform check for stability 
   % ------------------------------------------------------------------
   
   debris_stabilitycheck % Check stability

   % ------------------------------------------------------------------
   % Call for subroutine to calculate the new debris thickness
   % ------------------------------------------------------------------

   debris_thicknesscalc % Calculate new debris thickness
   
   % ------------------------------------------------------------------
   % Write diagnostic output (geometric properties)
   % ------------------------------------------------------------------

   if(mod((j_d),floor(dtdiag_d/deltat_d))==0)
      
      % Save mean debris thickness 
       
      mean_h=(mean(h_debris(inputlocation_debris:leng/deltax_d)));
      mean_h_index = mean_h_index + 1;
      mean_h_hist(mean_h_index) = mean_h;
      mean_h_time(mean_h_index) = time;
      
      % Save debris thickness along flow line
      
      yearly_h=h_debris;
      yearly_h_index = yearly_h_index + 1;
      yearly_h_hist(yearly_h_index,:) = yearly_h;
      yearly_h_time(yearly_h_index) = time;
      
      % Save mean debris thickness at front (30 first gridpoints)
      
      mean_h_front=(mean(h_debris((leng./deltax_d-30):(leng./deltax_d-1))));
      mean_h_front_index = mean_h_front_index + 1;
      mean_h_front_hist(mean_h_front_index) = mean_h_front;
      mean_h_front_time(mean_h_front_index) = time;
      
      % Calculate growth factor for debris area evolution
      
      yearly_growthfactor_area_d_past = max(0,1.17048.*(mean_h_front).^0.62047);
      yearly_growthfactor_area_d_index_past = yearly_growthfactor_area_d_index_past + 1;
      yearly_growthfactor_area_d_hist_past(yearly_growthfactor_area_d_index_past,:) = yearly_growthfactor_area_d_past;
      yearly_growthfactor_area_d_time_past(yearly_growthfactor_area_d_index_past) = time;
      
   % ------------------------------------------------------------------
   % Call for subroutine to calculate the new debris area
   % ------------------------------------------------------------------

   debris_areacalc % Calculate new debris thickness
   
   % ------------------------------------------------------------------
   % Check the time when steady state is reached
   % ------------------------------------------------------------------
   
   debris_steadystatecheck;

   end
end

% ------------------------------------------------------------------
% Update boundary conditions
% ------------------------------------------------------------------

fl_debris(1) = 0;
h_debris(1) = 0;
fl_debris(xnum_d+1) = 0;
h_debris(xnum_d+1) = 0;

% ------------------------------------------------------------------
% Store data debris thickness and area
% ------------------------------------------------------------------

yearly_height_debris(time,:) = yearly_h_hist(time,:);
yearly_fractarea_debris(time,:) = debrisarea_d_past(time,:);
yearly_total_area_debris(time,1:leng/10) = yearly_fractarea_debris(time,1:leng/10).*yearly_wsfc(time,1:leng/10);
yearly_totalglacier_area_debris(time,1) = sum(yearly_total_area_debris(time,:)./100000);
yearly_fractglacier_area_debris(time,1) = yearly_totalglacier_area_debris(time,:)./area_years(:,time);
