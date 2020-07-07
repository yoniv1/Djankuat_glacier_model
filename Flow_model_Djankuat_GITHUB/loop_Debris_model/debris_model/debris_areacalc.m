%% Parameterize debris area as a function of distance from front (1967/68) based on data from Popovnin et al. (2015)

x_data = linspace(1,640,640);

% Exponential function to determine distance to the front

frontelev_index = leng./10;
endelev_index = 1;
begin_index = no_gridpoints_d;
distfront = linspace(frontelev_index,endelev_index,frontelev_index-endelev_index+1)-1;
distfront(frontelev_index:begin_index) = 0;

%% Parameterize debris area as a function of distance from front (1967/68) based on data from Popovnin et al. (2015)

% Determine evolution of fractional debris area with growth factor 

for i = 1:time
    for n = 1:no_gridpoints_d
        debrisarea_d_past(i,n) = min(1,(yearly_growthfactor_area_d_hist_past(i,1).*(exp(-0.01612.*distfront(n))-0.0172)));
    end
end

% Fractional debris area cannot be outside 0 or 1

for i = 1:time
    for n = 1:no_gridpoints_d
     if debrisarea_d_past(i,n) < 0
            debrisarea_d_past(i,n) = 0;
     end
     if debrisarea_d_past(i,n) > 1
           debrisarea_d_past(i,n) = 1;
     end
    end
end

% Set fractional debris area 0 where debris thickness is 0

for i = 1:time
    for n = 1:no_gridpoints_d
        if yearly_h_hist(i,n) == 0
         debrisarea_d_past(i,n) = 0;
        end
    end
end
