function folderPrepare(patchPath, pSegPath)

if ~exist(patchPath, 'dir'), mkdir(patchPath); end
if ~exist([patchPath filesep 'amyg'], 'dir'), mkdir([patchPath filesep 'amyg']); end
if ~exist([patchPath filesep 'put'], 'dir'), mkdir([patchPath filesep 'put']); end
if ~exist([patchPath filesep 'hipp'], 'dir'), mkdir([patchPath filesep 'hipp']); end
if ~exist([patchPath filesep 'pall'], 'dir'), mkdir([patchPath filesep 'pall']); end
if ~exist([patchPath filesep 'CWM'], 'dir'), mkdir([patchPath filesep 'CWM']); end
if ~exist([patchPath filesep '3rdVentricle'], 'dir'), mkdir([patchPath filesep '3rdVentricle']); end
if ~exist([patchPath filesep 'fusiform'], 'dir'), mkdir([patchPath filesep 'fusiform']); end
if ~exist([patchPath filesep 'precuneus'], 'dir'), mkdir([patchPath filesep 'precuneus']); end
if ~exist([patchPath filesep 'CorpusCallosum'], 'dir'), mkdir([patchPath filesep 'CorpusCallosum']); end
if ~exist([patchPath filesep 'Thalamus'], 'dir'), mkdir([patchPath filesep 'Thalamus']); end

if ~exist(pSegPath, 'dir'), mkdir(pSegPath); end
if ~exist([pSegPath filesep 'amyg'], 'dir'), mkdir([pSegPath filesep 'amyg']); end
if ~exist([pSegPath filesep 'put'], 'dir'), mkdir([pSegPath filesep 'put']); end
if ~exist([pSegPath filesep 'hipp'], 'dir'), mkdir([pSegPath filesep 'hipp']); end
if ~exist([pSegPath filesep 'pall'], 'dir'), mkdir([pSegPath filesep 'pall']); end
if ~exist([pSegPath filesep 'CWM'], 'dir'), mkdir([pSegPath filesep 'CWM']); end
if ~exist([pSegPath filesep '3rdVentricle'], 'dir'), mkdir([pSegPath filesep '3rdVentricle']); end
if ~exist([pSegPath filesep 'fusiform'], 'dir'), mkdir([pSegPath filesep 'fusiform']); end
if ~exist([pSegPath filesep 'precuneus'], 'dir'), mkdir([pSegPath filesep 'precuneus']); end
if ~exist([pSegPath filesep 'CorpusCallosum'], 'dir'), mkdir([pSegPath filesep 'CorpusCallosum']); end
if ~exist([pSegPath filesep 'Thalamus'], 'dir'), mkdir([pSegPath filesep 'Thalamus']); end

end

