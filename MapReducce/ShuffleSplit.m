function [Train, Test] = ShuffleSplit(InputArr)
    %Shuffles the rows
    b = InputArr(randperm(size(InputArr, 1)), :);
    %Splits the rows by 70-30
    Len = height(b);
    Tsize = uint16(Len * 0.7);
    i = 1;
    j = 1;
    while i <= Len
        if i <= Tsize
            Train(i,:) = b(i,:);
        elseif i > Tsize
            Test(j,:) = b(i,:);
            j = j + 1;
        end
        i = i + 1;
    end
end
