package com.qos.waveform;
import com.qos.math.DoubleMath;
import com.qos.math.FloatMath;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 20/06/2017.
 */
public class Rect extends Waveform {
    private final float amplitude;

    private static class CacheKey extends Waveform.CacheKey {
        private final float amplitude;

        CacheKey(int length, float carrierFrequency, float amplitude){
            super(length, carrierFrequency);
            this.amplitude = amplitude;
        }
        @Override
        public int hashCode(){
            return 31*super.hashCode() + (int)(1e4*amplitude);
        }
        @Override
        public boolean equals(Object other){
            if (!super.equals(other)) return false;
            CacheKey o = (CacheKey) other;
            return amplitude == o.amplitude;
        }
    }

    public Rect(int length, float amplitude){
        super(length);
        this.amplitude = amplitude;
    }

    public Rect copy(){
        Rect newWaveform =  new Rect(length, amplitude);
        newWaveform._copy(this);
        return newWaveform;
    }

    CacheKey getCacheKey(){
        return new CacheKey(length, carrierFrequency,amplitude);
    }

    float[] _freqSamples() {
        float[] f = shiftedSampleFrequencies();
        float [] v = new float[2*f.length];
        float t0 = ((float)length-1F)/2;
        float tempVar2;
        float tempVar3;
        for (int i = 0; i < 2*f.length; i += 2){
            tempVar2 = amplitude*length*(float) DoubleMath.sinc(f[i/2]*length);
            tempVar3 = -6.283185307179586F*f[i/2]*t0;
            v[i] = tempVar2* FloatMath.cos(tempVar3);
            v[i+1] = tempVar2*FloatMath.sin(tempVar3);
        }
        return v;
    }

    public float[] freqSamples(float[] f){
        float [] v = new float[2*f.length];
        float t0 = ((float)length-1F)/2;
        float tempVar2;
        float tempVar3;
        for (int i = 0; i < 2*f.length; i += 2){
            tempVar2 = amplitude*length*(float)DoubleMath.sinc(f[i/2]*length);
            tempVar3 = -6.283185307179586F*f[i/2]*t0;
            v[i] = tempVar2*FloatMath.cos(tempVar3)*scaleFactor;
            v[i+1] = tempVar2*FloatMath.sin(tempVar3)*scaleFactor;
        }
        return v;
    }

}
