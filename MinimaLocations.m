xMinLocations = []; %Empty list for storing locations along line and parameters d, j
load('Data.mat'); %Load stored data to reevaluate automatically
A = Data;
d = A(:,1);
j = A(:,2);
for i = 1:90 %length of your data, can use numel(j) or numel(d)
    model = mphload('MyModel.mph');%load model
    model.sol('sol1').clearSolutionData();
    model.param.set('j0',j(i));%set j value
    model.param.set('d',d(i)); %set d value
    model.study('std1').run; %run study
    model.result('pg6').run(); %run plot 
    model.result.export('plot4').run; %export plot data
    B = importdata('PlotData.txt', ' '); %import data
    TF = isempty(B); % Ensure plot is not empty
    dn = num2str(d(i)); %For printing error message if plot is empty
    if (TF == 1)
        ms =['Plot is empty for ',dn];
        disp(ms);
        i=i+1;
        break
    end
    x = B(:,1); %separate column x
    Y = B(:,2);%separate column Y
    [TF1,P] = islocalmin(Y, 'MinProminence',0.99); %find local min with prominence of 0.99
    xall = x(TF1); % Store all minima in xall
    xmin = unique(xall); % Store for unique values of x
    disp(dn); % display parameter d
    disp(xmin); % display unique values of locations x
    plot(x,Y,x(TF1),Y(TF1), 'r*') %plot minima for check
    axis tight;
    for idx=1:numel(xmin)
        xMinLocations(end+1,:)=[d(i),j(i),xmin(idx)]; %add delta and j value to list
    end
end