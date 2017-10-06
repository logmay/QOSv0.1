% bring up qubits - spectroscopy
% Yulin Wu, 2017/3/11
rabi_amp1('qubit','q1','biasAmp',[0],'biasLonger',20,...
      'xyDriveAmp',[0e4:500:3e4],'detuning',[0],'driveTyp','X',...
      'dataTyp','S21','gui',true,'save',true);
% rabi_amp1('qubit','q2','xyDriveAmp',[0:500:3e4]);  % lazy mode
%%
rabi_long1_amp('qubit','q9','biasAmp',0,'biasLonger',5,...
      'xyDriveAmp',[2000],'xyDriveLength',[1:1:32],...
      'dataTyp','P','gui',true,'save',true);
%%
rabi_long1_freq('qubit','q6','biasAmp',0,'biasLonger',5,...
      'xyDriveAmp',8000,'xyDriveLength',[1:4:2000],...
      'detuning',[-10:1:10]*1e6,...
      'dataTyp','P','gui',true,'save',true);
%%
ramsey('qubit','q9','mode','dp',... % available modes are: df01, dp and dz
      'time',[0:20:2e3],'detuning',[5]*1e6,...
      'dataTyp','P','phaseOffset',0,'notes','','gui',true,'save',true);
%%
ramsey('qubit','q9','mode','dp',... % available modes are: df01, dp and dz
      'time',[0:6:0.5e3],'detuning',[5]*1e6,...
      'dataTyp','Phase','phaseOffset',0,'notes','','gui',true,'save',true);
%%
ramsey_dz('qubit','q8',...
       'time',[40],'detuning',[300e6],'phaseOffset',0,...
       'dataTyp','P',...   % S21 or P
       'gui','true','save','true');
%%
spin_echo('qubit','q8_7k','mode','dp',... % available modes are: df01, dp and dz
      'time',[0:20:20e3],'detuning',[5]*1e6,...
      'notes','','gui',true,'save',true);
%%
T1_1('qubit','q8_7k','biasAmp',[0],'biasDelay',20,'time',[0:100:29e3],...
      'gui',true,'save',true);
%%
resonatorT1('qubit','q2',...
      'swpPiAmp',1.8e3,'biasDelay',16,'swpPiLn',28,'time',[0:10:2000],...
      'gui',true,'save',true)
%%
qqSwap('qubit1','q7','qubit2','q8',...
       'biasQubit',1,'biasAmp',[-1.7e4:-100:-2.5e4],'biasDelay',10,...
       'q1XYGate','X','q2XYGate','X',...
       'swapTime',[0:10:100],'readoutQubit',2,...
       'notes','','gui',true,'save',true);