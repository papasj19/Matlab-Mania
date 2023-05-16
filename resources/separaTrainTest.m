function [train, test] = separaTrainTest(all, rTrain)
    % Aquesta funci� divideix el conjunt d'exemples en dos conjunts, un
    % d'entrenament i l'altre de comprovaci�, segons el ratio rTrain

    % Pol Mu�oz Pastor - La Salle URL (Abril de 2019)

    tot = all(randperm(size(all, 1)), :);           % Reordenem aleat�riament els exemples

    trainSize = round(rTrain * size(all, 1));       % Calculem el nombre d'exemples d'entrenament

    train = tot(1:1:trainSize, :);                  % Agafem els dos subconjunts
    test = tot(trainSize + 1:1:end, :);

end

