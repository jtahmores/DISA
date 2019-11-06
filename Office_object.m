% Discriminative and domain invariant subspace alignment for visual tasks 
% Iran Journal of Computer Science (2019)
% Contact us :  Samaneh Rezaei (samanehrezaei@it.uut.ac.ir)
% Contact us :  Jafar Tahmoresnezhad (tahmores@gmail.com)


clear;close all;
datapath = 'data/';
% Set algorithm parameters
options.k =30;              % subspace base dimension
options.T = 10;             % iterations, default=10
options.alpha=0.5;          % the parameter for subspace divergence ||A-B||
options.mu = 1;             % the parameter for target variance
options.beta = 0.1;         % the parameter for P and Q 
results = [];

srcStrSURF12 = {'Caltech10','Caltech10','Caltech10','amazon',   'amazon','amazon','webcam',  'webcam', 'webcam','dslr',    'dslr',   'dslr'};
tgtStrSURF12 = {'amazon',   'webcam',   'dslr',     'Caltech10','webcam','dslr',  'Caltech10','amazon','dslr',  'Caltech10','amazon','webcam'};



for iData = 1:12

        src = char(srcStrSURF12{iData});
        tgt = char(tgtStrSURF12{iData});
        options.data = strcat(src,'-vs-',tgt);
        fprintf('Data=%s \n',options.data);
       
    


        % load and preprocess data  
        load([ datapath,src '_SURF_L10.mat']);
        Xs = fts ./ repmat(sum(fts,2),1,size(fts,2)); 
        Ys = labels;
        Xs = zscore(Xs);
        Xs = normr(Xs)';

        load([datapath, tgt '_SURF_L10.mat']);
        Xt = fts ./ repmat(sum(fts,2),1,size(fts,2)); 
        Yt = labels;
        Xt = zscore(Xt);
        Xt = normr(Xt)';

  

    Cls = knnclassify(Xt',Xs',Ys,1); 
 
       Yt0 =Cls;
       [acc,Zs, Zt, A, Att] = DISA(Xs, Xt, Ys, Yt0, Yt, options);
       results = [results;acc*100];
fprintf('Accuracy=%.2f ',acc*100);
       

end
fprintf('Mean=%.2f ',results/12);

