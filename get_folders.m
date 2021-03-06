function folders = get_folders(path)
% this function just get the non-hidden folders(may be empty)
folders = dir(path);

for k = length(folders):-1:1
    % remove non-folders
    fname = folders(k).name;
    if fname(1) == '.' || ~folders(k).isdir
        folders(k) = [];
        continue;
    end
end
end