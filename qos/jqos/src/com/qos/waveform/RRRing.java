package com.qos.waveform;

import com.github.benmanes.caffeine.cache.Cache;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 10/07/2017.
 */
// Resonator QReadout pulse with Ringing
public class RRRing extends Waveform{
    private Waveform internalWv;

    public RRRing(int length, float amplitude, float edgeWidth,
                  float ringAmplitude, int ringWidth){
        super(length);
        Flattop flattopWv = new Flattop(length, amplitude, edgeWidth);
        Gaussian gaussian = new Gaussian(2*ringWidth, ringAmplitude);
        internalWv = flattopWv.add(gaussian);
    }

    private RRRing(int length){
        super(length);
    }

    public RRRing copy(){
        RRRing newWaveform =  new RRRing(length);
        newWaveform.internalWv = internalWv.copy();
        newWaveform._copy(this);
        return newWaveform;
    }

    CacheKey getCacheKey(){return null;}
    float[] samples(int tStart, int padLength, XfrFunc xfrFunc, Cache<CacheKey, float[]> cache){
        internalWv.carrierFrequency = carrierFrequency;
        internalWv.phase = phase;

        float scaleFactor = getScaleFactor();
        float[] v = internalWv.samples(tStart, padLength, xfrFunc, cache);
        for (int i=0; i<v.length; i++){
            v[i] = scaleFactor*v[i];
        }
        return v;
    }

    float[] _freqSamples() {
        // should never be called
        return null;
    }
    public float[] freqSamples(float[] f){
        float[] v = internalWv.freqSamples(f);
        for (int i=0; i<v.length; i++){
            v[i] *= scaleFactor;
        }
        return v;
    }
}
