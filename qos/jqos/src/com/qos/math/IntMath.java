package com.qos.math;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 08/06/2017.
 */
public final class IntMath {
    // next power of 2
    public static int nextPow2(int value) {
        value -= 1;
        value |= value >> 16;
        value |= value >> 8;
        value |= value >> 4;
        value |= value >> 2;
        value |= value >> 1;
        return value + 1;
    }
    // power
    public static int pow(int x, int n){
        if (n == 0) {return 1;}
        if ( (n & 1) == 0 ) {
            int tempVar = pow(x, n/2);
            return tempVar*tempVar;
        } else {
            int tempVar = pow(x, (n-1)/2);
            return x*tempVar*tempVar;
        }
    }
    // log2
    public static int log2( int x ) // returns 0 for x=0
    {
        int log = 0;
        if( ( x & 0xffff0000 ) != 0 ) { x >>>= 16; log = 16; }
        if( x >= 256 ) { x >>>= 8; log += 8; }
        if( x >= 16  ) { x >>>= 4; log += 4; }
        if( x >= 4   ) { x >>>= 2; log += 2; }
        return log + ( x >>> 1 );
    }
    // another implementation of log2
    public static int log2nlz( int x )
    {
        if( x == 0 )
            return 0; // or throw exception
        return 31 - Integer.numberOfLeadingZeros(x);
    }
}
