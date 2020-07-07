% =====================================================================
% This subroutine calculates the new ice thickness given the diffusion
% =====================================================================

% ---------------------------------------------------------------------
% Calculation of flux
% ---------------------------------------------------------------------

% Calculate flux on staggered grid points from diffusivity

for i=2:xnum+1;
    
  fl(i) = -((df(i-1)+df(i))/2.0)*((sur(i)-sur(i-1))/(deltax));

end

% ---------------------------------------------------------------------
% Calculation of final term for prognostic ice thickness change
% ---------------------------------------------------------------------

for i=2:xnum
    
  % Initialize
    
  thini(i) = th(i);
  
  % Calcualte flux gradient on normal grid points

  term1(i) = -((fl(i+1)-fl(i))/deltax);
  
  % Mass balance profile in ice equivalent
  
  term2(i) = balh(i);
  
  % Geometric term for surface width
  
  term3(i) = wbed(i)+(mu(i)*th(i));
  
  % Calculate new ice thickness
  
  th(i) = thini(i) + deltat*((term1(i)/term3(i)) + term2(i));
  
  % Ice thickness to 0 if too small
  
  if(th(i)<0.00001)
    th(i)=0.0;
  end
  
end
