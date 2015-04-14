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

init(idxs,nTask);


