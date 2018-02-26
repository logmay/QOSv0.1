function output=circuit2exp(circuit,measure)
% This function is to convert quantum circuit into experimental waveform
% blocks.

if nargin<1
    S='S';H='H';CZ='CZ';I='I';Sd='Sd';
    mX='Y2p';
    mY='X2m';
    mZ='I';
    mI='I';
    g1={mX,mI,mZ,mX,mZ};
    g2={mI,mX,mX,mZ,mZ};
    g3={mX,mZ,mI,mZ,mX};
    g4={mZ,mZ,mX,mX,mI};
    Xbar={mX,mX,mX,mX,mX};
    Ybar={mY,mY,mY,mY,mY};
    Zbar={mZ,mZ,mZ,mZ,mZ};
    measure={g1,g2,g3,g4,Xbar,Ybar,Zbar};
    circuit={{S,H,H,H,H},...
        {I,CZ,CZ,I,I},...
        {H,I,I,I,I},...
        {I,I,I,CZ,CZ},...
        {CZ,CZ,I,I,S},...
        {I,I,CZ,CZ,I},...
        {H,S,S,H,I},...
        {S,H,I,Sd,I},...
        {H,I,I,H,I},...
        {I,I,CZ,CZ,I}
        {I,I,H,H,I},...
        {I,I,CZ,CZ,I},...
        {I,I,H,H,I},...
        {I,I,CZ,CZ,I},...
        {I,CZ,CZ,H,I},...
        {I,H,H,I,I},...
        {I,CZ,CZ,I,I},...
        {I,H,H,I,I},...
        {I,CZ,CZ,I,I},...
        {I,H,H,I,I},...
        {CZ,CZ,I,I,I},...
        {H,H,I,I,I},...
        {I,CZ,CZ,I,I},...
        {I,I,H,I,I}
        };
    circuit={{S,H,H,H,H},...
        {H,CZ,CZ,I,I},...
        {I,I,I,CZ,CZ},...
        {CZ,CZ,I,I,S},...
        {I,I,CZ,CZ,I},...
        {H,S,S,H,I},...
        {S,I,H,Sd,I},...
        {H,I,CZ,CZ,I},...
        {I,I,H,H,I},...
        {I,I,CZ,CZ,I},...
        {I,I,H,H,I},...
        {I,I,CZ,CZ,I},...
        {I,CZ,CZ,I,I},...
        {I,H,H,I,I},...
        {I,CZ,CZ,I,I},...
        {I,H,H,I,I},...
        {CZ,CZ,I,I,I},...
        {H,Sd,I,I,I},...
        {I,H,I,I,I},...
        {I,CZ,CZ,I,I},...
        {I,H,Sd,I,I},...
        {I,S,H,I,I},...
        {I,H,I,I,I}
        };
end

numQ=numel(circuit{1});
numStep=numel(circuit);
output='';
for ii=1:numStep
    for jj=1:numQ
        if ii==1 && jj==1
            if strcmp(circuit{1}{1},'CZ') && strcmp(circuit{1}{2},'CZ')
                output=[circuit{1}{1} '12'  ];
            else
                output=[circuit{1}{1} '1'  ];
            end
        else
            if jj==1
                mtp='*';
            else
                mtp='.*';
            end
            if strcmp(circuit{ii}{jj},'CZ') && jj<numQ && strcmp(circuit{ii}{jj+1},'CZ')
                output=[output mtp circuit{ii}{jj} num2str(jj*10+jj+1)  ];
            elseif strcmp(circuit{ii}{jj},'CZ') && jj>1 && strcmp(circuit{ii}{jj-1},'CZ')
                output=[output mtp circuit{ii}{jj} num2str((jj-1)*10+jj)  ];
            else
                output=[output mtp circuit{ii}{jj} num2str(jj)  ];
            end
        end
    end
end
if ~isempty(measure)
    measureseq={};
    for ii=1:numel(measure)
        measureopt=measure{ii}{1};
        for jj=2:numel(measure{ii})
            measureopt=[measureopt '.*' measure{ii}{jj} num2str(jj)];
        end
        measureseq{ii}=[output '*' measureopt];
    end
    output=measureseq;
end
end