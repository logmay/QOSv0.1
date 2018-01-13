package com.qos.exception;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 29/06/2017.
 */
public class IllegalUsage extends QException {
    /*
     * throwed at some special cases when a class method should not be called in a special subclass.
     * for example, in Waveform the freqSamples() method is defined abstract because each subclass should has
     * its specific implementation, the freqSamples() method is needed for most Waveform class but for very special
     * subclasses the freqSamples() method is not necessary or even not implementable, DC, Spacer, WaveformSum
     * for example, as subclasses of Waveform, the must implement the freqSamples() method yet this method should
     * never be called,
     */
    public IllegalUsage(String message, Throwable cause){
        super(message, cause);
    }
    public IllegalUsage(String message){
        super(message);
    }
}
