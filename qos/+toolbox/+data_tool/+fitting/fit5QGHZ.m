function phi = fit5QGHZ(Pm)
    rho_ideal = zeros(32);
    rho_ideal(1,1) = 0.5;
    rho_ideal(1,32) = 0.5;
    rho_ideal(32,1) = 0.5;
    rho_ideal(32,32) = 0.5;
    function y = fitFunc(phaseCorrection_)
        rho = sqc.qfcns.stateTomoData2Rho(Pm,phaseCorrection_);
        y = sum(sum(abs(rho - rho_ideal)));
    end
    options = optimset('Display','iter','MaxFunEvals',500);
    
    phaseCorrection = fminsearch(@fitFunc,[0,0,0,0,0],options)
    
    rho_opt = sqc.qfcns.stateTomoData2Rho(Pm,phaseCorrection);
    ax = qes.util.plotfcn.Rho(rho_opt,[],1,false);
    ax = qes.util.plotfcn.Rho(rho_ideal,ax,0,false);
    title(ax(1),['Fidelity: ',num2str(sqc.qfcns.fidelity(rho_ideal,rho_opt),'%0.3f')]);

end