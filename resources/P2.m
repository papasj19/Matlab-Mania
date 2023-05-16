%% NAME AND SURNAME OF THE MEMBERS OF THE GROUP:
%MEMBER 1:
%MEMBER 2:
%MEMBER 3:

f = fopen('smsspamcollection/SMSSpamCollection', 'r');                      % Open the file

all = textscan(f, '%s %s', 'delimiter', '\n\t');                            % Read the file separating class and text
fclose(f);                                                                  % Close the file

all = preparaDades(all);                                                    % Clean the data and separate the text by spaces

[train, test] = separaTrainTest(all, 0.8);                                  % Separate the data in train/test subsets

[ham, spam] = separaHamSpam(train);                                         % Separate the training data by class

[hamBag, hamCountTotal] = generaBagOfWords(ham);                            % Generate Bags of Words and total counts
[spamBag, spamCountTotal] = generaBagOfWords(spam);

[hamBag, spamBag, test] = crossDeleteWords(hamBag, spamBag, test);          % This function filters out repeated words between classes to improve the accuracy.
                                                                            % However, it is pretty slow, so comment it out to run faster tests

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                            %
%  Write your code below this point			 %
%                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%