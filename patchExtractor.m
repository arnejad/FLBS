%PATCHEXTRACTOR extracts the surrounding patch of a structure
%Inputs:
%   t1InpPath:  a string which indicated the path to nii t1 registered image
%   outpath:    Path to the folder that the resulting nii file to be saved
%
% Code has been developed in Neuromedia Lab, Research Center for Science and
%   Technology in Medicine, Tehran University of Medical Sciences
%==========================================================================

function patchExtractor(t1InpPath, segInpPath, t1PatchPath, segPatchPath)

    t1Img = niftiread(t1InpPath);
    segImg = niftiread(segInpPath);
    [~, fileName, ~] = fileparts(t1InpPath);
    fileName = erase(fileName, '.nii');
    
    fprintf("  extracting Amygdala\n")
    patch = t1Img(45:134, 104:145, 40:78);
    seg = segImg(45:134, 104:145, 40:78);
    niftiwrite(patch, [t1PatchPath filesep 'amyg' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep 'amyg' filesep fileName '.nii'], 'Compressed',true)
    
    fprintf("  extracting Putamen\n")
    patch = t1Img(43:137, 95:148, 55:97);
    seg = segImg(43:137, 95:148, 55:97);
    niftiwrite(patch, [t1PatchPath filesep 'put' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep 'put' filesep fileName '.nii'], 'Compressed',true)

    fprintf("  extracting Hippocampus\n")
    patch = t1Img(45:132, 75:130, 35:90);
    seg = segImg(45:132, 75:130, 35:90);
    niftiwrite(patch, [t1PatchPath filesep 'hipp' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep 'hipp' filesep fileName '.nii'], 'Compressed',true)

    fprintf("  extracting Pallidum\n")
    patch = t1Img(40:128, 95:160, 55:95);
    seg = segImg(40:128, 95:160, 55:95);
    niftiwrite(patch, [t1PatchPath filesep 'pall' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep 'pall' filesep fileName '.nii'], 'Compressed',true)
    
    fprintf("  extracting CWM \n")
    patch = t1Img(40:148, 22:110, 15:100);
    seg = segImg(40:148, 22:110, 15:100);
    niftiwrite(patch, [t1PatchPath filesep 'CWM' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep 'CWM' filesep fileName '.nii'], 'Compressed',true)
    
    fprintf("  extracting 3rdVentricle \n")
    patch = t1Img(60:130, 80:140, 50:90);
    seg = segImg(60:130, 80:140, 50:90);
    niftiwrite(patch, [t1PatchPath filesep '3rdVentricle' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep '3rdVentricle' filesep fileName '.nii'], 'Compressed',true)
    
    fprintf("  extracting Fusiform \n")
    patch = t1Img(:,10:160 , 20:130);
    seg = segImg(:,10:160 , 20:130);
    niftiwrite(patch, [t1PatchPath filesep 'fusiform' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep 'fusiform' filesep fileName '.nii'], 'Compressed',true)
    
    fprintf("  extracting Precuneus \n")
    patch = t1Img(45:140, 20:125, 70:145);
    seg = segImg(45:140, 20:125, 70:145);
    niftiwrite(patch, [t1PatchPath filesep 'precuneus' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep 'precuneus' filesep fileName '.nii'], 'Compressed',true)
    
    fprintf("  extracting Corpus Callosum \n")
    patch = t1Img(58:138, 57:192, 60:110);
    seg = segImg(58:138, 57:192, 60:110);
    niftiwrite(patch, [t1PatchPath filesep 'CorpusCallosum' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep 'CorpusCallosum' filesep fileName '.nii'], 'Compressed',true)
    
    fprintf("  extracting Thalamus \n")
    patch = t1Img(40:140,70:160, 60:110);
    seg = segImg(40:140,70:160, 60:110);
    niftiwrite(patch, [t1PatchPath filesep 'Thalamus' filesep fileName '_0000.nii'], 'Compressed',true)
    niftiwrite(seg, [segPatchPath filesep 'Thalamus' filesep fileName '.nii'], 'Compressed',true)
end

