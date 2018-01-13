function GHZ_Prob(numQs)
% data_taking.yulin.GHZ_Prob();
import sqc.measure.*
import sqc.util.qName2Obj
    
import sqc.op.physical.*
import sqc.measure.*
import sqc.util.qName2Obj
    
import sqc.util.getQSettings
import sqc.util.setQSettings

switch numQs
    case 8
qNames = {'q1','q2','q3','q4','q5','q6','q7','q8'};          
gateMat = {'Y2p','Y2m','I',  'I',  'I',  'I',  'I',  'I';
           'CZ','CZ',  'I',  'I',  'I',  'I',  'I',  'I';
           'I','Y2p','Y2m',  'I',  'I',  'I',  'I',  'I';
           'I','CZ',  'CZ',  'I', 'I',  'I',  'I',  'I';
           'I','I',  'Y2p','Y2m', 'I',  'I',  'I',  'I';
           'I','I',  'CZ',  'CZ', 'I',  'I',  'I',  'I';
           'I','I',  'I',  'Y2p','Y2m',  'I',  'I',  'I';
           'I','I',  'I',   'CZ','CZ',  'I',  'I',  'I';
           'I','I',  'I',    'I','Y2p',  'Y2m',  'I',  'I';
           'I','I',  'I',   'I', 'CZ',  'CZ',  'I',  'I';
           'I','I',  'I',    'I','I',  'Y2p',  'Y2m',  'I';
           'I','I',  'I',   'I', 'I',  'CZ',  'CZ',  'I';
           'I','I',  'I',    'I','I',  'I',  'Y2p',  'Y2m';
           'I','I',  'I',   'I', 'I',  '',  'CZ',  'CZ';
           'I','I',  'I',    'I','I',  'I',  'I',  'Y2p';
           };
    case 7
qNames = {'q1','q2','q3','q4','q5','q6','q7'};          
gateMat = {'Y2p','Y2m','I',  'I',  'I',  'I',  'I';
           'CZ','CZ',  'I',  'I',  'I',  'I',  'I';
           'I','Y2p','Y2m',  'I',  'I',  'I',  'I';
           'I','CZ',  'CZ',  'I', 'I',  'I',  'I';
           'I','I',  'Y2p','Y2m', 'I',  'I',  'I';
           'I','I',  'CZ',  'CZ', 'I',  'I',  'I';
           'I','I',  'I',  'Y2p','Y2m',  'I',  'I';
           'I','I',  'I',   'CZ','CZ',  'I',  'I';
           'I','I',  'I',    'I','Y2p',  'Y2m',  'I';
           'I','I',  'I',   'I', 'CZ',  'CZ',  'I';
           'I','I',  'I',    'I','I',  'Y2p',  'Y2m';
           'I','I',  'I',   'I', 'I',  'CZ',  'CZ';
           'I','I',  'I',    'I','I',  'I',  'Y2p';
           };
    case 6  
qNames = {'q1','q2','q3','q4','q5','q6'};          
gateMat = {'Y2p','Y2m','I',  'I',  'I',  'I';
           'CZ','CZ',  'I',  'I',  'I',  'I';
           'I','Y2p','Y2m',  'I',  'I',  'I';
           'I','CZ',  'CZ',  'I', 'I',  'I';
           'I','I',  'Y2p','Y2m', 'I',  'I';
           'I','I',  'CZ',  'CZ', 'I',  'I';
           'I','I',  'I',  'Y2p','Y2m',  'I';
           'I','I',  'I',   'CZ','CZ',  'I';
           'I','I',  'I',    'I','Y2p',  'Y2m';
           'I','I',  'I',   'I', 'CZ',  'CZ';
           'I','I',  'I',    'I','I',  'Y2p';
           };
    case 5
qNames = {'q1','q2','q3','q4','q5'};          
gateMat = {'Y2p','Y2m','I',  'I',  'I';
           'CZ','CZ',  'I',  'I',  'I';
           'I','Y2p','Y2m',  'I',  'I';
           'I','CZ',  'CZ',  'I', 'I';
           'I','I',  'Y2p','Y2m', 'I';
           'I','I',  'CZ',  'CZ', 'I';
           'I','I',  'I',  'Y2p','Y2m';
           'I','I',  'I',   'CZ','CZ';
           'I','I',  'I',    'I','Y2p';
           };
    case 4
qNames = {'q1','q2','q3','q4'};          
gateMat = {'Y2p','Y2m','I',  'I';
           'CZ','CZ',  'I',  'I';
           'I','Y2p','Y2m',  'I';
           'I','CZ',  'CZ',  'I';
           'I','I',  'Y2p','Y2m';
           'I','I',  'CZ',  'CZ';
           'I','I',  'I',  'Y2p';
           };
    case 3
qNames = {'q1','q2','q3'};          
gateMat = {'Y2p','Y2m','I';
           'CZ','CZ',  'I';
           'I','Y2p','Y2m';
           'I','CZ',  'CZ';
           'I','I',  'Y2p';
           };
    otherwise
        error('unsupported number of qubits: %d', numQs);
end
       
qubits = cell(1,numel(qNames));
for ii = 1:numel(qNames)
    qubits{ii} = qName2Obj(qNames{ii});
end

proc = sqc.op.physical.gateParser.parse(qubits,gateMat);

R = resonatorReadout(qubits);
R.delay = proc.length;
proc.Run();
data = R();
hf = figure();bar(data);

QS = qes.qSettings.GetInstance();
dataFolder = fullfile(QS.loadSSettings('data_path'),'GHZ');
if ~exist(dataFolder,'dir')
    mkdir(dataFolder);
end
dataFileName = ['_',datestr(now,'yymmddTHHMMSS'),...
        num2str(ceil(99*rand(1,1)),'%0.0f'),'_'];
if ~isempty(hf) && isvalid(hf)
    figName = fullfile(dataFolder,[dataFileName,'.fig']);
    saveas(hf,figName);
end
dataFileName = fullfile(dataFolder,[dataFileName,'.mat']);
save(dataFileName,'data');

end