clear;
% add vl_feat lib address
run('/home/hzwzijun/matlablibs/vlfeat/toolbox/vl_setup.m');


input_dir='/nfs/bigeye/zijun/Winter2015/dt_Hollywood2/trajs';
input_files=dir(input_dir);
output_dir='/nfs/bigeye/zijun/Winter2015/frame_fvs';
gmmModelFile='GMM.mat';
num_files=length(input_files);
for i=1:1:num_files
    % full-name the input file, intermediate file, output files
    proc_dir=fullfile(input_dir,input_files(i).name,'whole');
    s_dtd_output_file=fullfile(proc_dir,'s_dtdFeat.mat');
    save_file=fullfile(output_dir,['fvs_',input_files(i).name,'.mat']);
    
    
    % two-steps: 1. combine all sub_dtd files into one
    %            2. extract the fvs based on single frame
    dt_putin1(proc_dir,s_dtd_output_file);
    sf_fvEncoding(s_dtd_output_file,save_file,gmmModelFile)
end
