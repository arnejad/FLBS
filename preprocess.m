%PREPROCESS reads the dataset of nifti images and carries out the
%registration, correction, and patch extraction
% Code has been developed in Neuromedia Lab, Research Center for Science and
%   Technology in Medicine, Tehran University of Medical Sciences
%==========================================================================

run('config.m') %read configs

%% PREPROCESS
% Registration
if ~exist(regedPath, 'dir')
    list = dir([dataDir filesep 't1']); list(1) = []; list(1) = [];
    if ~exist(tmp_reged, 'dir'), mkdir(tmp_reged); end
    for i=1:length(list)
        fprintf("registering %s\n", list(i).name);
        registration([list(i).folder filesep list(i).name], tmp_reged);
    end
    
    list = dir(tmp_reged);
    list(1) = []; list(1) = [];
    if ~exist([regedPath filesep 't1'], 'dir'), mkdir([regedPath filesep 't1']); end
    for i=1:length(list)
        % copy the t1 image
        if exist([regedPath filesep 't1' filesep list(i).name '.nii.gz'], 'file'); continue;end
        fprintf("preparing image %d from %d \n", i, length(list))
        fromFile = [tmp_reged filesep list(i).name filesep 'target_processed.nii.gz'];
        toFile = [regedPath filesep 't1' filesep list(i).name '.nii.gz'];
        system(['cp ' fromFile ' ' toFile]);

    end
      %copy the segmentation
%       system(['cp -r ' dataDir filesep 'seg' ' ' regedPath]);
%       system(['rm -r ' tmp_reged]);
end

% registering the segmentation
% run('affine_SegTransformer.m');


% Patch Extraction
list = dir([dataDir filesep 't1']); list(1) = []; list(1) = [];
folderPrepare(patchPath, psegPath);

for i=1:length(list)
    patchExtractor([regedPath filesep 't1' filesep list(i).name '.gz'],...
        [regSegPath filesep list(i).name], patchPath, psegPath)
end


%% SEGMENTATION
% system('conda activate nnUNet');
fp = fopen('tmp/predcommands.sh','w');
for i=1:length(structures)
    structName = convertStringsToChars(structures(i));
    predCmd = ['nnUNet_predict -i ' 'patches'  ...
        filesep structName filesep ' -o ' 'predictions' filesep structName ' -t ' num2str(100 + i) ' -m 3d_fullres -f 0 \n'];
    fprintf(fp,predCmd);
end
    fclose(fp);
