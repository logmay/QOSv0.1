package com.qos.waveform;
import com.qos.math.FloatMath;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 14/06/2017.
 */
// a gaussian filter of bandwith "bandWidth", with attenuation "attenuation" at bandWidth frequency
// bandwith unit: sampling frequency.
public class XfrFuncGaussianFilter extends XfrFunc {
    protected final float sigmaf;
    public XfrFuncGaussianFilter(float bandWidth, float attenuation){
        if (bandWidth <=0 ) {
            throw new IllegalArgumentException("non positive bandWidth value.");
        } else if(attenuation <=0 ) {
            throw new IllegalArgumentException("non positive attenuation value.");
        }
        sigmaf = 2.0840F*bandWidth/ FloatMath.sqrt(attenuation);
    }
    public XfrFuncGaussianFilter(float bandWidth){
        // by default, attenuation = 3dB
        if (bandWidth <=0 ) {
            throw new IllegalArgumentException("non positive bandWidth value.");
        }
        sigmaf = 2.0840F*bandWidth/FloatMath.sqrt(3F);
    }
    class CacheKey extends XfrFunc.CacheKey {
        private float sigmaf(){return sigmaf;}

        CacheKey(int length){
            super(length);
        }
        public int hashCode(){
            int code = super.hashCode();
            return code*31 + (int)(1e5*sigmaf);
        }
        public boolean equals(Object other){
            if (!super.equals(other)) {
                return false;
            }
            CacheKey o = (CacheKey) other;
            return sigmaf == o.sigmaf();
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
        return v;
    }
}
