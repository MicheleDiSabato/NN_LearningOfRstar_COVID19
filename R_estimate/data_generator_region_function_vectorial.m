function [Tests,info] = data_generator_region_function_vectorial(opt,start_day,last_day,InputsSelected)

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

% Parameters --------------------------------------------------------------
NumberOfRegions = 21;
len = length(start_day);
SamplesNum = len * NumberOfRegions;
SamplesDiv = round(opt.TrainTestRatio * SamplesNum);


%% Vectorial call at data_generator_region_function

% Tests is generated for all the specified periods of time 
[Tests_array,~] = arrayfun(@(x) data_generator_region_function(opt,start_day(x),last_day(x),InputsSelected),1:len,'UniformOutput',false);

% Final vector of cels Tests is assembled 
Tests = cell(1,NumberOfRegions*length(start_day));
for i =1:length(start_day)
    for j = 1:NumberOfRegions
        Tests{1,j+NumberOfRegions*(i-1)} = Tests_array{1,i}{1,j};
    end
end

% Clearing Command Window ------------------------------------------------
clc


%% Compute global Infos 

info = OptFileInfo(Tests);


%% Randomized sampling for training and tests

Indexes = randi(SamplesNum,1,SamplesNum);

fprintf('\n')
disp('=====================================================================')
disp('Randomized sampling for training and tests:')
disp('=====================================================================')
fprintf('\n')

disp('Training Samples :')
disp(mat2str(Indexes(1:SamplesDiv)))
fprintf('\n')

disp('Tests Samples :')
disp(mat2str(Indexes(SamplesDiv+1:SamplesNum)))
fprintf('\n')

disp('=====================================================================')
fprintf('\n')


%% Run Time 

total_time = toc(tstart);

disp('                         ┌─────────┐')
fprintf(' Time to Create -Tests- (s) │  %.2f  │\n', total_time)
disp('                         └─────────┘')
fprintf('\n')


end
