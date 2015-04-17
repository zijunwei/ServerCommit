% this scripts converts single fisher vectors from **fvs_** files to
% vector valued functions 
% wroks as section 3.2 and generating a series of vti's
% this should include 2 steps:
% 1. convert the structure to matrix
% 2. average and normalization


input_file='/Users/zijunwei/Dev/CVPRIm/DataWangYang/SFV2vectorfunction/fvs_test00001.mat';
output_file='vvf.mat';

load(input_file);

% 1 struct to matrix
fv_vec=[fvs.trajXY ;fvs.trajHog ;fvs.trajHof ;fvs.trajMbh];

% 2.1 accumulate the sum on the row
fv_cum_f=cumsum(fv_vec,2);  % forward
fv_cum_r=cumsum(fliplr(fv_vec),2);

%2.1.1 too large for memeory, subsample every five element
sz_bound=20;
intev=ceil(size(fv_cum_f,2)/sz_bound);

fv_cum_f=fv_cum_f(:,1:intev:end);
fv_cum_r=fv_cum_r(:,1:intev:end);

% 2.2 normalization

fv_cum_f=Zj_Normalization.l2_col(fv_cum_f);
fv_cum_r=Zj_Normalization.l2_col(fv_cum_r);
% save(output_file,'fv_cum','-v7.3');

% CAUTION: for both f and r, fv_cmu(:,i)u < fv_cmu(:,j)u if i<j

% train ranksvm :


X=[fv_cum_f,fv_cum_r]';
%A=gen_pp_simple(size(fv_cum_f,2));
training_file_name='';
%ranksvm from matlab not working, now trying to work with c version
%u=ranksvm(X,A,0.01*ones(size(A,1),1));


