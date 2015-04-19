% this scripts converts single fisher vectors from **fvs_** files to
% vector valued functions
% wroks as section 3.2 and generating a series of vti's
% this should include 2 steps:
% 1. convert the structure to matrix
% 2. average and normalization
function sfv2vvfv2(input_file, output_file,sz_bound)
% convert fisher vector for each single frame to a svm-rank parameter
% funcitonal
% input: .mat file containing fisher vector for each single frame
% sz_bound: the number of sub-video fixed.
% output: .mat file contain only 1 100000 by 1 vector representing the
% current video
% 

intermediate_dir='./itermediate';
dat_ext='.dat';
if ~exist(intermediate_dir,'dir')
    mkdir(intermediate_dir);
end
% input_file='/Users/zijunwei/Dev/CVPRIm/DataWangYang/SFV2vectorfunction/fvs_test00001.mat';

[~,input_file_stem,~]=fileparts(input_file);

intermediate_file=fullfile(intermediate_dir,[input_file_stem,dat_ext]);


load(input_file);

% 1 struct to matrix
try
    fv_vec=[fvs.trajXY ;fvs.trajHog ;fvs.trajHof ;fvs.trajMbh];
    
    
    
    % 2.1 accumulate the sum on the row
    fv_cum_f=cumsum(fv_vec,2);  % forward
    fv_cum_r=cumsum(fliplr(fv_vec),2);
    
    %2.1.1 too large for memeory, subsample at most 20 inteverals
    if nargin<3
    intev=1;
    else
    intev=ceil(size(fv_cum_f,2)/sz_bound);
    end
    
    fv_cum_f=fv_cum_f(:,1:intev:end);
    fv_cum_r=fv_cum_r(:,1:intev:end);
    
    % 2.2 normalization
    
    fv_cum_f=Zj_Normalization.l2_col(fv_cum_f);
    fv_cum_r=Zj_Normalization.l2_col(fv_cum_r);
    
    
    
    
    training_file_name=fullfile(intermediate_dir,['p_',input_file_stem,dat_ext]);
    fileID = fopen(training_file_name,'w');
    priority=size(fv_cum_f,2);
    l_feat=size(fv_cum_f,1);
    
    % put forward data into dat file
    for i=1:1:priority
        fprintf(fileID,'%d qid:1 ',priority-i+1);
        for j=1:1:l_feat
            fprintf(fileID,'%d:%0.4f ',j,fv_cum_f(j,priority-i+1));
        end
        fprintf(fileID,'\n');
    end
    
    %put inverse data into dat file
    for i=1:1:priority
        fprintf(fileID,'%d qid:2 ',priority-i+1);
        for j=1:1:l_feat
            fprintf(fileID,'%d:%0.4f ',j,fv_cum_r(j,priority-i+1));
        end
        fprintf(fileID,'\n');
        
    end
    fclose(fileID);
    
    %execute svm_rank_learn:
    cmd=sprintf('./svm_rank/svm_rank_learn -c %f  %s  %s',0.2,training_file_name,intermediate_file);
    unix(cmd);
    
    rank_feat=readParam(intermediate_file);
    save(output_file,'rank_feat','-v7.3')
catch ME
    magicnum=109056;
    rank_feat=zeros(magicnum,1);
    save(output_file,'rank_feat','-v7.3')
    warning('%s is problematic! \n',input_file_stem);
end


