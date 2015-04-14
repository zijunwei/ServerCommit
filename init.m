function init(n_slot,n_total)
% extract single frame fisher vectors from video
%input:
% n_slot current nth slot
% n_total  total number of node used
% 
% usage:
% add vl_feat lib address
run('/home/hzwzijun/Win2015/vlfeat/toolbox/vl_setup.m');


input_dir='/nfs/bigeye/zijun/Winter2015/dt_Hollywood2/trajs';
input_files=get_folders(input_dir);

output_dir='./frame_fvs';
if ~exist(output_dir)
    mkdir(output_dir);
end

gmmModelFile='GMM.mat';



num_files=length(input_files);

num_per_slot=ceil(num_files/n_total);
current_e =min( n_slot*num_per_slot,num_files );
current_s=(n_slot-1)*num_per_slot+1;


%debug output:
fprintf('total number of files: %d \n',num_files);
fprintf('Executing file range %s to %s \n\n',input_files(current_s).name,input_files(current_e).name);

for i=current_s:1:current_e
    % full-name the input file, intermediate file, output files
    proc_dir=fullfile(input_dir,input_files(i).name,'whole');
    s_dtd_output_file=fullfile(proc_dir,'s_dtdFeat.mat');
    save_file=fullfile(output_dir,['fvs_',input_files(i).name,'.mat']);
    
    
    % two-steps: 1. combine all sub_dtd files into one
    %            2. extract the fvs based on single frame
    dt_putin1(proc_dir,s_dtd_output_file);
    sf_fvEncoding(s_dtd_output_file,save_file,gmmModelFile)
end
end
