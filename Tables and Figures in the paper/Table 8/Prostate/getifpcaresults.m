
load('prostate_x.mat');
load('prostate_y.mat');

trueclass = prostatey;
CER = zeros(30,2);

parfor rep=1:30
    
    [label, stats, numselect,signals] = ifpca(prostatex, 2);
    
    predclass = label;
    
    % Calculate CER
    
    n = size(prostatex,2);
    num = 0;
    den = n*(n-1)/2;
    for i= 1:(n-1)
        
        tt = predclass(i)-predclass(i+1:n);
        tt(tt~=0)=1;
        tt = 1-tt;
        dd = trueclass(i)-trueclass(i+1:n);
        dd(dd~=0)=1;
        dd = 1-dd;
        num = sum(abs(tt-dd))+num;
        
    end
    CER(rep,:) = [num/den numselect];
end