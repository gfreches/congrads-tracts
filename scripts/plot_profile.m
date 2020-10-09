function mat_subj = plot_profile(area,gradient,test_retest)

file = strcat('/project/3022017.03/excluded_subjects/Gradient_Projections/','/',test_retest,'/',area,'/',area,'_',gradient,'.nii.gz');
structure=niftiread(file);
structure=structure(:,55,:,:);
structure=reshape(structure,[145,145,44]);%z direction is in columns, x in rows
mat_subj=zeros(44,100);
for subject=1:44
    structure_subject = structure(:,:,subject);
    structure_subject(structure_subject==0)=NaN;
    structure_subject=nanmean(structure_subject);
    structure_subject=(structure_subject(~isnan(structure_subject)));
    y1 = linspace(0,1,length(structure_subject));
    y2 = linspace(0,1,100);
    structure_subject = interp1(y1,structure_subject,y2);
    mat_subj(subject,:)=structure_subject;
%     plot(structure_subject);
%     hold on
end
% N = size(mat_subj,1);                                      % Number of ?Experiments? In Data Set
% yMean = mean(mat_subj);                                    % Mean Of All Experiments At Each Value Of ?x?
% ySEM = std(mat_subj)/sqrt(N);                              % Compute ?Standard Error Of The Mean? Of All Experiments At Each Value Of ?x?
% CI95 = tinv([0.025 0.975], N-1);                    % Calculate 95% Probability Intervals Of t-Distribution
% yCI95 = bsxfun(@times, ySEM, CI95(:));              % Calculate 95% Confidence Intervals Of All Experiments At Each Value Of ?x?
% figure
% plot(y2, yMean)                                      % Plot Mean Of All Experiments
% hold on
% plot(y2, yCI95+yMean)                                % Plot 95% Confidence Intervals Of All Experiments
% hold off
% grid
save(strcat('/project/3022017.03/excluded_subjects/Gradient_Projections/',test_retest,'/',area,'/',area,'_',gradient,'.mat'),'mat_subj')  
end

