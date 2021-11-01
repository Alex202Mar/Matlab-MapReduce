function mapReducer(~,intermValIter,outKVStore)
  
% initialize everything to zero
n1 = 0; 
m1 = 0; 
ma1 = -Inf(1,12);
maHold = zeros(1,12);
mi1 = Inf(1,12);
miHold = zeros(1,12);

while hasnext(intermValIter)
    % Gets the data and extracts the count, mean, min and max
    t = getnext(intermValIter);
    n2 = t{1};
    m2 = t{2};
    maTemp = t{3};
    miTemp = t{4};
    
    % Use the necessary formulas to update the values
    n = n1+n2;                     
    m = (n1*m1 + n2*m2) / n;     
    for i = 1:12
        maHold(1,i) = max(maTemp(:,i));
    end
    ma1 = max(ma1, maHold);
    
    for i = 1:12
        miHold(1,i) = min(miTemp(:,i));
    end
    mi1 = min(mi1, miHold);
    
    m1 = m;
    n1 = n;
end

  % Saves the results in the output key value store
  add(outKVStore,'count',n1);
  add(outKVStore,'mean',m1);
  add(outKVStore,'max',ma1);
  add(outKVStore,'min',mi1);
end