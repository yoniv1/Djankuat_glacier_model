% =====================================================================
% Plot model output.
% =====================================================================

% --------------------------------------------------------------------
% Glacier profile along flowline
% --------------------------------------------------------------------

% Plot bedrock and surface elevation

figure(1);

sur_initial = load('glacier_surface_elevation.dat');

subplot(2,2,[1 2]);
plot(x(1:max_x_plot),sur(1:max_x_plot),'b','LineWidth',2);
hold on;
plot(x(1:max_x_plot),sur_initial(1:max_x_plot),'r--','LineWidth',2);
hold on;
plot(x(1:max_x_plot),bed(1:max_x_plot),'k','LineWidth',2,'Color',[0.7, 0.2, 0]);
title('Surface and bedrock elevation along the flow line');
xlabel('Distance along flow line (m)');
ylabel('Elevation (m)'); 
legend('Surface elevation (debris)', 'Surface elevation (initial)', 'Bedrock elevation');
xlim([0 (max_x_plot*deltax)]);
grid on;
hold off
subplot(2,2,[3 4]);
plot(x(1:(leng./10)+2),th(1:(leng./10)+2),'b','LineWidth',2);
xlabel('Distance along flow line (m)');
ylabel('Ice thickness (m)');
grid on;
xlim([-10 ((2+leng./10)*deltax)]);
title('Modeled ice thickness','fontweight','bold')

% --------------------------------------------------------------------
% Glacier geonetry evolution
% --------------------------------------------------------------------

% Plot geometry change with time

figure(2);

load('leng_hist_debrisfree.dat');
load('area_hist_debrisfree.dat');
area_hist_debrisfree = area_hist_debrisfree./1e6;
leng_years = transpose(yearly_length_glacier);
leng_change = cat(1,leng_hist_debrisfree,leng_years);
area_years = transpose(yearly_area_glacier);
area_change = cat(1,area_hist_debrisfree,area_years);

subplot(1,2,1);
plot(leng_change,'b','LineWidth',2);
grid on;
xlabel('Time (years)');
ylabel('Length (m)');
title('Glacier length with time');
xline(size(leng_hist_debrisfree,1),'k--');
legend('Length','Initiation debris model','Location','SouthEast')
subplot(1,2,2);
plot((area_change/1e6),'b','LineWidth',2);
grid on;
xlabel('Time (years)');
ylabel('Area (km²)');
title('Glacier area with time');
xline(size(area_hist_debrisfree,1),'k--');
legend('Area','Initiation debris model','Location','SouthEast')
