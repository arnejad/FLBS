% Transforming all corresponding segmentation files according to aladin
% output transformation matrix

run('config.m')

addpath("~/SLANTbrainSeg-updated/matlab")

t1Path =[dataDir '/t1/'];
t1regPath = [regedPath filesep 't1'];
refSegPath = [dataDir '/seg/'];
destPath =regSegPath;

if ~exist(destPath, 'dir'), mkdir(destPath); end

list = dir(t1regPath);

list(1) = []; list(1) = [];

for i=1:length(list)
    fileName = list(i).name(1:end-3);
    fprintf("transforming image %d\n",i);
    cmd_aaa = apply_aladin_affine_via_ants(...
        '/home/neuromedia/SLANT_data/extra/full-multi-atlas/niftyreg/bin',...   % NR_bin
        '/home/neuromedia/SLANT_data/extra/full-multi-atlas/ANTs-bin/bin',...   % ANT_bin
        fullfile(destPath, fileName), ...                   % out_fname
        fullfile(t1Path,  fileName), ...             % in_raw_fname
        fullfile(refSegPath, fileName), ...               % in_seg_fname
        [t1regPath filesep fileName '.gz'],...        % target_fname
        fullfile(destPath, list(i).name), ...                                   % out_dir
        fullfile(destPath, strcat(list(i).name,'_tmp')));                       % tmp_dir
    
    run_cmd_single(cmd_aaa);

end