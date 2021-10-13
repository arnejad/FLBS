% addpath("/home/neuromedia/SLANTbrainSeg-updated/matlab");
run('config.m') %read configs

resultsPath = predPath;
refrencePath = psegPath;
structures = [ "hipp";  "hipp"; "amyg"; "amyg";...
    "put"; "put";"pall"; "pall";"CWM"; "CWM";...
    "3rdVentricle";"fusiform";"fusiform";...
    "precuneus"; "precuneus";"CorpusCallosum";... 
    "CorpusCallosum"; "Thalamus";"Thalamus" ];

map = [ 2, 53;     %Right-Hippocampus
       1, 17;     %Left-Hippocampus
        2, 54;     %Right-Amygdala
        1, 18;     %Left-Amygdala
        2, 51;     %Right-Putamen
        1, 12;     %Left-Putamen
        2, 52;     %Right-Pallidum
        1, 13;     %left-Pallidum
        2, 46;     %Right-CWM
        1, 7;     %Left-CWM
        1,  14;     %3rd-Ventricle
        2, 1007;    %Left-Fusiform
        1, 2007;    %Right-Fusiform
        2, 2025;     %Right-Precuneus
        1, 1025;   %Left-Precuneus
        2, 2004;      %Right-CorpusCallosum
        1, 1004;       %Left-CorpusCallosums
        1, 10;       % Left Thalamus
        2, 49];       % Right Thalamus

resSublist = dir([resultsPath filesep convertStringsToChars(structures(1)) filesep '*.nii.gz']);
DCs = zeros(length(resSublist), length(map(:,1)));
sens = zeros(length(resSublist), length(map(:,1)));
specs = zeros(length(resSublist), length(map(:,1)));

for s=1:length(structures)
    resSublist = dir([resultsPath filesep convertStringsToChars(structures(s)) filesep '*.nii.gz']);
    refSublist = dir([refrencePath filesep convertStringsToChars(structures(s)) filesep '*.nii.gz']);
     
%     sl = map(s,1);
%     fl = mapSLANT2FS(sl, map);   %map slant label to corresponding FS lbl
    %for each MR image 
    for i = 1:length(resSublist)
        fprintf("preparing image: %d - \n", i)
        resPath = [resSublist(i).folder filesep resSublist(i).name] ;
        refPath = [refSublist(i).folder filesep refSublist(i).name] ;

        resMRImg = niftiread(resPath);
        refMRImg = niftiread(refPath);
%         refMRImg = rotator(refMRImg);
        
        resFlag = flagger(resMRImg, map(s,1));
        refFlag = flagger(refMRImg, map(s,2));
                
        compareVis(resFlag, refFlag, 20);

        DCs(i,s) = diceCoeff(resFlag, refFlag);
%         ASSDs(i,s) = 
       [sens(i,s),specs(i,s)] = senSpec(resFlag, refFlag);
        
    end
end
SmplBasedADC = mean(DCs, 2);
lblBasedADC = mean(DCs, 1);


% FUNCTIONS
function [sen , spec] = senSpec(resFlag, refFlag)
    comb = single(resFlag) + 3*single(refFlag);
    
    sen = (length(find(comb==4))/(length(find(comb==4))+length(find(comb==1))))*100;
    spec = (length(find(comb==0))/(length(find(comb==1))+length(find(comb==0))))*100;
end

function res = diceCoeff (resFlag, refFlag)
        comb = single(resFlag) + single(refFlag);

        intersec = length(find(comb==2));

        res = ((2*(intersec))/(length(find(resFlag==1))+length(find(refFlag==1))))*100;
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