% addpath("/home/neuromedia/SLANTbrainSeg-updated/matlab");
run('config.m') %read configs

resultsPath = 'tmp/untransFinalPredPath';
refrencePath = [dataDir filesep 'mni/seg'];

resSublist = dir([resultsPath filesep '*.nii']);
refSublist = dir([refrencePath filesep '*.nii']);

% map = [ 2, 2;     %Left-Hippocampus
%        4, 1;     %Right-Hippocampus
%         3, 4;     %left-Amygdala
%         6, 3;     %Right-Amygdala
%         5, 38;     %left-Putamen
%         10, 39;     %Right-Putamen
%         7, 42;     %left-Pallidum
%         14, 43;     %Right-Pallidum
% %         11, 4;     %left-CWM
% %         22, 54;     %Right-CWM
%         13,  49];     %3rd-Ventricle
% %         19, 13;     %Left-Precuneus
% %         38, 52;   %Right-Precuneus
% %         23, 44;      %left CorpusCallosum
% %         46,44];       %Right CorpusCallosum

map = [ 2, 17;     %Left-Hippocampus
       4, 53;     %Right-Hippocampus
        3, 18;     %left-Amygdala
        6, 54;     %Right-Amygdala
        5, 12;     %left-Putamen
        10, 51;     %Right-Putamen
        7, 13;     %left-Pallidum
        14, 52;     %Right-Pallidum
        11, 7;     %left-CWM
        22, 46;     %Right-CWM
        13,  14;     %3rd-Ventricle
        34, 1007;    %Left-Fusiform
        17, 2007;    %Right-Fusiform
        19, 1025;     %Left-Precuneus
        38, 2025;   %Right-Precuneus
        23, 1004;      %left CorpusCallosum
        46, 2004;   %Right CorpusCallosum
        29, 10;       % Left Thalamus
        58, 49];       % Right Thalamus
    
DCs = zeros(length(resSublist), length(map(:,1)));

%for each MR image 
for i = 1:length(resSublist)
    fprintf("preparing image: %d - \n", i)
    resPath = [resSublist(i).folder filesep resSublist(i).name] ;
    refPath = [refSublist(i).folder filesep refSublist(i).name] ;
    
    resMRImg = niftiread(resPath);
    refMRImg = niftiread(refPath);
%     refMRImg = imrotate(refMRImg, 180);
%     refMRImg = imrotate3(refMRImg, 180, [0, 0, 1]);
    fprintf("rotating image\n")
%     refMRImg = rotator(refMRImg);
%     compareVis(resMRImg, refMRImg,40);
    
    fprintf("computing average dice coeff\n");
    
    for j=1:length(map(:,1))    %for each designated label in SLANT
        sl = map(j,1);
        fl = mapSLANT2FS(sl, map);   %map slant label to corresponding FS lbl
        
        resFlag = flagger(resMRImg, sl);
        refFlag = flagger(refMRImg, fl);
        compareVis(resFlag, refFlag, 50);
        
        comb = single(resFlag) + single(refFlag);

        intersec = length(find(comb==2));

        diceCoeff = ((2*(intersec))/(length(find(resFlag==1))+length(find(refFlag==1))))*100;

%         fprintf("DICE COEFF: %d percent", diceCoeff);
        DCs(i, j) = diceCoeff;
    end
    
    SmplBasedADC = mean(DCs, 2);
    lblBasedADC = mean(DCs, 1);
    
end

function res = mapSLANT2FS(lbl, map)
         
          %SLANT, FS
    index = find(map(:,1)==lbl);
    if isempty(index) 
        res = 0;
    else
        res = map(index, 2);
    end
end

function resFlag = flagger(img, lbl)
    resFlag = img;
    resFlag(resFlag ~= lbl) = 0;
    resFlag(resFlag == lbl) = 1;
end

function compareVis(resImg, refImg, slice)
%     if isempty(slice); slice = 128; end
    if nargin < 3; slice = 84; end
    figure(2);
    subplot(1,2,1);
    imshow(resImg(:,:,slice),[])
    title('Result image');

    subplot(1,2,2);
    imshow(refImg(:,:,slice),[])
    title('Reference image');
end
function res = rotator(img)
    figure(1);
    res = zeros(size(img));
    for i = 1:size(img, 3)
        res(:,:,i) = flipdim(img(:,:,i), 2);
        imshow(res(:,:,i), [])
    end
end