function [Normal, Abnormal] = SplitStatus(InputArr)
Groups = findgroups(InputArr{:, 1});
ArrGrouped = splitapply( @(varargin) varargin, InputArr, Groups);
SubTables = cell(size(ArrGrouped, 1));
for i = 1:size(ArrGrouped, 1)
    SubTables{i} = table(ArrGrouped{i, :}, 'VariableNames', InputArr.Properties.VariableNames);
end
Abnormal = SubTables{1,1};
Normal = SubTables{2,1};
% This function identifies the rows with abnormal or normal and puts
% them into two seperate tables
end