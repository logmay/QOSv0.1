function g = Z2m(qubit)
	% -Z/2
    
% Copyright 2017 Yulin Wu, University of Science and Technology of China
% mail4ywu@gmail.com/mail4ywu@icloud.com
	import sqc.op.physical.gate.*
	switch qubit.g_Z_typ
		case 'z' % implement by using z line
			g = Z2m_z(qubit);
		case 'xy' % implement by using X Y gates
			g = X(qubit)*XY_4m(qubit);
		case 'phase'
            g = Z2m_phase(qubit);
		otherwise
			error('unrecognized Z gate type: %s, available z gate options are: xy ,phase and z',...
				qubit.g_Z_typ);
	
    end
    g.setGateClass('Z2m');
end
