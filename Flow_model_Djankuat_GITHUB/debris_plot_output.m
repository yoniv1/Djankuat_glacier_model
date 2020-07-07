% ------------------------------------------------------------------
% Plot output from the debris model
% ------------------------------------------------------------------

time = linspace(1,time,time);

figure;
subplot(2,2,1)
plot(time,yearly_mean_front_height_debris,'b','LineWidth',1.5);
xlabel('Time (yr)');
ylabel('Mean debris thickness front (m)');
title({'Debris thickness front'; 'evolution with time'});
grid on
box on
ylim([0 yearly_mean_front_height_debris(end)+0.15])

subplot(2,2,2)
plot(x_data(end,1:leng./10).*deltax,yearly_height_debris(end,1:leng./10),'b','LineWidth',1.5);
xlabel('Distance along flow line (m)');
ylabel('Debris thickness (m)');
title({'Steady state debris thickness'; 'along the flow line'});
grid on
box on
xlim([1 leng])

subplot(2,2,3)
plot(time,yearly_totalglacier_fractarea_debris,'b','LineWidth',1.5);
xlabel('Time (yr)');
ylabel('Fractional debris area (-)');
title({'Fractional debris-covered'; 'area evolution with time'});
grid on
box on
ylim([0 yearly_totalglacier_fractarea_debris(end)+0.01])

subplot(2,2,4)
plot(x_data(end,1:leng./10).*deltax,yearly_fractarea_debris(end,1:leng./10),'b','LineWidth',1.5);
xlabel('Distance along flow line (m)');
ylabel('Fractional debris area (-)');
title({'Steady state fractional debris-covered'; 'area along the flow line'});
grid on
box on
xlim([1 leng])