function mapMapper(t,~,intermKVStore)
  % Gets the data from table and removes any rows with missing values
  x = t{:,2:13};

  % works out variable
  n = size(x,1);
  m = mean(x,1);
  ma = x;
  mi = x;

  % Stores values in the intermediate key value store
  add(intermKVStore,'key',{n,m,ma,mi})
end