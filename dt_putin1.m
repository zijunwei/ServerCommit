
function dt_putin1(dir_name,output_file)

dtd_files=dir(fullfile(dir_name,'dtdFeat_*.mat'));

%initialize struct

s_parts=load(fullfile(dir_name,dtd_files(1).name));
s_parts = repmat(s_parts, length(dtd_files), 1 );
for i=2:1:length(dtd_files)
    s_parts(i)=load(fullfile(dir_name,dtd_files(i).name));
    
end
ds=[s_parts.desc_scale];
ts=[s_parts.trajXY_scale];

if (range(ds)~= 0 || range(ts)~=0)
    warning('trajectories in %s is INconsistent!\n',dir_name);
end
% trajXY_scale and desc_scale are done
desc_scale=ds(1);
trajXY_scale=ts(1);

% generate other matrices -- using vertcat
trajHof=vertcat(s_parts.trajHof);
trajHog=vertcat(s_parts.trajHog);
trajMbh=vertcat(s_parts.trajMbh);
trajStat=vertcat(s_parts.trajStat);
trajXY=vertcat(s_parts.trajXY);
trajLen=vertcat(s_parts.trajLen);

save(output_file,'trajHof','trajHog','trajMbh','trajStat','trajXY','trajLen','desc_scale','trajXY_scale','-v7.3');
end


