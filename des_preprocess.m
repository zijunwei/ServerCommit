clear;
data_dir='./vid_descs';

num_tr=823;
num_tst=884;

trFiles=dir(fullfile(data_dir,'*train*'));
tstFiles=dir(fullfile(data_dir,'*test*'));

trfilepattern='desc_fvs_train%.05d.mat.mat';
tstfilepattern='desc_fvs_test%.05d.mat.mat';
magicnum=109056;

% get tstFiles into a single matrix:
trD=zeros(magicnum,num_tr);
tstD=zeros(magicnum,num_tst);
for i=1:1:num_tst
    file_name=fullfile(data_dir,sprintf(tstfilepattern,i));
    if exist(file_name,'file')
        load(file_name);
    else
         rank_feat=-1*ones(magicnum,1);
    end
        tstD(:,i)=rank_feat;
    
end
for i=1:1:num_tr
    file_name=fullfile(data_dir,sprintf(trfilepattern,i));
    if exist(file_name,'file')
        load(file_name);
    else
         rank_feat=-1*ones(magicnum,1);
    end
        trD(:,i)=rank_feat;
    
end