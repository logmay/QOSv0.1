% CZ bring up:
%%
czLength=160;
czAmp=[-1.5e4:-250:-2.7e4];  % for q5-q6: [-4750:10:-4.5e3]
setQSettings('r_avg',3000);
acz1=acz_ampLength('controlQ','q1','targetQ','q2',...
       'dataTyp','Phase',...
       'czLength',czLength,'czAmp',czAmp,'cState','1',...
       'notes','','gui',true,'save',true);
acz0=acz_ampLength('controlQ','q1','targetQ','q2',...
       'dataTyp','Phase',...
       'czLength',czLength,'czAmp',czAmp,'cState','0',...
       'notes','','gui',true,'save',true);
cz0data=unwrap(acz0.data{1,1});
cz1data=unwrap(acz1.data{1,1});
% ff0=polyfit(czAmp,cz0data,2);
% ff1=polyfit(czAmp,cz1data,2);
ffd=polyfit(czAmp,cz1data - cz0data,2);
figure;plot(czAmp,cz0data,'.b',czAmp,cz1data,'.r',...
    czAmp,polyval(ffd,czAmp),'-g',czAmp,cz1data-cz0data,'.-m',...
    czAmp,ones(1,length(czAmp))*pi,':k',czAmp,-ones(1,length(czAmp))*pi,':k');
czAmp = sort(czAmp);
ffd_ = ffd;
ffd_(3)=ffd_(3)-pi;
rd=roots(ffd_);
if ~isempty(rd)
    czamp=rd(find(rd>czAmp(1)&rd<czAmp(end)));
end
sprintf('%.4e',czamp)
ffd_ = ffd;
ffd_(3)=ffd_(3)+pi;
rd=roots(ffd_);
if ~isempty(rd)
    czamp=rd(find(rd>czAmp(1)&rd<czAmp(end)));
end
sprintf('%.4e',czamp)
%%
setQSettings('r_avg',5000);
tuneup.czAmplitude('controlQ','q5','targetQ','q4',...
    'notes','','gui',true,'save',true);

%% check |11> -> |02> state leakage, method: prepare |11>, apply CZ, measure P|0?>
setQSettings('r_avg',5000);
acz_ampLength('controlQ','q11','targetQ','q10',...
       'dataTyp','Phase',...
       'czLength',[160],'czAmp',[0.8e4:200:1.2e4],'cState','1',...
       'notes','','gui',true,'save',true);
%% Tomography
setQSettings('r_avg',2000);
CZTomoData = Tomo_2QProcess('qubit1','q1','qubit2','q2',...
       'process','CZ',...
       'notes','','gui',true,'save',true);
toolbox.data_tool.showprocesstomo(CZTomoData,CZTomoData)
%%
setQSettings('r_avg',1000);
temp.czRBFidelityVsPhase('controlQ','q9','targetQ','q8',...
      'phase_c',[-pi:2*pi/10:pi],'phase_t',[-pi:2*pi/10:pi],...
      'numGates',4,'numReps',20,...
      'notes','','gui',true,'save',true);
%%
sqc.measure.gateOptimizer.czOptPhase({'q7','q8'},4,20,1500, 50);
%%
sqc.measure.gateOptimizer.czOptPhaseAmp({'q7','q8'},4,20,1500, 100);
%%
setQSettings('r_avg',1000);
temp.czRBFidelityVsPlsCalParam('controlQ','q7','targetQ','q8',...
       'rAmplitude',[-0.02:0.005:0.03],'td',[464],'calcControlQ',false,...
       'numGates',4,'numReps',20,...
       'notes','','gui',true,'save',true);
%% two qubit gate benchmarking
setQSettings('r_avg',1000);
numGates = [1:2:11];
[Pref,Pi] = randBenchMarking('qubit1','q1','qubit2','q2',...
       'process','CZ','numGates',numGates,'numReps',40,...
       'gui',true,'save',true);
[fidelity,h] = toolbox.data_tool.randBenchMarking(numGates, mean(Pref,1), mean(Pgate, 1),2, 'CZ');
%%
controlQ = 'q7';
targetQ = 'q8';
setQSettings('r_avg',5000);
czDetuneQPhaseTomo('controlQ',controlQ,'targetQ',targetQ,'detuneQ','q6',...
      'phase',[-pi:2*pi/30:pi],'numCZs',1,... % [-pi:2*pi/10:pi]
      'notes','','gui',true,'save',true);
%%
phase = tuneup.czDetuneQPhaseTomo('controlQ',controlQ,'targetQ',targetQ,'detuneQ','q6',...
        'maxFEval',40,...
       'notes','','gui',true,'save',true);