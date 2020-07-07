% =====================================================================
% Plot model output.
% =====================================================================

% --------------------------------------------------------------------
% Glacier profile along flowline
% --------------------------------------------------------------------

% Plot bedrock and surface elevation

figure(1);

subplot(2,2,[1 2]);
plot(x(1:max_x_plot),sur_obs(1:max_x_plot),'b','LineWidth',2);
hold on;
plot(x(1:max_x_plot),sur(1:max_x_plot),'--r','LineWidth',2);
hold on;
plot(x(1:max_x_plot),bed(1:max_x_plot),'k','LineWidth',2,'Color',[0.7, 0.2, 0]);
title('Surface and bedrock elevation along the flow line');
xlabel('Distance along flow line (m)');
ylabel('Elevation (m)'); 
legend('Surface elevation (observed)', 'Surface elevation (model)', 'Bedrock elevation');
xlim([0 (max_x_plot*deltax)]);
grid on;
hold off
subplot(2,2,3);
scatter(th(1:xnum_plot+1),th_obs(1:327),'filled');
box on;
hold on;
b1=1;
plot_x = linspace(0,250,25);
plot_y = b1*plot_x;
plot(plot_x,plot_y,'r--','LineWidth',2);
grid on;
xlabel('Modeled ice thickness (m)');
ylabel('Measured ice thickness (m)');
title('Measured vs. modeled ice thickness','fontweight','bold');
legend('Ice thickness','1:1 line','Location','NorthWest');
subplot(2,2,4);
plot(x(1:xnum_plot+1),th_obs(1:xnum_plot+1),'b','LineWidth',2),
hold on
plot(x(1:xnum_plot+1),th(1:xnum_plot+1),'r','LineWidth',2);
xlabel('Distance along flow line (m)');
ylabel('Ice thickness (m)');
legend('Observed','Modelled');
grid on;
xlim([-10 (xnum_plot*deltax)]);
title('Measured vs. modeled ice thickness','fontweight','bold')

% --------------------------------------------------------------------
% Glacier geonetry evolution
% --------------------------------------------------------------------

% Plot geometry change with time

figure(2);

subplot(1,2,1);
plot(leng_time,leng_hist,'b','LineWidth',2);
grid on;
xlabel('Time (years)');
ylabel('Length (m)');
title('Glacier length with time');
subplot(1,2,2);
plot(area_time,(area_hist/1e6),'b','LineWidth',2);
grid on;
xlabel('Time (years)');
ylabel('Area (km²)');
title('Glacier area with time');

% --------------------------------------------------------------------
% Glacier ice flux and diffusivity along the flowline
% --------------------------------------------------------------------

% Plot ice flux Q and diffusivity D

figure(3);

subplot(1,2,1)
plot(x(1:xnum_plot+1),fl(1:xnum_plot+1),'r','LineWidth',2), 
xlabel('Distance along flow line (m)'), 
ylabel('Ice volume flux (m^3 y^-^1)'), 
ylim_curr = get(gca,'ylim'); 
ylim_curr(1) = 0;
set(gca,'ylim',ylim_curr)
xlim([0 (xnum_plot*deltax)]);
title('Vert. avg. ice volume flux')
grid on;
subplot(1,2,2)
plot(x(1:xnum_plot+1),df(1:xnum_plot+1),'r','LineWidth',2);
xlabel('Distance along flow line (m)');
ylabel('Diffusivity (m^3 y^-^1)');
title('Vert. avg. diffusivity')
xlim([0 (xnum_plot*deltax)]);
grid on;

% ------------------------------------------------------------------------
% Ice velocities
% ------------------------------------------------------------------------

figure(4);

plot(x(1:xnum_plot+1), u(1:xnum_plot+1),'r','LineWidth',1.5);
hold on
plot(x(1:xnum_plot+1), usfc(1:xnum_plot+1),'LineWidth',1.5,'Color','b');
xlabel('Distance along flow line (m)');
ylabel('Ice flow velocity (m y^-^1)');
title('Ice flow velocitiy','fontweight','bold');
ylim([0 100]);
xlim([-10 (xnum_plot*deltax)]);
legend('Vert. avg. horz. velocity (mod)','Surface velocity (mod)','Location','NorthEast');
grid on;

% Plot geometry

figure(5);

plot((x(1:xnum_plot+1,:)),wbed(1:xnum_plot+1,:)+(mu(1:xnum_plot+1,:).*th(1:1:xnum_plot+1,:)),'b','LineWidth',2);
box on;
grid on;
hold on,
plot(x(1:max_x_plot),wbed(1:max_x_plot),'k','LineWidth',0.5),
xlim([0 (max_x_plot*deltax)]);
ylabel('Width (m)');
legend('Surface width (mod)','Bed width');
xlabel('Distance along flow line (m)');
title('Width of Djankuat glacier along the flow line','fontweight','bold');