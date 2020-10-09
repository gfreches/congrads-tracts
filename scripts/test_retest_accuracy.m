function [correlations,percent] = test_retest_accuracy(area,type,gradient,basis,neighbors,error)
test= 'test';
retest='retest';
masksFolder_test     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/',test,'/',area,'/',type,'/');
masksFolder_retest     = strcat('/vol/neuroecology-scratch/guifre/Segmentation_Data_Driven/test-retest/Gradient_Averages/',retest,'/',area,'/',type,'/');
masksFolder_test_raw     = strcat('/project/3022017.03/excluded subjects/Gradient_Projections/',test,'/',area,'/');
masksFolder_retest_raw     = strcat('/project/3022017.03/excluded subjects/Gradient_Projections/',retest,'/',area,'/');
if error=='error'
    kind = '.error';
else
    kind = '.tsm.yhat';
end
if type == 'lin'
    func_test = readimgfile(strcat(masksFolder_test,area,'_',gradient,'.Basis_',basis,kind,'.func.gii'));
    func_retest = readimgfile(strcat(masksFolder_retest,area,'_',gradient,'.Basis_',basis,kind,'.func.gii'));
    func_test = func_test(any(func_test,2),:);
    func_retest = func_retest(any(func_retest,2),:);
    elseif type=='sph'
        if error=='error'
            kind = '.error';
        else
            kind = '';
        end
        func_test = readimgfile(strcat(masksFolder_test,area,'_',gradient,'.Basis_',basis,kind,'.func.gii'));
        func_retest = readimgfile(strcat(masksFolder_retest,area,'_',gradient,'.Basis_',basis,kind,'.func.gii'));
        func_test = func_test(any(func_test,2),:);
        func_retest = func_retest(any(func_retest,2),:);
    else
        func_test = readimgfile(strcat(masksFolder_test_raw,area,'_',gradient,'.func.gii'));
        func_retest = readimgfile(strcat(masksFolder_retest_raw,area,'_',gradient,'.func.gii'));
        func_test = func_test(any(func_test,2),:);
        func_retest = func_retest(any(func_retest,2),:); 

end
correlations = zeros(size(func_test(2)));
for i = 1:size(func_test,2)
    for j = 1:size(func_retest,2)
        correlations(i,j) = corr(func_test(:,i),func_retest(:,j));
    end
end
percent = 0;
for k = 1:size(correlations,2)
    sorted = sort(correlations(k,:),'descend');
    if ismember(correlations(k,k),sorted(1:neighbors))
        percent = percent+1;
    end
end
percent = (percent/size(correlations,2))*100;

