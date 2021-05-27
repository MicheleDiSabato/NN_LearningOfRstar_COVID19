function datasetPlot(Tests,InputsSelected) 
% Plots dataset contained in array of structs -Tests-
%
% INPUTS
%
%    - Tests    = row vector of 21 cells of struct type with fields 
%         .tt         : row vector starting from zero, time of input signals 
%         .uu         : matrix of InputsSelected rows of input signals 
%         .tt_y       : row vector starting from zero, time of output signals 
%         .yy         : row vector of output signal 
%
%    - InputsSelected : which inputs are included in Tests
%

%% Parameters 

% Number of regions
NumberOfRegions = size(Tests,2);

%% Names

% Regions in alphabetic order 
names = {'Abruzzo' 'Basilicata' 'Calabria','Campania'...
         'EmiliaRomagna' 'FriuliVeneziaGiulia' 'Lazio','Liguria'...
         'Lombardia' 'Marche' 'Molise' 'PABolzano','PATrento'...
         'Piemonte' 'Puglia' 'Sardegna' 'Sicilia','Toscana'...
         'Umbria' 'ValleDAosta' 'Veneto' };
     
% Inputs      
inputs = {'Numero di Infetti',...
          'Numero di Ospedalizzati',...
          'Severità delle Restrizioni',...
          'Variazione Positivi',...
          'Deceduti',...
          'Terapia Intensiva',...
          'Tamponi',...
          'Sinusoide',...
          'Coseno' };
      
      
%% General Plot 

% input data 
disp('=====================================================================')
disp('...Plotting Input signals...')
fprintf('\n')

for u = 1:size(InputsSelected,2)
    figure()
    set(gcf, 'color', 'w');
    for i=1:NumberOfRegions
        plot(Tests{1,i}.tt,Tests{1,i}.uu(u,:),'.-')
        hold on
    end
    legend(names(1:4), 'Location', 'NorthWest')
    grid on
    grid minor
    title(inputs{1,InputsSelected(u)})
    subtitle('Daily values from Start Day to Last Day of all regions')
    xlabel('Day')
end


% output data 
disp('=====================================================================')
disp('...Plotting Output signal...')
fprintf('\n')

figure()
set(gcf, 'color', 'w');
for i=1:NumberOfRegions
    plot(Tests{1,i}.tt_y(1,:),Tests{1,i}.yy(1,:) ,'.-')
    hold on
end
title('Rstar')
subtitle('Daily values from Start Day to Last Day of all regions')
xlabel('Day')
grid on
grid minor


% % set x axis
% display_dates = linspace(min(discountsCurve.dates), max(discountsCurve.dates), 12);
% xvals = string(datetime(display_dates, 'ConvertFrom', 'datenum', 'Format', 'MMM yy'));
% xticks(display_dates);
% xtickangle(90);
% xticklabels(xvals);
% 
% % set title and legend
% title('Discounts'' and pseudo-discounts'' curve')
% legend('Discounts', 'Pseudo-discounts', 'Location', 'NorthEast')
% 



%% Specific Plot 

% Inputs 
for u = 1:InputsSelected
    figure()
    for i=1:NumberOfRegions
        subplot(3,7,i)
        plot(Tests{1,i}.tt,Tests{1,i}.uu(u,:),'b.-')
        grid on
        grid minor
        title(names{1,i})
        subtitle('Daily values')
        xlabel('Day')
    end
end

% Outputs
figure()
for i=1:NumberOfRegions
    subplot(3,7,i)
    plot(Tests{1,i}.tt,Tests{1,i}.yy,'r.-')
    grid on
    grid minor
    title(names{1,i})
    subtitle('Daily values')
end

end 

