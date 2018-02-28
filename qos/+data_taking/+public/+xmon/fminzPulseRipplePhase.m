function varargout = fminzPulseRipplePhase(varargin)
% <_o_> = fminzPulseRipplePhase('qubit',_c|o_,'delayTime',[_i_],...
%       'zAmp',_f_,...
%       'notes',<_c_>,'gui',<_b_>,'save',<_b_>)
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

import qes.*
import sqc.*
import sqc.op.physical.*

args = util.processArgs(varargin,{'delayTime',[0:10:1500],'MaxIter',10,'gui',false,'notes','','detuning',0,'save',true});



    function [f,td]=zPulseRipplePhaseval(x)
        
        s = struct();
        s.type = 'function';
        s.funcName = 'qes.waveform.xfrFunc.gaussianExp';
        s.bandWidht = 0.25;
        
        s.r = x(1);
        s.td = x(2);
        
        xfrFunc = qes.util.xfrFuncBuilder(s);
        xfrFunc_inv = xfrFunc.inv();
        xfrFunc_lp = com.qos.waveform.XfrFuncFastGaussianFilter(0.13);
        xfrFunc_f = xfrFunc_lp.add(xfrFunc_inv);
        
        data_phase=data_taking.public.xmon.zPulseRipplePhase('qubit',args.qubit,'delayTime',args.delayTime,...
            'xfrFunc',[xfrFunc_f],'zAmp',args.zAmp,'s',s,...
            'notes',args.notes,'gui',args.gui,'save',args.save);
        phasedifference=unwrap(data_phase(1,:))-unwrap(data_phase(2,:));
        
        func=@(a,x)(a(1)*exp(-x/a(3))+a(2));
        a=[0.01,0.1,900];
        b=nlinfit(args.delayTime,phasedifference,func,a);
        f=abs(b(1));
        td=round(b(3));
    end
    
    function f=zPulseRipplePhaseval2(x)
        f=zPulseRipplePhaseval([x,td]);
    end

temp=args.delayTime;
args.delayTime=[0:25:1500];
[~,td]=zPulseRipplePhaseval([0.0,600]);
x0=0.01;
args.delayTime=temp;
options = optimset('PlotFcns',@optimplotfval,'MaxIter',args.MaxIter);
x=fminsearch(@zPulseRipplePhaseval2,x0,options);


% figure;plot(delayTime,phasedifference,delayTime,b(1)*exp(-delayTime/b(3))+b(2),'--');
% title(['td=' num2str(round(b(3)))])


varargout{1} = x;
end