%RESIZE transforms the segmentation of a patch around structure to the
%   original size
%Inputs:
%   inPath:     a string which indicated the path to nii t1
%   outPath:    Path to the folder that the resulting nii file to be saved
%   structNum:  1 for Hippocampus, 2 for Amygdala, 3 for Putamen
%
% Code has been developed in Neuromedia Lab, Research Center for Science and
%   Technology in Medicine, Tehran University of Medical Sciences
%====================================================================
function finalSeg = resize(segImg, structure, lableFactors)

    finalSeg = zeros(172, 220, 156);
    
    if (structure == "amyg")       %Amygdala
        finalSeg(45:134, 104:145, 40:78) = segImg*lableFactors(2);
    elseif (structure == "put")   %Putamen
        finalSeg(43:137, 95:148, 55:97) = segImg*lableFactors(3);
    elseif (structure == "hipp")   %Hippocampus
        finalSeg(45:132, 75:130, 35:90) = segImg*lableFactors(1);
     elseif (structure == "pall")   %Pallidum
        finalSeg(40:128, 95:160, 55:95) = segImg*lableFactors(4);
    elseif (structure == "CWM")   %CWM
        finalSeg(40:148, 22:110, 15:100)= segImg*lableFactors(5);
     elseif (structure == "3rdVentricle")   %3rd Ventricle
        finalSeg(60:130, 80:140, 50:90) = segImg*lableFactors(6);
     elseif (structure == "fusiform")   %fusiform
        finalSeg(:,10:160 , 20:130) = segImg*lableFactors(7);
     elseif (structure == "precuneus")   %precuneus
        finalSeg(45:140, 20:125, 70:145) = segImg*lableFactors(8);
     elseif (structure == "CorpusCallosum")   %Corpus Callosum
        finalSeg(58:138, 57:192, 60:110)= segImg*lableFactors(9);
    elseif (structure == "Thalamus")   %Thalamus
        finalSeg(40:140,70:160, 60:110)= segImg*lableFactors(10);   
    else 
        error("Invalid structure number");
    end
    
end

