%% NAME AND SURNAME OF THE MEMBERS OF THE GROUP:
%MEMBER 1:
%MEMBER 2:
%MEMBER 3:

f = fopen('smsspamcollection/SMSSpamCollection', 'r');                      % Open the file

all = textscan(f, '%s %s', 'delimiter', '\n\t');                            % Read the file separating class and text
fclose(f);   


counter_spam = sum(strcmp(all{1}, 'spam'));		% spam = 747 		                    
counter_ham = sum(strcmp(all{1}, 'ham'));		% ham = 4827
counter_messages = counter_spam + counter_ham;	% messages = 5574	
probability_spam = counter_spam / counter_messages;                     
probability_ham = counter_ham / counter_messages;% Close the file

all = preparaDades(all);                                                    % Clean the data and separate the text by spaces




[train, test] = separaTrainTest(all, 0.8);                                  % Separate the data in train/test subsets

[ham, spam] = separaHamSpam(train);                                         % Separate the training data by class

[hamBag, hamCountTotal] = generaBagOfWords(ham);                            % Generate Bags of Words and total counts
[spamBag, spamCountTotal] = generaBagOfWords(spam);

[hamBag, spamBag, test] = crossDeleteWords(hamBag, spamBag, test);




counter = 0;
length_hx = 0;
length_sy = 0; 
length_hy = 0;
length_sx = 0;
totalHamWords = sum(hamCountTotal);


bagDouble = {};

scorePerMessage = {}; 

sizeTOBE = 0;
sizeham = size(ham);
sizespam = size(spam);

if(sizeham < sizespam)
    sizeTOBE = sizeham;
else
    sizeTOBE = sizespam;
end 

for i=1:1:sizeTOBE
    sentence_h = ham(i);
    [length_hx,length_hy] = size(sentence_h{1,1}); 

    sentence_s = spam(i);
    [length_sx,length_sy] = size(sentence_s{1,1}); 
    
    for j=1:1:length_hy
         word_S_h = sentence_h{1,1};
         word_H = word_S_h(j);

        for k=1:1:length_sy
            word_S_s = sentence_s{1,1};
            word_S = word_S_s(k);


            if strcmp(word_S,word_H) == 1
               counter = counter + 1;
               bagDouble(end+1,1) = word_S;
            end
        end
    end
end

counterFavorHam = 0; 
counterFavorSpam = 0; 
guess = {};

badguess = 0; 
goodguess = 0;
num_guess = 0; 


for i=1:1:size(test)
    the_sentence = test{i,2};
    TSX = 0;
    TSY = 0; 
    [TSX,TSY] = size(the_sentence);

    counterFavorHam = 0;
    counterFavorSpam = 0;
    message_score = 0; 

    for j=1:1:TSY
        the_word = the_sentence(j);

        %for k=1:1:counter
            %compare_word = char(bagDouble(k,1));

            %if(strcmp(the_word,compare_word)==0)
                hamWords = keys(hamBag);

                spamWords = keys(spamBag);

                for l = 1:length(hamWords)
                    ham_word = hamWords{l};

                    if(strcmp(the_word,ham_word)==1)
                        counterFavorHam = counterFavorHam + 1; 
                        
                    end
                end

                for m = 1:length(spamWords)
                    spam_word = spamWords{m};

                    if(strcmp(the_word,spam_word)==1)
                        counterFavorSpam = counterFavorSpam+1; 
                        
                    end

                    %leave this as only this because we want it to evaluate
                    %the both words 
                    if(strcmp(the_word,'specially')==1 || strcmp(the_word,'selected')==1 || strcmp(the_word,'vodafone')==1)
                        counterFavorSpam = counterFavorSpam + 1; 
                        counterFavorHam = counterFavorHam - 1; 
                        
                    end
                    if(strcmp(the_word,'nokia')==1 || strcmp(the_word,'orange')==1 || strcmp(the_word,'vodafone')==1)
                        counterFavorSpam = counterFavorSpam + 1; 
                        counterFavorHam = counterFavorHam - 1; 
                        
                    end

                    if(strcmp(the_word,'free')==1 || strcmp(the_word,'loyal')==1 || strcmp(the_word,'prize')==1 )
                        counterFavorSpam = counterFavorSpam + 1; 
                        counterFavorHam = counterFavorHam - 1; 
                        
                    end

                    if(strcmp(the_word,'collect')==1 || strcmp(the_word,'reward')==1 || strcmp(the_word,'unsubscribe')==1)
                        counterFavorSpam = counterFavorSpam + 1; 
                        counterFavorHam = counterFavorHam - 1; 
                        
                    end

                    if(strcmp(the_word,'callertune')==1 || strcmp(the_word,'mobile')==1)
                        counterFavorSpam = counterFavorSpam + 1; 
                        
                    end

                    if(strcmp(the_word,'www')==1 || strcmp(the_word,'claim')==1)
                        counterFavorSpam = counterFavorSpam + 1; 
                        
                    end


                    if(strcmp(the_word,'offer')==1 || strcmp(the_word,'special')==1 || contains(the_word,'$'))
                        counterFavorSpam = counterFavorSpam + 1; 
                        counterFavorHam = counterFavorHam - 1; 
                        
                    end



                    if(contains(the_word,'£') || contains(the_word,'€'))
                        counterFavorSpam = counterFavorSpam + 5; 
                        
                    end

                    if(isnumeric(the_word)==1)
                        counterFavorSpam = counterFavorSpam + 5; 
                        
                    end

                end


            %end
        
 

       

    end


        final_counter = abs(counterFavorHam-counterFavorSpam);
        disp(the_sentence);
     message_score = final_counter / TSY;
     disp(counterFavorSpam)
        %scorePerMessage(end+1,1) = message_score;
        num_guess = num_guess + 1; 

        %we say it is ham 
        if(counterFavorSpam < 100)


           disp('we say ham');

            if(strcmp(test{i,1},'ham')==1)
                goodguess = goodguess + 1;
            else
                badguess = badguess + 1;
            end
        %it is spam 
        else
            disp('we say spam');

            if(strcmp(test{i,1},'ham')==1)
                badguess = badguess + 1;
            else
                goodguess = goodguess + 1;
            end

        end


        num_disp = abs(goodguess - badguess);

        num_disp = (num_disp / num_guess) * 100;

        disp('The ham score is ')
        disp(counterFavorHam);

         disp('The spam score is ')
        disp(counterFavorSpam);


        
        disp('Currently we are at a prediction rate of : ');
        disp(num_disp);


end







