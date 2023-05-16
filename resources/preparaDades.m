function [dadesOut] = preparaDades(dadesIn)
    % Aquesta funci� preprocessa les dades per tal de facilitar l'an�lisi
    % i generalitzaci� d'aquestes
    
    % Pol Mu�oz Pastor - La Salle URL (Abril de 2019)
    
    filterOut = [{'; '}; {': '}; {'&lt;'}; {'&gt;'}; {','}; {'!'}; {'?'}; {'$'}; {'+'}; {'*'}; {'='}; {'&'}; {'#'}; {'>'}; {'<'}; {'\.'}];

    classes = dadesIn{1};
    data = dadesIn{2};
    cells = cell(size(data));
    
    for i =  1:1:size(data)                                                 % Per cada missatge
        cells(i,1) = classes(i);
        cells(i,2) = lower(data(i));                                        % Passem a lowercase
        
        for j = 1:1:size(filterOut, 2)
            cells(i,2) = regexprep(cells(i,2), filterOut(:,j), ' ');        % Treiem car�cters indesitjats
            cells(i,2) = regexprep(cells(i,2), '  ', ' ');
        end
        cells(i,2) = regexprep(cells(i,2), '-', '');                        % Arreglem alguns detalls espec�fics que ens interessa mantenir
        cells(i,2) = regexprep(cells(i,2), ':)', ' :) ');
        cells(i,2) = regexprep(cells(i,2), '  ', ' '); 
        
        cells{i,2} = strsplit(cells{i,2});
    end
    
    dadesOut = cells;
end

