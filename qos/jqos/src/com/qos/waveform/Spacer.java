package com.qos.waveform;

import com.github.benmanes.caffeine.cache.Cache;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 04/06/2017.
 */
public final class Spacer extends Waveform {
    private static int CACHE_SIZE = (int)2e3; // Spacer are typically very short, 2e3 is sufficient
    // despite its simplicity, spacer is the most frequently used waveform,
    // we make a dedicated cache: samples for all possible Spacer waveforms.
    private static float[][] wvDataCache = new float[CACHE_SIZE][];
    static {
        for (int i = 0; i < CACHE_SIZE; i++) {
            wvDataCache[i] = new float[2*(i + 1)]; // the spacer waveform is treated differently from regular waveforms for performance.
        }
    }

    public Spacer(int length){
        super(length);
    }

    public Spacer copy(){
        return new Spacer(length);
    }

    CacheKey getCacheKey(){return null;}
    @Override
    float[] samples(int tStart, int padLength, XfrFunc xfrFunc, Cache<CacheKey, float[]> cache){
        if (length <= CACHE_SIZE) {
            return wvDataCache[length-1];
        } else{
            // return new float[2*length+4*getPadLength()];
            return new float[2*length]; // the spacer waveform is treated differently from regular waveforms for performance.
        }
    }

    float[] _freqSamples() {
        // should never be called
        return null;
    }
    public float[] freqSamples(final float[] f) {
        float[] v = new float[2*f.length];
        v[0] = 0;
        return v;
    }
}


