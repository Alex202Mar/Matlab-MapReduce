function [ErrorRate, Sensitivity, Specificity] = ErrorRateFunc(TestArr, Predictions)
    % This shows us when it incorrectly predicts a result
    % as xor will return a 1 if the tables it's comparing don't math
    % i.e. as long as there isn't 1,1 or 0,0 then the prediction is 
    % wrong and it returns a 1
    IncorrectPredict = xor(TestArr(:,13), Predictions);
    AmountIncorrect = sum(IncorrectPredict(:) == 1);
    ErrorRate = AmountIncorrect/length(TestArr);% Equation for error rate
    FalseNeg = 0;
    FalsePos = 0;
    TrueNeg = 0;
    TruePos = 0;
    % 0 = normal/positive, 1 = abnormal/negative
    % works out the false positives, false negatives
    % and True positives and true negatives
    for i = 1:length(TestArr)
       if TestArr(i,13) == 1 && Predictions(i,1) == 0
           FalsePos = FalsePos + 1;
       elseif TestArr(i,13) == 0 && Predictions(i,1) == 1
           FalseNeg = FalseNeg + 1;
       elseif TestArr(i,13) == 1 && Predictions(i,1) == 1
           TrueNeg = TrueNeg + 1;
       elseif TestArr(i,13) == 0 && Predictions(i,1) == 0
           TruePos = TruePos + 1;
       end
    end
    % Equations to work out sensitivity/ specificity
    Sensitivity = TruePos / (TruePos + FalseNeg);
    Specificity = TrueNeg / (TrueNeg + FalsePos);
end