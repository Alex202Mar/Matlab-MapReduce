%% CMP3749M Assignment 2 Big Data
%% Alexander Marshall 17666788
clear;

%% Section 1
%Read in the file then splits it into sperate Normal and Abnormal Tables
NukeSmall = readtable("nuclear_small.csv");
[NormSmall, AbSmall] = SplitStatus(NukeSmall);

%Task 2
% performs calculations/ boxplots on each of the arrays columns
k = "Normal Small";
NSCalcs = Calculations(NormSmall, k);
k = "Abnormal Small";
ASCalcs = Calculations(AbSmall, k);

%Task 3
% Works out the correlation matrix for both of the arrays
NormSmallArr = table2array(NormSmall(:,2:13));
NSCCMatrix = corrcoef(NormSmallArr);

AbSmallArr = table2array(AbSmall(:,2:13));
ASCCMatrix = corrcoef(AbSmallArr);

% The brief is unclear so this is the correlation matrix
% that will be shown in the report that is for the whole data set
NukesmallCor = table2array(NukeSmall(:,2:13));
NukeMatrix = corrcoef(NukesmallCor);

%% Section 2
%Task 4
len = height(NormSmall);
wid = width(NormSmall);
%I do this so i can identify data by 0 for normal and 1 for abnormal
NSmall = zeros(len, wid);
ASmall = ones(len, wid);
NSmall(:,1:12) = NormSmallArr;
ASmall(:,1:12) = AbSmallArr;
WholeArr = vertcat(NSmall, ASmall); % rejoining the datasets
% This uses the shuffle split function to shuffle and split the data set
[Train, Test] = ShuffleSplit(WholeArr);

%Task 5
% Decision Tree
DTree = fitctree(Train(:,1:12), Train(:,13));
view(DTree,'mode','graph')
[PredictDTree, node] = predict(DTree,Test(:,1:12));

%Sens = Sensitivity and Spec = Specificity
[ErrorRateDTree, SensDTree, SpecDTree] = ErrorRateFunc(Test, PredictDTree);

%Support Vector Machine Model
SuppVecModel = fitcsvm(Train(:,1:12), Train(:,13));
gscatter(Train(:,4), Train(:,8), Train(:,13));
[PredictSuppVec, node2] = predict(SuppVecModel, Test(:,1:12));

[ErrorRateSuppVec, SensSuppVec, SpecSuppVec] = ErrorRateFunc(Test, PredictSuppVec);

%Artificial Neural Nework
XTrain = Train(:,1:12);
YTrain = Train(:,13);
net = patternnet(12);
net = train(net,transpose(XTrain),transpose(YTrain));
view(net);
Outputs = net(transpose(Test(:,1:12)));
Outputs = (uint16(Outputs))';

[ErrorRateNN, SensNN, SpecNN]= ErrorRateFunc(Test, Outputs);

%Task 8
t = ('nuclear_big.csv');
ds = tabularTextDatastore('nuclear_big.csv', 'TreatAsMissing', 'NA');
ds.SelectedVariableNames = {'Status', 'Power_range_sensor_1', 'Power_range_sensor_2', 'Power_range_sensor_3', 'Power_range_sensor_4','Pressure_sensor_1', 'Pressure_sensor_2', 'Pressure_sensor_3', 'Pressure_sensor_4', 'Vibration_sensor_1', 'Vibration_sensor_2', 'Vibration_sensor_3', 'Vibration_sensor_4'};
% ^^ this reads in the data set and removes all the text from it
% as well as identifies all the columns by their names

%here i use mapreduce function that calls on two other functions
outds = mapreduce(ds, @mapMapper, @mapReducer);
results = readall(outds);

%stores all the values in a array
Count = results.Value{1};
MeanVal = results.Value{2};
Maximum = results.Value{3};
Minimum = results.Value{4};

%I used lines from this as influence for map reduce
%https://uk.mathworks.com/help/matlab/import_export/using-mapreduce-to-compute-covariance-and-related-quantities.html