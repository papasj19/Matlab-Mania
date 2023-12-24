function [ham, spam] = separaHamSpam(data)
    % Aquesta funci� divideix el conjunt d'exemples en dos conjunts, un
    % dels exemples de la classe ham i l'altre de la classe spam

    % Pol Mu�oz Pastor - La Salle URL (Abril de 2019)

    ham = {};
    spam = {};

    for i = 1:1:size(data)                  % Per cada exemple
        
        if strcmp(char(data(i, 1)), 'ham')  % Distingim segons la classe
            ham(end+1, 1) = data(i, 2);
        else
            spam(end+1, 1) = data(i, 2);
        end
    end
end

