% initialize all the paramters needed for the entir experiment here.

% brief decription of your useage. we will set up a folder/everything  depending on the
% id: e,g, if id is 'full' every output will be saved with an output
% _full.xxx
params.desc='';
params.id='';

% dimensions of fisher vector, svm parameter length, etc
params.dims=109056;
% how many clips you want to divided a video into, if 0, divide n clips for
% an n frame video
params.vidd=0;



% database specific parameters:

%trajectories folder:
% dut to this specific situation, the input folder seems to be always the
% same : from wangyang's folder, we  comment here
params.traj_dir='';

%save the frame based fisher vectors:
params.framefv_dir='./frame_fvs';
if ~exist(params.framefv_dir,'dir')
   mkdir(params.framefv_dir) 
end


%save the svm functional video descriptor:
params.output=sprintf('./vid_descs%s',params.id);
if ~exist(params.output,'dir')
    mkdir(params.output);
end

% path to the GMM model:
params.gmmModelFile='GMM.mat';



%number of training data:
params.num_tr=823;
% number of testing data:
params.num_tst=884;



% if we need to normalize the final descriptor:
params.IsparamNorm=1;

