% =====================================================================
% This subroutine calculates the diffusion term D for each
% gridpoint given ice thickness (th) and surface elevation (sur). The
% ice can flow in both directions: plus or minus x. This also means
% that ice can grow on isolated places in the model domain.
% =====================================================================

% --------------------------------------------------------------------
% Calculation of diffusion.
% --------------------------------------------------------------------

for i = 2:xnum
    
  % Initialize diffusion 
    
  df(i)=0.0;
  
  % Calculate diffusion
  
  if(th(i)~=0.0)
              
    te1 = (wbed(i)+((1/2).*mu(i).*th(i)));
    te2 = (rho.*g.*th(i)).^nflow;
    te3 = ((sur(i+1)-sur(i-1))./(2.*deltax)).^(2.0);
    te4 = (fs + (fd.*(th(i).^2)));
    df(i) = te1.*te2.*te3.*te4;
    
  % Diffusivity is zero when ice thickness = 0
    
  else
      
   df(i)=0;
    
  end
  
end

% --------------------------------------------------------------------
% Calculation of velocities
% --------------------------------------------------------------------

for i = 2:xnum
    
  % Initialize velocity 
    
  ud(i)=0.0;
  us(i)=0.0;
  u(i)=0.0;
  usfc(i)=0.0;
  
  % Calculate velocity
  
  if(th(i)~=0.0)
            
    % Internal deformation
    
    Sd1(i) = (-rho.*g.*th(i));
    Sd2(i) = ((sur(i+1)-sur(i-1))./(2.*deltax));
    Sd3(i) = (Sd1(i).*Sd2(i)).^(nflow);
    ud(i) = fd.*(Sd3(i)).*th(i);                 
    
    % Basal sliding
    
    us(i) = (fs.*(Sd3(i)))./(th(i));            
    
   % Vertically averaged horizontal velocity
    
    u(i) = ud(i)+us(i);
    
    % Surface velocity
    
    usfc(i) = us(i) + ((fd.*(nflow+2))./(nflow+1)).*(Sd3(i)).*th(i);
            
    % Set velocity to zero of ice thickness = 0
        
  else
      
   u(i) = 0;
   us(i) = 0;
   ud(i) = 0;
   usfc(i) = 0;
    
  end
    
end
