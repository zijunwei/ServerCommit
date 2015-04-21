% qsub -t 1-50:1 ./matlab.sh m_qsub2
nTask  = 50;
TaskIDStr = getenv('SGE_TASK_ID');
if ~isempty(TaskIDStr)
    taskID = str2double(TaskIDStr);
else
    error('No task ID specified');
end


 
TaskStepStr = getenv('SGE_TASK_STEPSIZE');
if ~isempty(TaskStepStr)
    taskStep = str2double(TaskStepStr);
else
    error('No task step specified');
end




idxs = taskID:min(taskID + taskStep - 1, nTask);

%debug
fprintf('taskID : %.02f \n ', taskID);
fprintf('taskStep : %.02f \n',taskStep);
fprintf('idxs is from  %d to %d \n',idxs(1),idxs(end));

initParams;
% either do the first step: convert the dense trajectories to frame based
% fisehr vectors
server_wrapper1(idxs,nTask);

% or do the second step: convert fisher vectors into svm functional for
% each video:
% server_wrapper2(idxs,nTask);

