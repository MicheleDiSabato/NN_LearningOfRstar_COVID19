function [Tests,info] = data_generator_region_function(opt,start_day,last_day,InputsSelected)
% Creates the dataset of input output pairs on which the HF model may be
% learned or reduced in order 
% Loads all data from files.csv and create an array of cells in which
% input/otput pairs are stored with the suitable structure to be
% model-learned 
% 
% INPUTS 
%
%     opt              struct of flags 
%         .do_plot         : if Tests should be plotted 
%         .do_specificPlot :
%         .do_tests        : to remove Inf and NaN values from Data
%         .do_normalize    : to normalize inputs wrt regin population
%     start_day            : first day to be considered 
%     last_day             : las day to be considered 
%     InputsSelected       : 
% 
% OUTPUTS
%
%     Tests              row vector of 21 cells of struct type with fields 
%         .tt              : row vector starting from zero, time of input signals 
%         .uu              : matrix of InputsSelected rows of input signals 
%         .tt_y            : row vector starting from zero, time of output signals 
%         .yy              : row vector of output signal 
%
% FUNCTIONS 
%
%   - sortBetaColors       : function that sorts data about severity of
%                            restriction in each region by alphabetic order from the one used in the
%                            repository
%   - datasetCheck         : checks that in the dataset there are no Inf or NaN valued data and replaces
%                            them with the previous data eventually 
%   - datasetPlot          : plots Tests array of I/O pairs
%

% Clock Starts ------------------------------------------------------------

tstart = tic;

% Additional Data ---------------------------------------------------------
   
PopolazioneRegioni_cost = [ 1285256;  547579; 1877728; 5679759; 4445549; 1198753; 5720796; 
                            1509805; 9966992; 1501406;  296547;  520891;  545497; 4273210;
                            3926931; 1598225; 4840876; 3668333;  865013;  123895; 4852453 ];

PopolazioneRegioni_cost = PopolazioneRegioni_cost / 100;
% PopolazioneRegioni_cost = 1./(PopolazioneRegioni_cost / sum(PopolazioneRegioni_cost) *100);                       
                        
PopolazioneRegioni_cost = PopolazioneRegioni_cost * (opt.do_normalize == 1) ...
                          + ones(size(PopolazioneRegioni_cost,1),1) * (opt.do_normalize == 0);
                      
% Dates In Strings ---------------------------------------------------------                      
first_day_str = '24 Feb 2020';
first_day_num = datenum(first_day_str);

start_day_num = first_day_num + start_day;
dates.start_day_str = datestr(start_day_num);

last_day_num = first_day_num + last_day;
dates.last_day_str = datestr(last_day_num);

%% File Loading

% Reading Files Data
myFolder = 'C:\Users\famig\Documents\Alessandro\POLIMI\Numerical Analysis adv-EDP\Progetto NAAPDE\model-learning-master\model-learning-master\Data_Covid\Dati_COVID-19_ProtezioneCivile\COVID-19-master\dati-regioni';
filePattern = fullfile(myFolder, '*.csv'); 
DatiRegioni = dir(filePattern);
BetaColors = readtable('beta_colors.csv');

% Beta Colors Data sorting 
BetaColors = sortBetaColors(BetaColors);

% Reading Files Output Data
Rstar = readtable('R_star.csv'); 


%% Creating the Dataset

% Parameters 
NumberOfRegions = 21;
TotalNumberOfInputs = 9;

% Dati excel
ColonnaItalia = 8;  %--------------------------------------------------------->> % It needs to be skipped

ColonnaInfetti = 11;
ColonnaTamponati = 19;
ColonnaOsp = 9;
ColonnaTerapiaIntensiva = 8;    
ColonnaVariazioneInfetti = 12;  
ColonnaDeceduti = 15;           

% Inizialization 
numberOfAvailableDays = min([height(Rstar) height(BetaColors) length(DatiRegioni) last_day]);
TotalNumDays = numberOfAvailableDays - start_day + 1;
tamponi_ieri = zeros(1,NumberOfRegions);


% Input Data -----------------------------------------------------------------------------------------------------------------------------------
% Inizialization 
dataset.InfettiRegioniOggi = zeros(TotalNumDays,NumberOfRegions);
dataset.OspedalizzatiRegioniOggi = zeros(TotalNumDays,NumberOfRegions);
dataset.VariazionePositiviRegioneOggi = zeros(TotalNumDays,NumberOfRegions);
dataset.DecedutiRegioniOggi= zeros(TotalNumDays,NumberOfRegions);
dataset.TerapiaIntensivaRegioniOggi = zeros(TotalNumDays,NumberOfRegions);
dataset.TamponiRegioniOggi = zeros(TotalNumDays,NumberOfRegions);

% Beta Colors 
dataset.beta_colors_RegioniOggi = table2array(BetaColors);
dataset.beta_colors_RegioniOggi = dataset.beta_colors_RegioniOggi(start_day:last_day,:);

for k = start_day : numberOfAvailableDays
    current_day = k-start_day+1;
    
    baseFileName = DatiRegioni(k).name;
    fullFileName = fullfile(DatiRegioni(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    DataRegionOfToday = readtable(fullFileName);
    
    % Leggo il numero totale di tamponi di ieri se sono al primo giorno 
    if current_day == 1
        baseFileName2 = DatiRegioni(k-1).name;
        fullFileName2 = fullfile(DatiRegioni(k-1).folder, baseFileName2);
        DataRegionOfYesterday = readtable(fullFileName2);
        for j=1:NumberOfRegions 
             tamponi_ieri(j) = table2array(DataRegionOfYesterday(j,ColonnaTamponati)) / PopolazioneRegioni_cost(j) ;
        end
    end 

    for j=1:NumberOfRegions   
        
        % Data reading 
        infetti_today = table2array(DataRegionOfToday(j,ColonnaInfetti)); 
        ospedalizzati_today = table2array(DataRegionOfToday(j,ColonnaOsp));
        tamponi_today = table2array(DataRegionOfToday(j,ColonnaTamponati)) / PopolazioneRegioni_cost(j);
        terapiaIntensiva_today = table2array(DataRegionOfToday(j, ColonnaTerapiaIntensiva ));
        deceduti_today = table2array(DataRegionOfToday(j, ColonnaDeceduti ));
        variazioniPositivi_today = table2array(DataRegionOfToday(j, ColonnaVariazioneInfetti ));

        % Matrix construction 
        dataset.InfettiRegioniOggi(current_day,j)            = infetti_today / PopolazioneRegioni_cost(j);
        dataset.OspedalizzatiRegioniOggi(current_day,j)      = ospedalizzati_today / PopolazioneRegioni_cost(j);
        dataset.TamponiRegioniOggi(current_day,j)            = tamponi_today - tamponi_ieri(j) ;
        dataset.VariazionePositiviRegioniOggi(current_day,j) = variazioniPositivi_today / PopolazioneRegioni_cost(j);
        dataset.DecedutiRegioniOggi(current_day,j)           = deceduti_today / PopolazioneRegioni_cost(j);
        dataset.TerapiaIntensivaRegioniOggi(current_day,j)   = terapiaIntensiva_today / PopolazioneRegioni_cost(j);

        % Aggiorno Tamponi ieri 
        tamponi_ieri(j) = tamponi_today;
        
    end
end

% Output Data ----------------------------------------------------------------------------------------------------------------------------- 
dataset.RstarRegioniOggi = table2array(Rstar);
dataset.RstarRegioniOggi = dataset.RstarRegioniOggi(start_day:last_day,[2:ColonnaItalia ColonnaItalia+2:end]);

% Display ---------------------------------------------------------------------------------------------------------------------------------

disp('=====================================================================')
disp('Data have been succesfully loaded in -Tests-')
disp('=====================================================================')


%% Data Processing 
% Controllo che non ci siano NaN or Inf nel dataset e sostituisco i dati mancanti 

if opt.do_check == 1
    dataset = datasetCheck(dataset);
end


%% Creo il vettore di Tests

% Inizialization 
input = zeros(TotalNumberOfInputs,TotalNumDays);
Tests = cell(1,NumberOfRegions);

% Time vectors
Struct.tt = 0:TotalNumDays-1;
Struct.tt_y = 0:TotalNumDays-1;

% Construction 
for Region = 1:NumberOfRegions
    
    input(1,:) = dataset.InfettiRegioniOggi(:,Region)';
    input(2,:) = dataset.OspedalizzatiRegioniOggi(:,Region)';
    input(3,:) = dataset.beta_colors_RegioniOggi(:,Region)';
    input(4,:) = dataset.VariazionePositiviRegioniOggi(:,Region)';
    input(5,:) = dataset.DecedutiRegioniOggi(:,Region)';
    input(6,:) = dataset.TerapiaIntensivaRegioniOggi(:,Region)';
    input(7,:) = dataset.TamponiRegioniOggi(:,Region)';
    input(8,:) = sin(2*pi*Struct.tt/365);
    input(9,:) = cos(2*pi*Struct.tt/365);
    
    Struct.uu = input(InputsSelected,:);
    Struct.yy = dataset.RstarRegioniOggi(:,Region)';
    
    Tests{1,Region} = Struct;
end

%% Plot of the dataset   

if opt.do_plot == 1
    datasetPlot(Tests,InputsSelected,dates,opt);
end

%% Info Per file "opt_R_estimate.ini "

info = OptFileInfo(Tests);


%% Run Time 

total_time = toc(tstart);

disp('                         ┌─────────┐')
fprintf(' Time to Create -Tests- (s) │  %.2f  │\n', total_time)
disp('                         └─────────┘')
fprintf('\n')

end


