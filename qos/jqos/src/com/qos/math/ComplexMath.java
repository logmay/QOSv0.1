package com.qos.math;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 25/05/2017.
 */
import java.util.Objects;
public final class ComplexMath {
    private final double re;   // the real part
    private final double im;   // the imaginary part
    public ComplexMath(double real, double imag) {
        re = real;
        im = imag;
    }
    public double real(){return re;}
    public double imag(){return im;}
    public double abs() {return Math.hypot(re, im);}
    public double phase() {return Math.atan2(im, re);}
    public ComplexMath plus(ComplexMath b) {
        double real = re + b.re;
        double imag = im + b.im;
        return new ComplexMath(real, imag);
    }
    public ComplexMath minus(ComplexMath b) {
        double real = re - b.re;
        double imag = im - b.im;
        return new ComplexMath(real, imag);
    }
    public ComplexMath times(ComplexMath b) {
        double real = re * b.re - im * b.im;
        double imag = re * b.im + im * b.re;
        return new ComplexMath(real, imag);
    }
    public ComplexMath scale(double alpha) {
        return new ComplexMath(alpha * re, alpha * im);
    }
    public ComplexMath conjugate() {return new ComplexMath(re, -im);}
    public ComplexMath reciprocal() {
        double scale = re*re + im*im;
        return new ComplexMath(re/scale, -im/scale);
    }
    public ComplexMath divides(ComplexMath b) {
        ComplexMath a = this;
        return a.times(b.reciprocal());
    }
    public ComplexMath exp() {
        double mod = Math.exp(re);
        return new ComplexMath(mod*Math.cos(im), mod*Math.sin(im));
    }
    public ComplexMath sin() {
        return new ComplexMath(Math.sin(re) * Math.cosh(im), Math.cos(re) * Math.sinh(im));
    }
    public ComplexMath cos() {
        return new ComplexMath(Math.cos(re) * Math.cosh(im), -Math.sin(re) * Math.sinh(im));
    }
    public ComplexMath tan() {
        return sin().divides(cos());
    }
    public static ComplexMath plus(ComplexMath a, ComplexMath b) {
        double real = a.re + b.re;
        double imag = a.im + b.im;
        return new ComplexMath(real, imag);
    }
    public boolean equals(Object x) {
        if (x == null) return false;
        if (this.getClass() != x.getClass()) return false;
        ComplexMath that = (ComplexMath) x;
        return (this.re == that.re) && (this.im == that.im);
    }
    public int hashCode() {return Objects.hash(re, im);}

}
