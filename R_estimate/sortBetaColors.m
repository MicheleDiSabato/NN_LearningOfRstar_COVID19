function BetaColors_sorted = sortBetaColors(BetaColors)
% Sorts Beta Colors table in alphabetic order on region names 
%
% INPUTS
%     BetaColors        : table to be sorted 
%
% OUTPUTS 
%     BetaColors_sorted : sorted table 
%

% Inizialization of auxialiary matrix 
Aux = zeros(height(BetaColors), width(BetaColors)-2);

% From table to matrix 
BetaColors_matrix = table2array(BetaColors(:,2:end));

% Sorting 
Aux(:,1)=BetaColors_matrix(:,12);
Aux(:,2)=BetaColors_matrix(:,16);
Aux(:,3)=BetaColors_matrix(:,17);
Aux(:,4)=BetaColors_matrix(:,14);
Aux(:,5)=BetaColors_matrix(:,7);
Aux(:,6)=BetaColors_matrix(:,5);
Aux(:,7)=BetaColors_matrix(:,11);
Aux(:,8)=BetaColors_matrix(:,6);
Aux(:,9)=BetaColors_matrix(:,3);
Aux(:,10)=BetaColors_matrix(:,10);
Aux(:,11)=BetaColors_matrix(:,13);
Aux(:,12)=BetaColors_matrix(:,20);
Aux(:,13)=BetaColors_matrix(:,21);
Aux(:,14)=BetaColors_matrix(:,1);
Aux(:,15)=BetaColors_matrix(:,15);
Aux(:,16)=BetaColors_matrix(:,19);
Aux(:,17)=BetaColors_matrix(:,18);
Aux(:,18)=BetaColors_matrix(:,8);
Aux(:,19)=BetaColors_matrix(:,9);
Aux(:,20)=BetaColors_matrix(:,2);
Aux(:,21)=BetaColors_matrix(:,4);

% From Matix to table 
BetaColors_sorted  = array2table(Aux);

end