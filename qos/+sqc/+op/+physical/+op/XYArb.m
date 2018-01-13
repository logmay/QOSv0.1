classdef XYArb < sqc.op.physical.gate.X
    % Pi rotation at at an arbitary axis in the xy plane
	% Note: piAmp for different rotation axis are not exactly the same,
	% use this operation for coarse application or tunning only.
    
% Copyright 2017 Yulin Wu, University of Science and Technology of China
% mail4ywu@gmail.com/mail4ywu@icloud.com

    properties
        phi % defines the rotation axis
    end
    methods
        function obj = XYArb(qubit, phi, ang)
            obj = obj@sqc.op.physical.gate.X(qubit);
			obj.phi = phi;
            error('todo');
        end
    end
    methods (Hidden = true)
        function GenWave(obj)
            GenWave@sqc.op.physical.gate.X(obj)
            obj.phase = obj.phi;
        end
    end
end