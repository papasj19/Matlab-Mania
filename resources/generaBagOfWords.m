function [bagOfWords, countTotal] = generaBagOfWords(data)
    % Aquesta funció genera un mapa per cada paraula on es compten les
    % seves ocurrències a les dades d'exemple.
    
    % Pol Muñoz Pastor - La Salle URL (Abril de 2019)
    
    bagOfWords = containers.Map();
    countTotal = 0;
    
    for i = 1:1:size(data)                                      % Per cada missatge
        message = data{i};
        
        for j = 1:1:size(message, 2)                            % Per cada paraula del missatge
            key = message{j};
            
            if ~isempty(key)
                if isKey(bagOfWords, key)                       % Si ja l'haviem inserit, augmentem en 1
                    bagOfWords(key) = bagOfWords(key) + 1;
                    countTotal = countTotal + 1;
                else
                    bagOfWords(key) = 2;                        % Si és nova, comencem a 2 i no a 1 per donar peu al Laplace Smoothing
                    countTotal = countTotal + 2;
                end
            end
        end
    end
end

