MinimaList = []; % Empty list for sorting minima variables
parameter1 = 1; %Starting values of parameter d
parameter2 = 0.001; %Starting values of parameter j
L=10; %Starting values of parameter L for length
model = mphload('MyModel.mph');%load model
model.param.set('L0', L);
model.sol('sol1').clearSolutionData();

while (parameter1 <10.1)
    model = mphload('MyModel.mph');%load model
    model.sol('sol1').clearSolutionData();
    model.param.set('d',parameter1); %set d value
    model.param.set('j',parameter2);%set j value
    model.study('std1').run; %run study
    model.result('pg6').run(); %run plot of Y(X) 
    model.result.export('plot4').run; %export datafile
    B = importdata('YofX.txt', ' '); %import data
    x = B(:, 1); %separate column x
    Y = B(:, 2);%separate column Y
    TF = islocalmin(Y, 'MinProminence',0.99); %find local min
    n = numel(Y(TF)); %count local min
    plot(x,Y,x(TF),Y(TF),'r*') %plot minima for check
    axis tight
    title(['n=',num2str(n),' d= ',num2str(parameter1),' j= ',num2str(parameter2)])
    drawnow;
    op=['n=',num2str(n),' d= ',num2str(parameter1),' j= ',num2str(parameter2)];
    disp(op);
    if (n==0)
        parameter2=parameter2+0.003;
        model.sol("sol1").clearSolutionData();
    elseif (n > 1)
        parameter2=parameter2-0.004;
        model.sol("sol1").clearSolutionData();
    elseif (n==1)
        d = strrep(num2str(parameter1), '.', '_');
        filename = strcat('YofXMinima',d);
        plot(x,Y,x(TF),Y(TF),'r*') %plot minima for check
        axis tight
        title(['d= ',num2str(parameter1),' j= ',num2str(parameter2)]) %create title with values
        fname = 'C:\Users\UserName\Desktop\MinimaResults';
        saveas(gcf,fullfile(fname, filename),'png');
        MinimaList(end+1,:)=[parameter1,parameter2]; %add d and j value to list
        parameter1 = parameter1 + 0.01;
        parameter2 = 0.001;
        model.sol("sol1").clearSolutionData();
    end
end

