function [percents] = cycle_through_neighbors(area,type,gradient,neighbors)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
percents = zeros(1,neighbors);
for i=1:neighbors
    [~,percent]=test_retest_accuracy(area,type,gradient,i);
    percents(i)=percent;
end

