% data_taking.public.xmon.tuneup.correctf01byPhase('qubit',[_c&o_],'delayTime',<_i_>,...
%       'gui',<_b_>,'save',<_b_>)
function varargout = correctf01byPhase(varargin)
% support multi-qubit parallel correction
% 
% correct f01 at the current working point(defined by zdc_amp in registry)
% by phase tomo: f01 already set previously, correctf01byPhase is just to
% remeasure f01 in case f01 has drifted away slightly.
% note: T2* time can not be too short
%
% <_f_> = correctf01byPhase('qubit',[_c&o_],'delayTime',<_i_>,...
%       'gui',<_b_>,'save',<_b_>)
% _f_: float
% _i_: integer
% _c_: char or char string
% _b_: boolean
% _o_: object
% a&b: default type is a, but type b is also acceptable
% []: can be an array, scalar also acceptable
% {}: must be a cell array
% <>: optional, for input arguments, assume the default value if not specified
% arguments order not important as long as they form correct pairs.
    
    % Yulin Wu, 2017/4/14
    
    import data_taking.public.xmon.ramsey
    
    args = qes.util.processArgs(varargin,{'delayTime',1e-6,'robust',true,'gui',false,'save',true});
	
	qubits = args.qubits;
	if ~iscell(qubits)
		qubits = {qubits};
	end
	
	numQs = numel(qubits);
	allf01s = nan(1,numQs);
    for ii = 1:numQs
        if ischar(qubits{ii})
            qubits{ii} = sqc.util.qName2Obj(qubits{ii});
        end
		qubits{ii}.qr_xy_dragPulse = false;
    end
	% assume all qubit DACs has the same samplingRate
    da = qes.qHandle.FindByClassProp('qes.hwdriver.hardware','name',...
		qubits{1}.channels.xy_i.instru);
    daChnl = da.GetChnl(qubits{1}.channels.xy_i.chnl);
	daSamplingRate = daChnl.samplingRate;
    
    t = unique(round(linspace(0,args.delayTime,20)*daSamplingRate));
    % DRAGE adds a detunning effect to increase f12 exitation to achieve
    % high gate fidelity, in f01 correction DRAGE has to be off
    q.qr_xy_dragPulse = false; 
    e = ramsey('qubit',qubits,'mode','dp','dataTyp','Phase',... 
      'time',t,'detuning',0,'gui',false,'save',false);

	data = e.data{1};
    if numQs > 1
        data = cell2mat(data(:));
    else
        data = data(:);
    end
    t = t.';
	for ii = 1:numQs
        q = qubits{ii};
        phase = unwrap(data(:,ii));
        phase(1) = [];
        t_ = t(2:end);
        p = polyfit(t_,phase,1);
        df = p(1)/(2*pi/daSamplingRate);

        if args.gui
            hf = qes.ui.qosFigure(sprintf('Correct f01 by phase | %s', q.name),true);
            ax = axes('parent',hf);
            plot(ax,1e9*t_/daSamplingRate,phase,'.','MarkerSize',15);
            hold(ax,'on');
            plot(ax,1e9*t_/daSamplingRate,polyval(p,t_),'-r','LineWidth',1);
            legend(ax,{'data','linear fit'});
            xlabel(ax,'time(ns)');
            ylabel(ax,'phase(rad)');
            title(['detune frequency: ', num2str(df/1e6,'%0.5fMHz')]);
            grid on;
        end

        if abs(df) > 10e6
            throw(MException('QOS_correctf01byPhase:driftTooLarge',...
                    'frequency drift too large, settings not updated.'));
        end

        f01 = q.f01-df;

        updateSettings = false;
        if ischar(args.save)
            choice  = questdlg('Update settings?','Save options',...
                    'Yes','No','No');
            if ~isempty(choice) && strcmp(choice, 'Yes')
                updateSettings = true;
            end
        else
            updateSettings = args.save;
        end

        if updateSettings
            QS = qes.qSettings.GetInstance();
            QS.saveSSettings({q.name,'f01'},num2str(f01,'%0.6e'));
            dataFolder = fullfile(QS.loadSSettings('data_path'),'cal','correctF01ByPhase');
            if ~exist(dataFolder,'dir')
                mkdir(dataFolder);
            end
            dataFileName = [q.name,'_',datestr(now,'yymmddTHHMMSS'),...
                    num2str(ceil(99*rand(1,1)),'%0.0f'),'_'];
            if ~isempty(hf) && isvalid(hf)
                figName = fullfile(dataFolder,[dataFileName,'.fig']);
                saveas(hf,figName);
            end
            dataFileName = fullfile(dataFolder,[dataFileName,'.mat']);
            time = t_; % ns
            save(dataFileName,'time','phase','p');
        end
        allf01s(ii) = f01;
	end
	varargout{2} = allf01s;
end
