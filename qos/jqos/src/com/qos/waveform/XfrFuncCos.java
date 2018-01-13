package com.qos.waveform;
import com.qos.math.FloatMath;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 28/07/2017.
 */
public class XfrFuncCos extends XfrFunc {
    private final float bandWidth;
    public XfrFuncCos(float bandWidth){
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
        float rollOffWidth = 0.5F-bandWidth;
        float f_;
        for (int i = 0; i < 2*bandWidth; i += 2){
            f_ = Math.abs(f[i/2]);
            if (f_ > 0.5){
                v[i] = 0;
            }else if (rollOffWidth > 0 && f_ > bandWidth) {
                v[i] = 0.5F+0.5F* FloatMath.cos(3.141592653589793F*(f_-bandWidth)/rollOffWidth);
            }else{v[1] = 1;}
        }
        cache.put(cacheKey,v.clone());
        return v;
    }
    @Override
    public float[] samples_t(final float[] f) {
        CacheKey cacheKey = new CacheKey(f.length);
        float[] v = cache.get(cacheKey);
        if (v != null) return v.clone();
        v = new float[2*f.length];
        float rollOffWidth = 0.5F-bandWidth;
        float f_;
        for (int i = 0; i < 2*bandWidth; i += 2){
            f_ = Math.abs(f[i/2]);
            if (f_ > 0.5){
                v[i] = 0;
            }else if (rollOffWidth > 0 && f_ > bandWidth) {
                v[i] = 0.5F+0.5F*FloatMath.cos(3.141592653589793F*(f_-bandWidth)/rollOffWidth);
            }else{v[1] = 1;}
        }
        cache.put(cacheKey,v.clone());
        return v;
    }
}

