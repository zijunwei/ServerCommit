

function server_wrapper2(n_slot,n_total)
% given the files for single frame fisher vectors from init.m, we are using
% the fisher vectors to learn a single svm data 
%input:
% n_slot current nth slot
% n_total  total number of node used
%






input_files=dir(fullfile(params.framefv_dir,'*.mat'));




num_files=length(input_files);
num_per_slot=ceil(num_files/n_total);
current_e =min( n_slot*num_per_slot,num_files );
current_s=(n_slot-1)*num_per_slot+1;


%debug output:
fprintf('total number of files: %d \n',num_files);
fprintf('Executing file range %s to %s \n\n',input_files(current_s).name,input_files(current_e).name);

for i=current_s:1:current_e
    
    input_file=fullfile(input_dir,input_files(i).name);
    save_file=fullfile(params.output,['desc_',input_files(i).name]);
    sfv2vvfv2(input_file, save_file)
     
end
end
