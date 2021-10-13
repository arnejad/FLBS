%POSTPROCESS combines the obtained labels for different segmentes into a
%single pre-registration nifti file
%
% Code has been developed in Neuromedia Lab, Research Center for Science and
%   Technology in Medicine, Tehran University of Medical Sciences
%==========================================================================

run('config.m') %read configs

samplesList = dir([dataDir filesep 't1']); samplesList(1) = []; samplesList(1) = [];

for i=1:length(samplesList)     %for each sample
    sampFinalSeg = zeros(172, 220, 156);
    
    % combine predictions
    for s=1:length(structures)
        structName = convertStringsToChars(structures(s));
        segImg = niftiread([predPath filesep structName filesep samplesList(i).name '.gz']);
        sampFinalSeg = combineSegs(sampFinalSeg, resize(segImg, structures(s), lableFactors));
        imshow(sampFinalSeg(:,:,60),[])
    end
    
    %resolve overlaps
    sampFinalSeg = overlapConv(sampFinalSeg);
    if ~exist(untransFinalPredPath, 'dir'), mkdir(untransFinalPredPath); end
    niftiwrite(sampFinalSeg, [untransFinalPredPath filesep samplesList(i).name]);
    
    %transform back to initial image space
%     fprintf("transforming image to initial space %d\n",i);
%     affineSegTransformBack(samplesList(i).name, dataDir, untransFinalPredPath, resPath);
end
