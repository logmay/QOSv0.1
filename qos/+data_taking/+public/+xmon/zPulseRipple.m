function varargout = zPulseRipple(varargin)
% zPulseRipple: ramsey oscillation,..
% detune by changing the second pi/2 pulse tracking frame
% 
% <_o_> = zPulseRipple('qubit',_c|o_,'time',[_i_],...
%       'zAmp',3e3,'notes',<_c_>,'gui',<_b_>,'save',<_b_>)
% _f_: float
% _i_: integer
% _c_: char or char string
% _b_: boolean
% _o_: object
% a|b: default type is a, but type b is also acceptable
% []: can be an array, scalar also acceptable
% {}: must be a cell array
% <>: optional, for input arguments, assume the default value if not specified
% arguments order not important as long as they form correct pairs.

% Yulin Wu, 2016/12/27
	
    import qes.*
    import sqc.*
    import sqc.op.physical.*
    
    Z_LENGTH = 10000;

	if nargin > 1  % otherwise playback
		fcn_name = 'data_taking.public.xmon.zPulseRipple'; % this and args will be saved with data
		args = util.processArgs(varargin,{'dataTyp','P','gui',false,'notes','','detuning',0,'save',true});
	end
    q = data_taking.public.util.getQubits(args,{'qubit'});

    X2 = gate.X2p(q);
    Y2 = gate.Y2p(q);
    I1 = gate.I(q);
    I2 = gate.I(q);
    if args.zAmp ~= 0
        Z = op.zRect(q);
        Z.ln = Z_LENGTH;
        Z.amp = args.zAmp;
    else
        Z = gate.I(q);
        Z.ln = Z_LENGTH;
    end
    
    R = measure.resonatorReadout_ss(q);
    R.state = 2;
    
    maxDelayTime = max(args.delayTime);
    function procFactory(delay)
        % I1.ln = delay;
        I1.ln = Z_LENGTH+delay;
        I2.ln = maxDelayTime - delay;
        % proc = Z*I1*X2*I2*Y2;
        proc = Z.*(I1*X2*I2*Y2); % now minus delay is allowed
        proc.Run();
        R.delay = proc.length;
    end

    y = expParam(@procFactory);
    y.name = [q.name,' delay time(DA samplig interval)'];
    s2 = sweep(y);
    s2.vals = args.delayTime;
    e = experiment();
    e.name = 'zPulseRipple';
    e.sweeps = [s2];
    e.measurements = R;
    e.datafileprefix = sprintf('%s', q.name);
    if ~args.gui
        e.showctrlpanel = false;
        e.plotdata = false;
    end
    if ~args.save
        e.savedata = false;
    end
    e.notes = args.notes;
    e.addSettings({'fcn','args'},{fcn_name,args});
    e.Run();
    varargout{1} = e;
end