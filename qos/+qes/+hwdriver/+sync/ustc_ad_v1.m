classdef ustc_ad_v1 < qes.hwdriver.hardware
    % wrap ustcadda as ad
    
% Copyright 2016 Yulin Wu, USTC, China
% mail4ywu@gmail.com/mail4ywu@icloud.com

    properties (SetAccess = private, GetAccess = private)
        chnlMap
        ustcaddaObj
    end
    methods (Access = private)
        function obj = ustc_ad_v1(name,chnlMap_)
            if iscell(chnlMap_) % for chnlMap_ data loaded from registry saved as json array
                chnlMap_ = cell2mat(chnlMap_);
            end
            obj = obj@qes.hwdriver.hardware(name);
            obj.ustcaddaObj = qes.hwdriver.sync.ustcadda_v1.GetInstance();
            obj.ustcaddaObj.Open(); % in case not openned already
            
            if numel(unique(chnlMap_)) ~= numel(chnlMap_)
                throw(MException('QOS_ustc_ad:duplicateChnls','bad chnlMap settings: duplicate channels found.'));
            end
            if ~all(chnlMap_<=obj.ustcaddaObj.numADChnls)
                throw(MException('QOS_ustc_da:nonExistChnls','chnlMap contains non-exist channels on AD.'));
            end
            assert(all(round(chnlMap_) == chnlMap_) & all(chnlMap_>0),'invalidInput');
       
			obj.ustcaddaObj.TakeADChnls(chnlMap_);
            obj.chnlMap = chnlMap_;
			obj.numChnls = numel(chnlMap_);
			
			% obj.samplingRate = obj.ustcaddaObj.GetADChnlSamplingRate(obj.chnlMap);
			
			obj.chnlMothdNames = {'Run'};
			obj.chnlMothds = {@(obj,chnl,N)Run(obj,chnl,N)};
			obj.chnlProps = {'recordLength','range','demodFreq','samplingRate','demodMode','delayStep'};
            obj.chnlPropSetMothds = {@(obj,chnl,v)SetRecordLength(obj,chnl,v),...
                                      [],... % read only
									  @(obj,chnl,v)SetDemodFreq(obj,chnl,v),...
									  [],... % read only
									  [],... % read only
                                      []};   % read only
            obj.chnlPropGetMothds = {@(obj,chnl)GetRecordLength(obj,chnl),...
                                      @(obj,chnl)GetRange(obj,chnl),...
									  @(obj,chnl)GetDemodFreq(obj,chnl),...
									  @(obj,chnl)GetSamplingRate(obj,chnl),...
									  @(obj,chnl)GetDemodMode(obj,chnl),...
                                      @(obj,chnl)GetDelayStep(obj,chnl)};
			obj.demodFreq = cell(1,obj.numChnls);
        end
    end
    methods (Hidden = true)
		function val = GetRecordLength(obj,chnl)
            val = obj.ustcaddaObj.GetAdRecordLength(obj.chnlMap(chnl));
        end
        function SetRecordLength(obj,chnl,val)
            obj.ustcaddaObj.SetAdRecordLength(obj.chnlMap(chnl),val);
        end
		
		function val = GetRange(obj,chnl)
            val = obj.ustcaddaObj.GetAdRange(obj.chnlMap(chnl));
        end
		
		function val = GetDemodFreq(obj,chnl)
            val = obj.demodFreq{chnl};
        end
        function SetDemodFreq(obj,chnl,val)
            obj.demodFreq{chnl} = val;
        end
		
		function val = GetSamplingRate(obj,chnl)
			val = obj.ustcaddaObj.GetADChnlSamplingRate(obj.chnlMap(chnl));
        end
		
		function val = GetDemodMode(obj,chnl)
			val = obj.ustcaddaObj.GetADDemodMode(obj.chnlMap(chnl));
        end
		
		function val = GetDelayStep(obj,chnl)
			val = obj.ustcaddaObj.GetAdDelayStep(obj.chnlMap(chnl));
        end

        function [I,Q] = Run(obj,chnl,N)
            
            obj.ustcaddaObj.runReps = N; % this only takes ~70us, the next line takes ~300ms
			if GetDemodMode(obj,chnl)
				[I,Q] = obj.ustcaddaObj.Run(obj.demodFreq{chnl});
            else
				[I,Q] = obj.ustcaddaObj.Run(true);
			end
        end
	end
	methods
		function delete(obj)
			obj.ustcaddaObj.ReleaseADChnls(obj.chnlMap);
            if isempty(obj.ustcaddaObj.adTakenChnls) &&...
                    isempty(obj.ustcaddaObj.daTakenChnls)
                obj.ustcaddaObj.delete();
            end
		end
    end
    
    methods (Static = true)
        function obj = GetInstance(name,chnlMap_) 
            persistent objlst;
            if isempty(objlst) || ~isvalid(objlst)
                obj = qes.hwdriver.sync.ustc_ad_v1(name,chnlMap_);
                objlst = obj;
            else
                obj = objlst;
            end
        end
    end
    
end