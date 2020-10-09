function [ICC_test_mean,ICC_test_interval,ICC_retest_mean,ICC_retest_interval] = ICC_func(area,gradient,type)
test= 'test';
retest='retest';
masksFolder_test     = strcat('/project/3022017.03/excluded subjects/Gradient_Projections/',test,'/',area,'/');
masksFolder_retest     = strcat('/project/3022017.03/excluded subjects/Gradient_Projections/',retest,'/',area,'/');
func_test = readimgfile(strcat(masksFolder_test,area,'_',gradient,'.func.gii'));
func_retest = readimgfile(strcat(masksFolder_retest,area,'_',gradient,'.func.gii'));
func_test = func_test(any(func_test,2),:);
func_retest = func_retest(any(func_retest,2),:);
average_ICC = zeros(1,size(func_test,2));
combinations = combnk(1:size(func_test,2),2);
ICC_test_array = zeros(1,length(combinations));
ICC_retest_array = zeros(1,length(combinations));
switch type
    case 'subjects'
        for i=1:length(combinations)
            ICC_test_array(i) = ICC([func_test(:,combinations(i,1)) func_test(:,combinations(i,2))]);
            ICC_retest_array(i) = ICC([func_retest(:,combinations(i,1)) func_retest(:,combinations(i,2))]);
        end
        ICC_test_interval = bootci(10000, @mean,ICC_test_array);
        ICC_test_mean = mean(ICC_test_array);
        ICC_retest_interval = bootci(10000, @mean,ICC_retest_array);
        ICC_retest_mean = mean(ICC_retest_array);
    case 'sessions'
        for i=1:size(func_retest,2)
            average_ICC(i) = ICC([func_test(:,i) func_retest(:,i)]);
        end
        ICC_test_mean = mean(average_ICC);
        ICC_test_interval =bootci(10000, @mean, average_ICC);
        ICC_retest_interval = [0;0];
        ICC_retest_mean = 0;
        end
end

