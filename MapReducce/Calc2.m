function [Hold, i] = Calc2(InputArr, Hold, i, k)
    InputArr = sortrows(InputArr);
    LengthArr = height(InputArr);
    %Min
    Hold(i,1) = InputArr(1);
    %Max
    Hold(i,2) = InputArr(LengthArr);
    %Mean
    Hold(i,3) = mean(InputArr);
    %Median
    Median = LengthArr/2;
    Hold(i,4) = InputArr(Median);
    %Mode
    Hold(i,5) = mode(InputArr);
    %Variance
    Hold(i,6) = var(InputArr);
    %Creates Boxplots
    path = "/MATLAB Drive/assessment2/Plots";
    figure(i)
    boxchart(InputArr);
    title(strcat('Box Plot of Column', int2str(i), k))
    saveas(gcf,fullfile(path,strcat(int2str(i), k, 'boxplot')),'png');
    i = i + 1;
end