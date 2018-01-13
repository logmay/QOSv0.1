package com.qos.waveform;

import com.github.benmanes.caffeine.cache.Cache;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 25/05/2017.
 */
public final class DC extends Waveform {
    private final float level;
    public DC(int length, float lvl){
        super(length);
        level = lvl;
    }

    public DC copy(){
        return new DC(length,level);
    }

    CacheKey getCacheKey(){return null;}

    float[] samples(int tStart, int padLength, XfrFunc xfrFunc, Cache<CacheKey, float[]> cache) { // DC is rarely used, thus not cached
        float[] v =  new float[2*length];
        for (int i=0; i< v.length; i++){
            v[i] = level;
        }
        return v;
    }

    float[] _freqSamples() {
        // should never be called
        return null;
    }
    public float[] freqSamples(float[] f) {
        float[] v = new float[2*f.length];
        for (int i = 0; i<v.length; i += 2){
            if (f[i/2]==0) {
                v[i] = f.length;
            }
        }
        return v;
    }

}
