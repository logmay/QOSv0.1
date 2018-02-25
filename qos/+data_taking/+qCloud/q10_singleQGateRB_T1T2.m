function q10_singleQGateRB_T1T2()

import sqc.util.getQSettings
import sqc.util.setQSettings
import data_taking.public.xmon.*

numGates = int16(unique(round(logspace(0.5,log10(120),10))));

    q = 'q10';
    doCorrection = true;

    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
    tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    setQSettings('r_avg',3000);
    T1_1('qubit',q,'biasAmp',[0],'biasDelay',10,'time',[20:500:28e3],...
      'gui',true,'save',true);
    ramsey('qubit',q,'mode','dp',... % available modes are: df01, dp and dz
      'time',[10:50:8000],'detuning',[1]*2e6,...
      'dataTyp','P','phaseOffset',0,'notes','','gui',true,'save',true);
  
    setQSettings('r_avg',1500);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
    tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
%     tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
  
    setQSettings('r_avg',1500);
    [Pref,Pgate] = randBenchMarking('qubit1',q,'qubit2',[],...
       'process','X','numGates',numGates,'numReps',60,...
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
       'process','Y','numGates',numGates,'numReps',60,...
       'gui',true,'save',true,'doCalibration',false);   
    [fidelity,h] = toolbox.data_tool.randBenchMarking(numGates, Pref, Pgate, 1, 'Y');
    
    
    setQSettings('r_avg',1500);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
    tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
%     tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
  
    setQSettings('r_avg',1500);
    [Pref,Pgate] = randBenchMarking('qubit1',q,'qubit2',[],...
       'process','X/2','numGates',numGates,'numReps',60,...
       'gui',true,'save',true,'doCalibration',false);   
    [fidelity,h] = toolbox.data_tool.randBenchMarking(numGates, Pref, Pgate, 1, 'X/2');
    
    setQSettings('r_avg',1500);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
    tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
%     tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',1e4,'gui',true,'save',true);
  
    setQSettings('r_avg',1500);
    [Pref,Pgate] = randBenchMarking('qubit1',q,'qubit2',[],...
       'process','Y/2','numGates',numGates,'numReps',60,...
       'gui',true,'save',true,'doCalibration',false);   
    [fidelity,h] = toolbox.data_tool.randBenchMarking(numGates, Pref, Pgate, 1, 'Y/2');
    
    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
    tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    setQSettings('r_avg',3000);
    T1_1('qubit',q,'biasAmp',[0],'biasDelay',10,'time',[20:500:28e3],...
      'gui',true,'save',true);
    ramsey('qubit',q,'mode','dp',... % available modes are: df01, dp and dz
      'time',[10:50:8000],'detuning',[1]*2e6,...
      'dataTyp','P','phaseOffset',0,'notes','','gui',true,'save',true);
end