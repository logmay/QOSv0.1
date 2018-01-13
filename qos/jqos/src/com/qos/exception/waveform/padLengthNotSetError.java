package com.qos.exception.waveform;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 22/08/2017.
 */
public class padLengthNotSetError extends WvException {
    public padLengthNotSetError(){
        super("pad length not set.", null);
    }
    public padLengthNotSetError(String message){
        super(message, null);
    }
    public padLengthNotSetError(String message, Throwable cause){
        super(message, cause);
    }
}