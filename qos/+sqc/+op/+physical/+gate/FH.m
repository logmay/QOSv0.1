function g = FH(qubit)
	% Fast Hardmard built with only two gates
	% exp(-1j*pi/2)*H = X*Y2 
	% H = X*Y2*I
	
% Copyright 2017 Yulin Wu, University of Science and Technology of China
% mail4ywu@gmail.com/mail4ywu@icloud.com
	
	import sqc.op.physical.gate.*
	g = X(qubit)*Y2p(qubit);
    g.setGateClass('H');
end
