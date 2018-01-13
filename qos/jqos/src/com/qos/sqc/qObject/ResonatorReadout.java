package com.qos.sqc.qObject;

import java.util.HashMap;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 23/07/2017.
 */
public class ResonatorReadout extends QReadout {
    float r_amp;
    float r_fc;
    float r_fr;
    float r_freq;
    float[] r_iq2prob_center0;
    float[] r_iq2prob_center1;
    float[] r_iq2prob_center2;
    float[] r_iq2prob_fidelity;
    boolean r_iq2prob_intrinsic;

    int r_jpa; // id of the readout jpa
    float r_jpa_biasAmp;
    int r_jpa_delay;
    int r_jpa_longer;
    float r_jpa_pumpAmp;
    float r_jpa_pumpFreq;
    float r_jpa_pumpPower;
    int r_ln;
    int[] r_truncatePts;
    float r_uSrcPower;
    HashMap<String, Float> r_wvSettings = new HashMap<>();
    String r_wvTyp;
}
