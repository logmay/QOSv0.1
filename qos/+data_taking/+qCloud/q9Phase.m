function p = q9Phase(newMeasureObj)
    import sqc.op.physical.* 
    persistent R;
    if (nargin > 0 && newMeasureObj) || isempty(R)
        q = sqc.util.qName2Obj('q9');
        X2 = op.XY2(q,-pi/2);
        I = gate.I(q);
        I.ln = 1500;
        R = sqc.measure.phase(q);
        R.setProcess(X2*I);
    end
    p = R();
end