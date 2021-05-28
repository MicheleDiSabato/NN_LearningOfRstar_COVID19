function dataset_out = datasetCheck(dataset)
% Checks that in dataset there are no inf or NaN valued data and replaces
% them with the previous data eventually 
% 
% INPUTS
%     dataset                               = struct with fields 
%         .InfettiRegioniOggi            : matrix with data on positive people
%                                          day by day region by region 
%         .OspedalizzatiRegioniOggi      : matrix with data on ospedalizedpeople
%                                          day by day region by region
%         .beta_colors_RegioniOggi       : matrix with data on severity of
%                                          restrictions number day by day region by region
%         .VariazionePositiviRegioniOggi : 
%
%         .DecedutiRegioniOggi           :
%
%         .TerapiaIntensivaRegioniOggi   :
%
%         .TamponiRegioniOggi            : matrix with data on number of tests 
%                                          day by day region by region
%         .RstarRegioniOggi              : matrix with data on Rstar value 
%                                          day by day region by region
%
% OUTPUTS
% 
%    dataset_out  = same struct as input but without any Inf or NaN 
% 

disp('Checking Dataset...')
fprintf('\n')

%% 
% Inizialization 
NumMatrixes = 8;
cell_array = cell(1,NumMatrixes);

% Construction 
cell_array{1,1} = dataset.InfettiRegioniOggi;
cell_array{1,2} = dataset.OspedalizzatiRegioniOggi;
cell_array{1,3} = dataset.beta_colors_RegioniOggi;
cell_array{1,4} = dataset.VariazionePositiviRegioniOggi;
cell_array{1,5} = dataset.DecedutiRegioniOggi;
cell_array{1,6} = dataset.TerapiaIntensivaRegioniOggi;
cell_array{1,7} = dataset.TamponiRegioniOggi;
cell_array{1,8} = dataset.RstarRegioniOggi;

%% Check

for index = 1 : NumMatrixes
    IsNAN = isnan(cell_array{1,index});
    IsINf = isinf(cell_array{1,index});
    Errors = IsNAN + IsINf;
    check = sum(sum( Errors ));
    if check > 0
        disp(' ERROR NAN OR INF ')
        disp('  sostituisco Inf con il precedente valore ')
        disp('  sostituisco NaN con il precedente valore ')
        
        for i= 1:size(cell_array{1,index},2)
            for j= 2:size(cell_array{1,index},1)
                if Errors(j,i) > 0
                    if isnan(cell_array{1,index}(j-1,i))
                        cell_array{1,index}(j,i) = cell_array{1,index}(j-2,i);
                    else
                        cell_array{1,index}(j,i) = cell_array{1,index}(j-1,i);
                    end
                end
            end
        end
        
        disp('   - error solved')
        fprintf('\n')
    else 
        disp('   - checked')
        fprintf('\n')
    end
end

%% Riassegno le matrici

dataset_out.InfettiRegioniOggi = cell_array{1,1} ;
dataset_out.OspedalizzatiRegioniOggi = cell_array{1,2} ;
dataset_out.beta_colors_RegioniOggi = cell_array{1,3} ;
dataset_out.VariazionePositiviRegioniOggi = cell_array{1,4} ;
dataset_out.DecedutiRegioniOggi = cell_array{1,5} ;
dataset_out.TerapiaIntensivaRegioniOggi = cell_array{1,6} ;
dataset_out.TamponiRegioniOggi = cell_array{1,7} ;
dataset_out.RstarRegioniOggi = cell_array{1,8} ;

% END ---------------------------------------------------------------------
disp('...Dataset checked')
fprintf('\n')


end
