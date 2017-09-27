% bring up qubits - spectroscopy
% Yulin Wu, 2017/3/11
%%
q = 'q8';
f01 = getQSettings('f01',q);
freq = f01-30e6:0.2e6:f01+30e6;
% freq = 5.2e9:0.2e6:5.35e9;
spectroscopy1_zpa('qubit',q,'biasAmp',[0],'driveFreq',[freq],...
       'dataTyp','S21','gui',true,'save',true);  % dataTyp: S21 or P
% spectroscopy1_zpa('qubit','q2'); % lazy mode
%%
spectroscopy1_power('qubit','q6',...
       'biasAmp',0,'driveFreq',[4.75e9:0.2e6:5.4e9],...
       'uSrcPower',[5:1:20],...
       'dataTyp','P','gui',true,'save',true); % dataTyp: S21 or P
%%
spectroscopy111_zpa('biasQubit','q6','biasAmp',[-5000:1000:5000],...
       'driveQubit','q8','driveFreq',[],...
       'readoutQubit','q8''dataTyp','P',...
       'notes','q6->q8 zpls cross talk','gui',true,'save',true);
%%
f01 = getQSettings('f01',q);
freq = f01-10e6:0.5e6:f01+3e6;
freq = 4.2e9:0.5e6:4.43e9;
spectroscopy1_zdc('qubit',q,'biasAmp',[-8000:-1000:-12000],'driveFreq',[freq],...
       'dataTyp','S21','gui',true,'save',true); % dataTyp: S21 or P
%%
setQSettings('r_avg',500,'q9');
% pf01 = [-0.55133,188.64,5.175e9];
% q9zAmp2f01 = @(x) polyval(pf01,x);
pf01 = [-0.46619,0.35418,5.2286e9];
q7zAmp2f01 = @(x) polyval(pf01,x);
% pf01 = [-0.33858,-16646,4.566e+09];
% q6zAmp2f01 = @(x) polyval(pf01,x);
spectroscopy1_zpa_bndSwp('qubit',q,...
       'swpBandCenterFcn',q7zAmp2f01,'swpBandWdth',10e6,...
       'biasAmp',[-5000:2000:32000],'driveFreq',[4.5e9:0.5e6:5.3e9],...
       'gui',true,'save',true);
% spectroscopy1_zpa_bndSwp('qubit','q2',...
%        'swpBandCenterFcn',q2zAmp2f01,'swpBandWdth',120e6,...
%        'biasAmp',[6000:50:9750],'driveFreq',[5.56e9:0.2e6:5.77e9],...
%        'gui',false,'save',true);
