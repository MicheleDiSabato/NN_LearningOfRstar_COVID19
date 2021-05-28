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
opt.do_plot = 1;
opt.do_specificPlot = 0;
opt.do_check = 1;
opt.do_normalize = 1;
opt.TrainTestRatio = 0.5;
start_day = [200 250];
last_day = [250 300]; 
InputsSelected = [2 3 5];

[Tests,info] = data_generator_region_function_vectorial(opt,start_day,last_day,InputsSelected);


%% problem generation
problem = problem_get('R_estimate','R_estimate.ini');
dataset_save(problem, Tests, 'train.mat')


%% Dataset Selection and Plotting 
dataset_def.problem = problem;
dataset_def.type = 'file';
dataset_def.source = 'train.mat;[27 13 19 1 42 8 5 16 9 21 15 40 39 3 31 12 18 24 40 18 42]';

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
               7 'Tamponi',...
               8 'Sinusoide',...
               9 'Coseno' ];

