package com.qos.math;
import org.apache.commons.math3.util.FastMath;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 21/06/2017.
 */
public class DoubleMath {
    public static double sinc(double x){
        x = FastMath.PI*x;
        if (FastMath.abs(x) <= 1e-6) {
            x = x*x;
            return ((x - 20)*x + 120)/120;
        } else {
            return FastMath.sin(x)/x;
        }
    }
}
