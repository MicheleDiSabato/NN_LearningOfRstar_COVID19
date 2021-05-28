function datasetPlot(Tests,InputsSelected,dates,opt) 
% Plots dataset contained in array of structs -Tests-
%
% INPUTS
%
%    - Tests                 row vector of 21 cells of struct type with fields 
%         .tt              : row vector starting from zero, time of input signals 
%         .uu              : matrix of InputsSelected rows of input signals 
%         .tt_y            : row vector starting from zero, time of output signals 
%         .yy              : row vector of output signal 
%
%    - InputsSelected      : which inputs are included in Tests
%    - dates                 struct with datestr of the first and last da of Tests
%         .start_day_str   : datestr of first date 
%         .last_day_str    : datestr of last date 
%    - opt                 : struct of flags 
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
      
% set x axis
M=7;

first = datenum(dates.start_day_str);
last = datenum(dates.last_day_str);

num = last-first;
period = (num-mod(num,M))/M;

display_dates = linspace(first,last,period);
xvals = datestr(display_dates,'dd/mm/yy');

display_dates = display_dates - first;

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
    xticks(display_dates);
    xtickangle(90);
    xticklabels(xvals);
    legend([names(1:4) '...'], 'Location', 'Northwest')
    grid on
    grid minor
    title(inputs{1,InputsSelected(u)})
    subtitle('Daily values from Start Day to Last Day of all regions')
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
xticks(display_dates);
xtickangle(90);
xticklabels(xvals);
legend([names(1:4) '...'], 'Location', 'NorthWest')
title('Rstar')
subtitle('Daily values from Start Day to Last Day of all regions')
grid on
grid minor

disp('=====================================================================')


%% Specific Plot 

if opt.do_specificPlot == 1
    
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

end 

