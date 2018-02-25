function q8_singleQGateRB_T1T2_180217()

import sqc.util.getQSettings
import sqc.util.setQSettings
import data_taking.public.xmon.*

numReps = 40;

numGates = int16(unique(round(logspace(0.5,log10(80),6))));

    q = 'q8';
    doCorrection = true;

    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
    tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    setQSettings('r_avg',3000);
    ramsey('qubit',q,'mode','dp',... % available modes are: df01, dp and dz
      'time',[10:20:5000],'detuning',[2]*2e6,...
      'dataTyp','P','phaseOffset',0,'notes','','gui',true,'save',true);
  
    setQSettings('r_avg',1500);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
    tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
%     tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
  
    setQSettings('r_avg',1500);
    [Pref,Pgate] = randBenchMarking('qubit1',q,'qubit2',[],...
       'process','X','numGates',numGates,'numReps',numReps,...
       'gui',true,'save',true,'doCalibration',false);   
    [fidelity,h] = toolbox.data_tool.randBenchMarking(numGates, Pref, Pgate, 1, 'X');

    setQSettings('r_avg',1500);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
    tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
%     tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
  
    setQSettings('r_avg',1500);
    [Pref,Pgate] = randBenchMarking('qubit1',q,'qubit2',[],...
       'process','Y','numGates',numGates,'numReps',numReps,...
       'gui',true,'save',true,'doCalibration',false);   
    [fidelity,h] = toolbox.data_tool.randBenchMarking(numGates, Pref, Pgate, 1, 'Y');

    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
    tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    setQSettings('r_avg',3000);
    ramsey('qubit',q,'mode','dp',... % available modes are: df01, dp and dz
      'time',[10:20:5000],'detuning',[2]*2e6,...
      'dataTyp','P','phaseOffset',0,'notes','','gui',true,'save',true);
end