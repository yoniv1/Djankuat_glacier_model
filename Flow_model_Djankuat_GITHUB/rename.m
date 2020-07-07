% Rename variables

yearly_totalglacier_fractarea_debris = transpose(debris_ar_years);
yearly_mean_height_debris = transpose(mean_h_hist);
yearly_mean_front_height_debris = transpose(mean_h_front_hist);
yearly_length_glacier = leng_years;
yearly_area_glacier = area_years;

clearvars yearly_h yearly_h_index yearly_h_hist yearly_h_time debrisarea_d_past yearly_fractglacier_area_debris ...
    yearly_growthfactor_area_d_hist_past yearly_growthfactor_area_d_index_past yearly_growthfactor_area_d_past ...
    yearly_growthfactor_area_d_time_past mean_h_front mean_h_front_hist mean_h_front_index mean_h_front_time ...
    mean_h_hist mean_h_index mean_h_time area_years leng_years