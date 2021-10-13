structures = [ "hipp"; "amyg"; "put";"pall";"CWM";...
    "3rdVentricle";"fusiform"; "precuneus";"CorpusCallosum" ; "Thalamus"];

% labels guide:         left               right
% hipp                          2                   4               
% amyg                       3                    6
% put                           5                    10
% pall                          7                    14
% CWM                      11                   22
% 3rdVentricle                      13 
% fusiform                   17                 34
% precuneus              19                  38
% CorpusCallosum    23                  46

dataDir = '/home/neuromedia/Desktop/subj01_BNU';
tmp_reged = 'tmp/tmp-reged';
regedPath = 'tmp/reged';
regSegPath = 'tmp/regSeg';
patchPath = 'tmp/patches';
psegPath = 'tmp/pSeg';
predPath = 'tmp/predictions';
untransFinalPredPath  = 'tmp/untransFinalPredPath';
resPath = 'res';
lableFactors = primes(29);
addpath('dep');