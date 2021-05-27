%% ANN learning of R star
close all
clear 
clc

% adding paths 
addpaths;
addpath('C:\Users\famig\Documents\Alessandro\POLIMI\Numerical Analysis adv-EDP\Progetto NAAPDE\model-learning-master_new\model-learning-master\examples\R_estimate')
addpath('C:\Users\famig\Documents\Alessandro\POLIMI\Numerical Analysis adv-EDP\Progetto NAAPDE\model-learning-master_new\model-learning-master\Data_Covid')
addpath('C:\Users\famig\Documents\Alessandro\POLIMI\Numerical Analysis adv-EDP\Progetto NAAPDE\model-learning-master_new\model-learning-master\examples')

%% Generation of the input/output pairs
% Parameters 
opt.do_plot = 0;
opt.do_check = 1;
start_day = [200 260 320];
last_day = [260 320 380]; 
InputsSelected = [2 3 5];

% Dataset generation 
Tests_array = arrayfun(@(x) data_generator_region_function(opt,start_day(x),last_day(x),InputsSelected),1:length(start_day),'UniformOutput',false);

Tests = cell(1,21*length(start_day));
for i =1:length(start_day)
    for j = 1:21
        Tests{1,j+21*(i-1)} = Tests_array{1,i}{1,j};
    end
end


%% Tests Samples
Indexes = randi(60,1,60);
disp(Indexes(1:40))
disp(Indexes(41:60))

%% problem generation
problem = problem_get('R_estimate','R_estimate.ini');
dataset_save(problem, Tests, 'train.mat')

%% Dataset Selection and Plotting 
dataset_def.problem = problem;
dataset_def.type = 'file';
dataset_def.source = 'train.mat;[46,43,13,41,34,52,34,55,26,22,30,16,56,29,16,26,43,25,11,52,36,23]';

train_dataset = dataset_get(dataset_def);
% dataset_plot(train_dataset,problem)

%% Learning model
model_learn('opt_R_estimate.ini')

%% R_estimate_int_N2_hlayF8_dof50_ntrain5_2021-04-28_16-23-12

learned_model_name = 'R_estimate_int_N1_hlayF2_dof13_ntrain4_2021-05-25_14-28-50'; 
ANNmod = read_model_fromfile(problem,learned_model_name);
ANNmod.visualize()

%% ANN model test
% figure();
% output = model_solve(test_solve,ANNmod,struct('do_plot',1));



inputsNames = [1 'Numero di Infetti',...
               2 'Numero di Ospedalizzati',...
               3 'Severità delle Restrizioni',...
               4 'Variazione Positivi',...
               5 'Deceduti',...
               6 'Terapia Intensiva',...
               'Tamponi',...
               'Sinusoide',...
               'Coseno' ];

