function varargout = czAmplitude(varargin)
% <_o_> = czAmplitude('controlQ',_c&o_,'targetQ',_c&o_,...
%       'notes',<_c_>,'gui',<_b_>,'save',<_b_>)
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

% Yulin Wu, 2017/10/14

    fcn_name = 'data_taking.public.xmon.tuneup.czAmplitude'; % this and args will be saved with data
    import qes.*
    import sqc.*
    import sqc.op.physical.*

    args = util.processArgs(varargin,{'gui',false,'notes','','save',true});
    [qc,qt] = data_taking.public.util.getQubits(args,{'controlQ','targetQ'});
    
    aczSettingsKey = sprintf('%s_%s',qc.name,qt.name);
    QS = qes.qSettings.GetInstance();
    scz = QS.loadSSettings({'shared','g_cz',aczSettingsKey});
    
    czAmp= round(scz.amp*linspace(0.97,1.03,25));
    acz1= data_taking.public.xmon.acz_ampLength('controlQ',qc,'targetQ',qt,...
       'dataTyp','Phase',...
       'czLength',scz.aczLn,'czAmp',czAmp,'cState','1',...
       'notes','','gui',false,'save',false);
    acz0= data_taking.public.xmon.acz_ampLength('controlQ',qc,'targetQ',qt,...
       'dataTyp','Phase',...
       'czLength',scz.aczLn,'czAmp',czAmp,'cState','0',...
       'notes','','gui',false,'save',false);
   
    cz0data=unwrap(acz0.data{1,1});
    cz1data=unwrap(acz1.data{1,1});
    dp = unwrap(cz1data - cz0data);
    cz0data = cz0data/pi;
    cz1data = cz1data/pi;
    dp = dp/pi;
    fdp = polyfit(czAmp,dp,2);
    
    fdp_ = fdp;
    fdp_(3)=fdp_(3)-1;
    rd=roots(fdp_);
    if numel(rd) == 1
        if ~isreal(rd)
            rd = [];
        end
    else
        rd = rd([isreal(rd(1)), isreal(rd(2))]);
    end
    ampBnd = minmax([czAmp(1),czAmp(end)]);
    czamp=rd(find(rd>ampBnd(1)&rd<ampBnd(end)));
    if isempty(czamp)
        fdp_ = fdp;
        fdp_(3)=fdp_(3)+1;
        rd=roots(fdp_);
        if numel(rd) == 1
            if ~isreal(rd)
                rd = [];
            end
        else
            rd = rd([isreal(rd(1)), isreal(rd(2))]);
        end
        czamp=rd(find(rd>ampBnd(1)&rd<ampBnd(end)));
    end
    
    if isempty(czamp)
        
        if args.gui
            hf = qes.ui.qosFigure(sprintf('ACZ amplitude | %s,%s', qc.name, qt.name),true);
            ax = axes('parent',hf);
            plot(ax,czAmp,cz0data,'--b',czAmp, cz1data,'--r',...
                czAmp,dp,'.',czAmp,polyval(fdp,czAmp),'-g',...
                czAmp,ones(1,length(czAmp)),'--k',czAmp,-ones(1,length(czAmp)),'--k');
            xlabel(ax,'acz amplitude');
            ylabel(ax,'phase(\pi)');
            legend(ax,{'|0>','|1>','difference','difference fit','+\pi','-\pi'});
            drawnow;
        end
            throw(exceptions.QRuntimeException('QOSTuneup:czAmplitude',...
                sprintf('%s,%s acz amplitude not found! Probably out of range.',qc.name, qt.name)));
    end
    
    if args.save
        QS.saveSSettings({'shared','g_cz',aczSettingsKey,'amp'},czamp);
    end
    
    if args.gui
        hf = qes.ui.qosFigure(sprintf('ACZ amplitude | %s,%s', qc.name, qt.name),true);
        ax = axes('parent',hf);
        plot(ax,czAmp,cz0data,'--b',czAmp, cz1data,'--r',...
            czAmp,dp,'.',czAmp,polyval(fdp,czAmp),'-g',...
            czAmp,ones(1,length(czAmp)),'--k',czAmp,-ones(1,length(czAmp)),'--k');
        xlabel(ax,'acz amplitude');
        ylabel(ax,'phase(\pi)');
        legend(ax,{'|0>','|1>','difference','difference fit','+\pi','-\pi'})
        title(sprintf('acz amplitude: %0.5e',czamp));
        drawnow;
        if args.save && ~isempty(hf) && isvalid(hf)
            dataSvName = fullfile(QS.loadSSettings('data_path'),...
                ['czAmp_',qc.name,qt.name,'_',datestr(now,'yymmddTHHMMSS'),...
                num2str(ceil(99*rand(1,1)),'%0.0f'),'_.fig']);
            saveas(hf,dataSvName);
        end
    end
end
    