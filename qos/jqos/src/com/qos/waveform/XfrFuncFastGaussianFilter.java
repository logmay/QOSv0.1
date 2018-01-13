package com.qos.waveform;
import com.qos.math.FloatMath;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 15/07/2017.
 */
// a gaussian shaped filter that rolls off fast to zero around half sampling frequency.
public class XfrFuncFastGaussianFilter extends XfrFuncGaussianFilter{
    public XfrFuncFastGaussianFilter(float bandWidth, float attenuation){
        super(bandWidth,attenuation);
    }
    public XfrFuncFastGaussianFilter(float bandWidth){
        // by default, attenuation = 3dB
        super(bandWidth,3F);
    }
    class CacheKey extends XfrFuncGaussianFilter.CacheKey {
        CacheKey(int length){
            super(length);
        }

        public int hashCode(){
            return super.hashCode() + 1;
        }
    }
    @Override
    float[] samples(final float[] f) {
        CacheKey cacheKey = new CacheKey(f.length);
        float[] v = cache.get(cacheKey);
        if (v != null) return v.clone();
        v = new float[2*f.length];

        float tempVar1 = 2* FloatMath.sqr(sigmaf);
        for (int i = 0; i < 2*f.length; i += 2){
            v[i] = FloatMath.exp(-FloatMath.sqr(f[i/2])/tempVar1);
        }
        float a0 = FloatMath.exp(-0.25F/tempVar1);
        float denominator = 1 - a0;
        for (int i = 0; i < 2*f.length; i += 2){
            v[i] = (v[i] - a0)/denominator;
        }
        cache.put(cacheKey,v.clone());
        return v;
    }
    @Override
    public float[] samples_t(final float[] f) {
        float[] v = new float[2*f.length];

        float tempVar1 = 2* FloatMath.sqr(sigmaf);
        for (int i = 0; i < 2*f.length; i += 2){
            v[i] = FloatMath.exp(-FloatMath.sqr(f[i/2])/tempVar1);
        }
        float a0 = FloatMath.exp(-0.25F/tempVar1);
        float denominator = 1 - a0;
        for (int i = 0; i < 2*f.length; i += 2){
            v[i] = (v[i] - a0)/denominator;
        }
        return v;
    }
}
