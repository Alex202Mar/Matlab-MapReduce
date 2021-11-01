function [HoldCalc] = Calculations(InputArr, k)
    HoldCalc = zeros(6,12);
    i = 1;
    % runs all the Calc2 - calculations for each column
    % of both the normal array and abnormal array
    for j = 2:13
        Column = table2array(InputArr(:,j));
        [HoldCalc, i] = Calc2(Column, HoldCalc, i, k);
    end
    HoldCalc = HoldCalc';
    HoldCalc = HoldCalc(1:6,:);
    %output all calculations into an array
end