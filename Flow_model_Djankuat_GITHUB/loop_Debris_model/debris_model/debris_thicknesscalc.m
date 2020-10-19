% ---------------------------------------------------------------------
% Calculation of final term for prognostic debris thickness change
% ---------------------------------------------------------------------

% ---------------------------------------------------------------------
% Calculation of final term for prognostic debris thickness change
% ---------------------------------------------------------------------

for i=2:xnum_d
    
 % Initialize
    
 	 h_debrisini(i) = h_debris(i);

% Calculate for glacier profile 

	if i < (leng./deltax_d)
  
  	% Calcualte flux gradient on normal grid points

 	 term1_debris(i) = -((fl_debris(i)-fl_debris(i-1))/(deltax_d));
  
  	% Meltout of debris material from the ice
  
 	 term2_debris(i) = meltout_debris(i);
       
     % In and output
     
     term3_debris(i) = inoutdebris(i);
  
 	 % Calculate new debris thickness
  
  	 h_debris(i) = h_debrisini(i) + deltat_d*(term1_debris(i) - term2_debris(i) + term3_debris(i));

end
  
% Calculate for terminus point

	if i == (leng./deltax_d);
  	
% Calcualte flux gradient on normal grid points

 	 term1_debris(i) = -((fl_debris(i)-fl_debris(i-1))/(deltax_d));
  
  	% Meltout of debris material from the ice
  
 	 term2_debris(i) = meltout_debris(i);
  
 	 % In and output
  
 	 term3_debris(i) = inoutdebris(i);
	  
 	 % Calculate new debris thickness
  
  	 h_debris(i) = h_debrisini(i) + deltat_d*(term1_debris(i) - term2_debris(i) + term3_debris(i));

    end
    
    % Calculate for first foreland point

	if i == ((leng./deltax_d)+1);
  	
% Calcualte flux gradient on normal grid points

 	 term1_debris(i) = -((fl_debris(i)-fl_debris(i-1))/(deltax_d));
  
  	% Meltout of debris material from the ice
  
 	 term2_debris(i) = meltout_debris(i);
  
 	 % In and output
  
 	 term3_debris(i) = inoutdebris(i);
	  
 	 % Calculate new debris thickness
  
  	 h_debris(i) = h_debrisini(i) + deltat_d*(term1_debris(i) - term2_debris(i) + term3_debris(i));

    end

  	% Debris thickness to 0 if negative
  
  if(h_debris(i)<0)
  	  h_debris(i)=0.0;
  end

end
