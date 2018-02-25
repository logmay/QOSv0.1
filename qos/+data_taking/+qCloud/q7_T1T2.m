function q7_T1T2()

import sqc.util.getQSettings
import sqc.util.setQSettings
import data_taking.public.xmon.*


    q = 'q7';
    doCorrection = false;

    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    tuneup.correctf01byPhase('qubits',q,'delayTime',0.6e-6,'gui',false,'save',true,'doCorrection',doCorrection);
%     tuneup.xyGateAmpTuner('qubit',q,'gateTyp','X/2','AE',true,'AENumPi',31,'gui',true,'save',true);
    tuneup.iq2prob_01('qubits',q,'numSamples',2e4,'gui',true,'save',true);
    setQSettings('r_avg',2000);
    T1_1('qubit',q,'biasAmp',[0],'biasDelay',10,'time',[20:500:28e3],...
      'gui',true,'save',true);
    ramsey('qubit',q,'mode','dp',... % available modes are: df01, dp and dz
      'time',[0:200:26000],'detuning',[0.5]*2e6,...
      'dataTyp','P','phaseOffset',0,'notes','','gui',true,'save',true);
  
%     T1_1('qubit',q,'biasAmp',[0],'biasDelay',10,'time',[20:500:28e3],...
%       'gui',true,'save',true);
%     ramsey('qubit',q,'mode','dp',... % available modes are: df01, dp and dz
%       'time',[0:50:8000],'detuning',[1]*2e6,...
%       'dataTyp','P','phaseOffset',0,'notes','','gui',true,'save',true);
end