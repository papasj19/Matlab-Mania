function [hamBagOut, spamBagOut, testOut] = crossDeleteWords(hamBag, spamBag, test)
    % Aquesta funci� elimina dels exemples de train i test les paraules
    % comunes entre els exemples de train de les dues classes.
    
    % Pol Mu�oz Pastor - La Salle URL (Abril de 2019)
    
    hamBagOut = hamBag;
    spamBagOut = spamBag;
    testOut = test;
    
    keys = spamBag.keys;

    for i = 1:1:size(testOut(:,2), 1)                                   % Netegem els espais buits
        testOut(i, 2) = {setdiff(testOut{i, 2}, '')};
    end
    
    for i = 1:1:size(spamBag.keys, 2)                                   % Per cada paraula de spam
        if isKey(hamBagOut, keys{i})                                    % Comprovem si apareix a ham i l'eliminem d'arreu si cal
        	remove(hamBagOut, keys{i});
            remove(spamBagOut, keys{i});
            
            for j = 1:1:size(testOut(:,2), 1)
                testOut(j, 2) = {setdiff(testOut{j, 2}, keys{i})};
            end
        end
    end
end

