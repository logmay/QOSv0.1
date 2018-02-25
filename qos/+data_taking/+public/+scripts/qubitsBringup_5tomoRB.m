% tomography and randomized bnenchmarking
%%
q = 'q2';
setQSettings('r_avg',3000);
state = '|0>';
data = Tomo_1QState('qubit',q,'state',state,'gui',true,'save',true);
% rho = sqc.qfcns.stateTomoData2Rho(data);
% h = figure();bar3(real(rho));h = figure();bar3(imag(rho));
%%
q = 'q10';
setQSettings('r_avg',5000);
process = 'X/2';
data = Tomo_1QProcess_animation('qubit',q,'process',process,'numPts',5,'notes','','save',true);
%%
gate = 'X/2';
data = Tomo_1QProcess('qubit','q1','process',gate,'gui',true);
%%
setQSettings('r_avg',3000);
% tuneup.iq2prob_01('qubit','q1','numSamples',1e4,'gui',true,'save',true);
% tuneup.iq2prob_01('qubit','q2','numSamples',1e4,'gui',true,'save',true);
twoQStateTomoData = Tomo_2QState('qubit1','q3','qubit2','q2',...
  'state','|11>',...
 'notes','','gui',true,'save',true);
%%
gate = 'X/2';
data = Tomo_1QProcess('qubit','q1','process',gate,'gui',true);
%%
qubits = {'q7','q8','q9'};
setQSettings('r_avg',50000,qubits);
twoQStateTomoData = Tomo_mQState('qubits',qubits,...
  'state','1',...
 'notes','','gui',true,'save',true);
%%
q = 'q1';
setQSettings('r_avg',1000);
numGates = int16(unique(round(logspace(1,log10(300),20))));
[Pref,Pgate] = randBenchMarking('qubit1',q,'qubit2',[],...
       'process','X/2','numGates',numGates,'numReps',60,...
       'gui',true,'save',true);   
[fidelity,h] = toolbox.data_tool.randBenchMarking(numGates, Pref, Pgate, 1, 'X/2');
%%