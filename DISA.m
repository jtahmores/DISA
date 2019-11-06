function [acc,Zs, Zt, As, At] = DISA(Xs, Xt, Ys, Yt0, Yt, options)

% Discriminative and domain invariant subspace alignment for visual tasks 
% Iran Journal of Computer Science (2019)
% Contact us : Samaneh Rezaei (samanehrezaei@it.uut.ac.ir)
% Contact us : Jafar Tahmoresnezhad (tahmores@gmail.com)



alpha = options.alpha;
mu = options.mu;
beta = options.beta;
k = options.k;
T = options.T;

m = size(Xs,1);
ns = size(Xs,2);
nt = size(Xt,2);

class = unique(Ys);
C = length(class);

  
    dim = size(Xs,1);
    meanTotal = mean(Xs,2);
    


    Sws = zeros(dim, dim);
    Sbs = zeros(dim, dim);
    P=zeros(2*m,2*m);
    for i=1:C
        Xi = Xs(:,find(Ys==class(i)));
        meanClass = mean(Xi,2);
        Hi = eye(size(Xi,2))-1/(size(Xi,2))*ones(size(Xi,2),size(Xi,2));
        Sws = Sws + Xi*Hi*Xi'; % calculate within-class scatter 
        Sbs = Sbs + size(Xi,2)*(meanClass-meanTotal)*(meanClass-meanTotal)'; % calculate between-class scatter
    end
    Ps = zeros(m,m);
    Ps = Sbs;
    P(1:m,1:m)=Ps;
    Qs = Sws;



    for t = 1:T
        % Construct MMD matrix
        [Ms, Mt, Mst, Mts] = constructMMD(ns,nt,Ys,Yt0,C);
        Ts = Xs*Ms*Xs';
        Tt = Xt*Mt*Xt';
        Tst = Xs*Mst*Xt';
        Tts = Xt*Mts*Xs';
        % Construct centering matrix
        Ht = eye(nt)-1/(nt)*ones(nt,nt);
        X = [zeros(m,ns) zeros(m,nt); zeros(m,ns) Xt];    
        H = [zeros(ns,ns) zeros(ns,nt); zeros(nt,ns) Ht];%baraye inke aabad kone
        

     
%%%%%%%%%%%%%calculate laplacian matrix 

Ws = constructW(Xs');   
Label = unique(Ys);
nLabel = length(Label);

Ww = zeros(ns,ns);
   for idx=1:nLabel
   classIdx = find(Ys==Label(idx));
   Ww(classIdx,classIdx) = 1;
    end
 
 Ws1=Ww.*Ws;


DCol = full(sum(Ws1,2));  
Ds = spdiags(DCol,0,speye(size(Ws1,1)));  
Ls= Ds - Ws1;    
   
Wt = constructW(Xt');
DCol = full(sum(Wt,2));%WT1
Dt = spdiags(DCol,0,speye(size(Wt,1)));
Lt = Dt - Wt;

%%%%%%%%%%%%%%%%%%%%


        Smax = mu*X*H*X'+beta*P;
        Smin = [Ts+alpha*eye(m)+beta*Qs+0.05*Xs*Ls*Xs', Tst-alpha*eye(m) ; ...
                Tts-alpha*eye(m),  Tt+(alpha+mu)*eye(m)+0.05*Xt*Lt*Xt'];
        [W,~] = eigs(Smax, Smin+1e-9*eye(2*m), k, 'LM');
        As = W(1:m, :);
        At = W(m+1:end, :);
        
        Zs = As'*Xs;
        Zt = At'*Xt;
        
        if T>1
            Yt0 = knnclassify(Zt',Zs',Ys,1);  
            acc = length(find(Yt0==Yt))/length(Yt); 
            fprintf('acc of iter %d: %0.4f\n',t, full(acc));
        end
    end
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   


