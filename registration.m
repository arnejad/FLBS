%REGISTRATION transforms the nii input image according to the MNI-305
%             standard
%Inputs:
%   inPath:  a string which indicated the path to nii t1
%   outPath:    Path to the folder that the resulting nii file to be saved
%
% Code has been developed in Neuromedia Lab, Research Center for Science and
%   Technology in Medicine, Tehran University of Medical Sciences
%==========================================================================

function registration(inPath, outPath)
    
    addpath('dep');
    extra_dir = '/home/neuromedia/SLANT_data/extra';

    % set up locations
    in.atlas_loc = [extra_dir filesep 'full-multi-atlas' filesep 'atlas-processing' filesep];
    in.ants_loc = [extra_dir filesep 'full-multi-atlas' filesep 'ANTs-bin' filesep];
    in.mni_loc = [extra_dir filesep 'full-multi-atlas' filesep 'MNI' filesep];
    in.niftyreg_loc =  [extra_dir filesep 'full-multi-atlas' filesep 'niftyreg' filesep 'bin' filesep];

    % tic;
    preproc_pipline(inPath, outPath, in);
    
end

