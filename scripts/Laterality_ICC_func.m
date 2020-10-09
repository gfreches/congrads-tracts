function[ICC_test,ICC_retest]  = Laterality_ICC_func(area,gradient)
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
        for i=1:length(combinations)
            ICC_test_array(i) = ICC([func_test(:,combinations(i,1)) func_test(:,combinations(i,2))]);
            ICC_retest_array(i) = ICC([func_retest(:,combinations(i,1)) func_retest(:,combinations(i,2))]);
        end
ICC_test=zeros(1,44);
ICC_retest=zeros(1,44);
for subject=1:44
   for combination=1:length(ICC_test_array)
    if combinations(combination,1)==subject || combinations(combination,2)==subject
        ICC_test(subject)=ICC_test(subject)+ICC_test_array(combination);
        ICC_retest(subject)=ICC_retest(subject)+ICC_retest_array(combination);
    end
   end
    ICC_test(subject)=ICC_test(subject)./43;
    ICC_retest(subject)=ICC_retest(subject)./43;
end
end

