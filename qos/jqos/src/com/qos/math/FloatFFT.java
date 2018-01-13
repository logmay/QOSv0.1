package com.qos.math;
import java.util.HashMap;
import edu.emory.mathcs.jtransforms.fft.FloatFFT_1D;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 08/06/2017.
 */
// wrapper of jtransforms.fft
public final class FloatFFT {
    private static HashMap<Integer,FloatFFT_1D> cache = new HashMap<>();
    public static void fft(float[] v){
        // length of v must be a power of 2, to be fast, this condition is not checked, the caller has to grantee that
        int n = v.length/2;
        FloatFFT_1D fft = cache.get(n);
        if (fft == null){
            fft = new FloatFFT_1D(n);
            cache.put(n, fft);
        }
        fft.complexForward(v);
    }
    public static void rfft(float[] v){
        // length of v must be a power of 2, to be fast, this condition is not checked, the caller has to grantee that
        int n = v.length/2;
        FloatFFT_1D fft = cache.get(n);
        if (fft == null){
            fft = new FloatFFT_1D(n);
            cache.put(n, fft);
        }
        fft.realForward(v);
    }
    public static void ifft(float[] v){
        // length of v must be a power of 2, to be fast, this condition is not checked, the caller has to grantee that
        int n = v.length/2;
        FloatFFT_1D fft = cache.get(n);
        if (fft == null){
            fft = new FloatFFT_1D(n);
            cache.put(n, fft);
        }
        fft.complexInverse(v, true);
    }
    public static void rifft(float[] v){
        // length of v must be a power of 2, to be fast, this condition is not checked, the caller has to grantee that
        int n = v.length/2;
        FloatFFT_1D fft = cache.get(n);
        if (fft == null){
            fft = new FloatFFT_1D(n);
            cache.put(n, fft);
        }
        fft.realInverse(v, true);
    }
}
