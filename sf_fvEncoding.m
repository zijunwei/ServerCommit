function sf_fvEncoding(dtd_file,save_file,gmmModelFile)
% load trajectory and encode each frame to fisher vector
% fisher vector not normalized at all


% load the dense trajectory file



DTD=load(dtd_file);


if isempty(DTD)
    fvs=[];
    save((save_file),'fvs','-v7.3');
    return;
end;

%Load the pre-learned GMM model
load(gmmModelFile, 'GMM', 'PCA');
descTypes = {'trajXY', 'trajHog', 'trajHof', 'trajMbh'};



ns = size(DTD.trajXY,1);
if ns == 0
    fvs=[];
    save((save_file),'fvs','-v7.3');
    return;
end;

fvs=struct(descTypes{1},[],descTypes{2},[],descTypes{3},[],descTypes{4},[]);
n_frames=length(unique(DTD.trajStat(:,1)));
fvs=repmat(fvs, n_frames, 1 );

DTD.trajXY = double(DTD.trajXY')/DTD.trajXY_scale;
for j=2:length(descTypes)
    DTD.(descTypes{j}) = double(DTD.(descTypes{j})')/DTD.desc_scale;
end;

% Apply PCA and all VL_FEAT for fisher vector encoding
for j=1:length(descTypes)
    % apply PCA first
    PCA_j = PCA.(descTypes{j});
    DTD.(descTypes{j}) = DTD.(descTypes{j}) - repmat(PCA_j.mu, 1, size(DTD.(descTypes{j}),2));
    DTD.(descTypes{j}) = PCA_j.PcaBasis'*DTD.(descTypes{j});
    
    % get fisher vector
    GMM_j = GMM.(descTypes{j});
    idx=1;
    for i=1:1:ns
        f_range=find(DTD.trajStat(:,1)==i);
        if isempty(f_range)
            continue;
        end
    fvs(idx).(descTypes{j}) = vl_fisher(DTD.(descTypes{j})(:,f_range), GMM_j.mus, GMM_j.covs, GMM_j.priors);
    idx=idx+1;
    end
end;

save((save_file),'fvs','-v7.3');
