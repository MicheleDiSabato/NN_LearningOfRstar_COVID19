function dataset = datasetCheck(dataset)
% Checks that in dataset there are no inf or NaN valued data and replaces
% them with the previous data eventually 
% 
% INPUTS
%     dataset      = struct with fields 
%         .InfettiRegioniOggi        : matrix with data on positive people
%                                      day by day region by region 
%         .beta_colors_RegioniOggi   : matrix with data on severity of
%                                      restrictions number day by day region by region
%         .OspedalizzatiRegioniOggi  : matrix with data on ospedalizedpeople
%                                      day by day region by region
%         .TamponiRegioniOggi        : matrix with data on number of tests 
%                                      day by day region by region
%         .RstarRegioniOggi          : matrix with data on Rstar value 
%                                      day by day region by region
%
% OUTPUTS
% 
%    dataset  = same struct as input but without any Inf or NaN 
% 

disp('Checking Dataset:')
fprintf('\n')

%% Output check 

IsNAN_Rstar = isnan(dataset.RstarRegioniOggi);
IsINf_Rstar = isinf(dataset.RstarRegioniOggi);
Errors_Rstar = IsNAN_Rstar + IsINf_Rstar;
check_Rstar = sum(sum( Errors_Rstar ));
if check_Rstar > 0
    disp(' ERROR NAN OR INF IN R STAR')
    disp('  sostituisco Inf con il precedente valore ')
    disp('  sostituisco NaN con il precedente valore ')

    for i= 1:size(dataset.RstarRegioniOggi,2)
        for j= 2:size(dataset.RstarRegioniOggi,1)
            if Errors_Rstar(j,i) > 0
                dataset.RstarRegioniOggi(j,i) = dataset.RstarRegioniOggi(j-1,i);
            end
        end
    end
    disp('   - Output checked')
    fprintf('\n')
else 
    disp('   - Output checked')
    fprintf('\n')
end

%% Input check

% Infetti ---------------------------------------------------------------------------------------------------------------------------------

IsNAN_inf = isnan(dataset.InfettiRegioniOggi);
IsINf_inf = isinf(dataset.InfettiRegioniOggi);
Errors_inf = IsNAN_inf + IsINf_inf;
check_Infetti = sum(sum( Errors_inf ));
if check_Infetti > 0
    disp(' ERROR NAN OR INF IN INFETTI')
    disp('  sostituisco Inf con il precedente valore ')
    disp('  sostituisco NaN con il precedente valore ')

    for i= 1:size(dataset.InfettiRegioniOggi,2)
        for j= 2:size(dataset.InfettiRegioniOggi,1)
            if Errors_inf(j,i) > 0
                dataset.InfettiRegioniOggi(j,i) = dataset.InfettiRegioniOggi(j-1,i);
            end
        end
    end
    disp('   - First Input checked')
    fprintf('\n')
else 
    disp('   - First Input checked')
    fprintf('\n')
end

% Ospedalizzati ---------------------------------------------------------------------------------------------------------------------------------

IsNAN_Ospedalizzati = isnan(dataset.OspedalizzatiRegioniOggi);
IsINf_Ospedalizzati = isinf(dataset.OspedalizzatiRegioniOggi);
Errors_Ospedalizzati = IsNAN_Ospedalizzati + IsINf_Ospedalizzati;
check_Ospedalizzati = sum(sum( Errors_Ospedalizzati ));
if check_Ospedalizzati > 0
    disp(' ERROR NAN OR INF IN R OSPEDALIZZATI')
    disp('  sostituisco Inf con il precedente valore ')
    disp('  sostituisco NaN con il precedente valore ')

    for i= 1:size(dataset.OspedalizzatiRegioniOggi,2)
        for j= 2:size(dataset.OspedalizzatiRegioniOggi,1)
            if Errors_Ospedalizzati(j,i) > 0
                dataset.OspedalizzatiRegioniOggi(j,i) = dataset.OspedalizzatiRegioniOggi(j-1,i);
            end
        end
    end
    disp('   - Second Input checked')
    fprintf('\n')
else 
    disp('   - Second Input checked')
    fprintf('\n')
end

% Beta colors---------------------------------------------------------------------------------------------------------------------------------

IsNAN_colors = isnan(dataset.beta_colors_RegioniOggi);
IsINf_colors = isinf(dataset.beta_colors_RegioniOggi);
Errors_colors = IsNAN_colors + IsINf_colors;
check_colors = sum(sum( Errors_colors ));
if check_colors > 0
    disp(' ERROR NAN OR INF IN R BETA COLORS')
    disp('  sostituisco Inf con il precedente valore ')
    disp('  sostituisco NaN con il precedente valore ')

    for i= 1:size(beta_colors_RegioniOggi,2)
        for j= 2:size(beta_colors_RegioniOggi,1)
            if Errors_colors(j,i) > 0
                dataset.beta_colors_RegioniOggi(j,i) = dataset.beta_colors_RegioniOggi(j-1,i);
            end
        end
    end
    disp('   - Third Input Checked')
    fprintf('\n')
else 
    disp('   - Third Input Checked')
    fprintf('\n')
end

% Tamponi ---------------------------------------------------------------------------------------------------------------------------------

IsNAN_Tamponi = isnan(dataset.TamponiRegioniOggi);
IsINf_Tamponi = isinf(dataset.TamponiRegioniOggi);
Errors_Tamponi = IsNAN_Tamponi + IsINf_Tamponi;
check_Tamponi = sum(sum( Errors_Tamponi ));
if check_Tamponi > 0
    disp(' ERROR NAN OR INF IN R TAMPONI')
    disp('  sostituisco Inf con il precedente valore ')
    disp('  sostituisco NaN con il precedente valore ')

    for i= 1:size(dataset.TamponiRegioniOggi,2)
        for j= 2:size(dataset.TamponiRegioniOggi,1)
            if Errors_Tamponi(j,i) > 0
                dataset.TamponiRegioniOggi(j,i) = dataset.TamponiRegioniOggi(j-1,i);
            end
        end
    end
    disp('   - Forth Input Checked')
    fprintf('\n')
else 
    disp('   - Forth Input Checked')
    fprintf('\n')
end

% Variazione Positivi ---------------------------------------------------------------------------------------------------------------------------------

IsNAN = isnan(dataset.VariazionePositiviRegioneOggi);
IsINf= isinf(dataset.VariazionePositiviRegioneOggi);
Errors = IsNAN + IsINf;
check = sum(sum( Errors ));
if check > 0
    disp(' ERROR NAN OR INF IN R TAMPONI')
    disp('  sostituisco Inf con il precedente valore ')
    disp('  sostituisco NaN con il precedente valore ')

    for i= 1:size(dataset.VariazionePositiviRegioneOggi,2)
        for j= 2:size(dataset.VariazionePositiviRegioneOggi,1)
            if Errors(j,i) > 0
                dataset.VariazionePositiviRegioneOggi(j,i) = dataset.VariazionePositiviRegioneOggi(j-1,i);
            end
        end
    end
    disp('   - Fifth Input Checked')
    fprintf('\n')
else 
    disp('   - Fifth Input Checked')
    fprintf('\n')
end

% Deceduti ---------------------------------------------------------------------------------------------------------------------------------

IsNAN = isnan(dataset.DecedutiRegioniOggi);
IsINf= isinf(dataset.DecedutiRegioniOggi);
Errors = IsNAN + IsINf;
check = sum(sum( Errors ));
if check > 0
    disp(' ERROR NAN OR INF IN DecedutiRegioniOggi')
    disp('  sostituisco Inf con il precedente valore ')
    disp('  sostituisco NaN con il precedente valore ')

    for i= 1:size(dataset.DecedutiRegioniOggi,2)
        for j= 2:size(dataset.DecedutiRegioniOggi,1)
            if Errors(j,i) > 0
                dataset.DecedutiRegioniOggi(j,i) = dataset.DecedutiRegioniOggi(j-1,i);
            end
        end
    end
    disp('   - Sixth Input Checked')
    fprintf('\n')
else 
    disp('   - Sixth Input Checked')
    fprintf('\n')
end

% Terapie Intensive ---------------------------------------------------------------------------------------------------------------------------------

IsNAN = isnan(dataset.TerapiaIntensivaRegioniOggi);
IsINf= isinf(dataset.TerapiaIntensivaRegioniOggi);
Errors = IsNAN + IsINf;
check = sum(sum( Errors ));
if check > 0
    disp(' ERROR NAN OR INF IN TerapiaIntensivaRegioniOggi')
    disp('  sostituisco Inf con il precedente valore ')
    disp('  sostituisco NaN con il precedente valore ')

    for i= 1:size(dataset.TerapiaIntensivaRegioniOggi,2)
        for j= 2:size(dataset.TerapiaIntensivaRegioniOggi,1)
            if Errors(j,i) > 0
                dataset.TerapiaIntensivaRegioniOggi(j,i) = dataset.TerapiaIntensivaRegioniOggi(j-1,i);
            end
        end
    end
    disp('   - TerapiaIntensivaRegioniOggi Input Checked')
    fprintf('\n')
else 
    disp('   - TerapiaIntensivaRegioniOggi Input Checked')
    fprintf('\n')
end



end

