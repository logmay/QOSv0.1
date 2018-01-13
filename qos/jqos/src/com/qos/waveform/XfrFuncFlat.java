package com.qos.waveform;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 25/07/2017.
 */
public class XfrFuncFlat extends XfrFunc {
    private final float bandWidth;
    public XfrFuncFlat(float bandWidth){
        if (bandWidth <=0 ) {
            throw new IllegalArgumentException("non positive bandWidth value.");
        }
        this.bandWidth = bandWidth;
    }
    class CacheKey extends XfrFunc.CacheKey {
        private float bandWidth(){return bandWidth;}

        CacheKey(int length){
            super(length);
        }
        public int hashCode(){
            int code = super.hashCode();
            return code*31 + (int)(1e5*bandWidth);
        }
        public boolean equals(Object other){
            if (!super.equals(other)) {
                return false;
            }
            CacheKey o = (CacheKey) other;
            return bandWidth == o.bandWidth();
        }
    }
    @Override
    float[] samples(final float[] f) {
        CacheKey cacheKey = new CacheKey(f.length);
        float[] v = cache.get(cacheKey);
        if (v != null) return v.clone();
        v = new float[2*f.length];
        for (int i = 0; i < 2*bandWidth; i += 2){
            v[i] = 1F;
        }
        cache.put(cacheKey,v.clone());
        return v;
    }
    @Override
    public float[] samples_t(final float[] f) {
        float[] v = new float[2*f.length];
        for (int i = 0; i < 2*bandWidth; i += 2){
            v[i] = 1F;
        }
        return v;
    }
}
