% --------------------------------------------------------------------
% Determine the debris advective flux.
% --------------------------------------------------------------------

if nelh > inputlocation_debris
    flux_loop = inputlocation_debris;
elseif nelh < inputlocation_debris
    flux_loop = nelh;
end

for i = flux_loop:xnum_d        
  % Initialize debris flux 
    
  fl_debris(i)=0.0;
  
  % Calculate debris flux
  
  if(h_debris(i)~=0.0)
              
    ted1(i) = 1;
    ted2(i) = usfc(i);
    ted3(i) = h_debris(i);
    fl_debris(i) = ted1(i).*ted2(i).*ted3(i);
      
  else 
      
  fl_debris(i)=0;
  
  end
      
end
