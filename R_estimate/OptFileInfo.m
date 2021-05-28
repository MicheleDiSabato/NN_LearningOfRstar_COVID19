function info = OptFileInfo(Tests)
% Computes all Useful Infos that need to be specified in the file opt of
% the example and in the file with the specifics of the problem 
%   - computes bounds 
%   - computes characteristic time 
%   - displays results 
%
% INPUT
%     Tests       : row array of cells containing the samples
%
% OUPUT
%     info         struct with fields:
%        .maxI    : maximum values reached by all the inputs singularly in
%                   the period considered across all regions 
%        .maxO    : maximum values reached by all the outputs singularly in
%                   the period considered across all regions 
%        .minI    : minimun values reached by all the inputs singularly in
%                   the period considered across all regions 
%        .minO    : minimun values reached by all the outputs singularly in
%                   the period considered across all regions 
%        .chTime  : characteristic time of the samples of the dataset
%

%% Data
numInputs = size(Tests{1,1}.uu,1);
numOutputs = size(Tests{1,1}.yy,1);

samples = size(Tests,2);


%% Upper Bounds & Lower Bounds
% Inizialization
min_sampleI = zeros(numInputs,samples);
max_sampleI = zeros(numInputs,samples);
min_sampleO = zeros(numOutputs,samples);
max_sampleO = zeros(numOutputs,samples);

% Computing Bounds on the rows of each sample 
for i = 1:samples 
    
    min_sampleI(:,i) =  min(Tests{1,i}.uu,[],2);
    max_sampleI(:,i) =  max(Tests{1,i}.uu,[],2);
    
    min_sampleO(:,i) =  min(Tests{1,i}.yy,[],2);
    max_sampleO(:,i) =  max(Tests{1,i}.yy,[],2);
    
end

% Computing global bounds 
info.minI = floor(min(min_sampleI,[],2));
info.maxI = max(max_sampleI,[],2);

info.minO = floor(min(min_sampleO,[],2));
info.maxO = max(max_sampleO,[],2);


%% Characteristic time 
info.chTime = size(Tests{1,1}.tt,2);


%% Display 

fprintf('\n')
disp('=====================================================================')
disp('Options to be added in file "opt_R_estimate.ini" :')
disp('=====================================================================')
fprintf('\n')

disp('Numbrer Of Inputs:')
disp(mat2str(numInputs))
fprintf('\n')

disp('Numbrer Of Outputs:')
disp(mat2str(numOutputs))
fprintf('\n')

disp('Upper Bounds for Inputs:')
disp(mat2str(info.maxI))
fprintf('\n')

disp('Lower Bounds for Inputs:')
disp(mat2str(info.minI))
fprintf('\n')

disp('Upper Bounds for Outputs:')
disp(mat2str(info.maxO))
fprintf('\n')

disp('Lower Bounds for Outputs:')
disp(mat2str(info.minO))
fprintf('\n')

disp('Characteristic Time of samples: ')
disp(mat2str(info.chTime))
fprintf('\n')



end