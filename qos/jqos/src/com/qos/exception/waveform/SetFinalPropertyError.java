package com.qos.exception.waveform;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 13/07/2017.
 */
public class SetFinalPropertyError extends WvException {
    public SetFinalPropertyError(){
        super("trying to set a final property.", null);
    }
    public SetFinalPropertyError(String message){
        super(message, null);
    }
    public SetFinalPropertyError(String message, Throwable cause){
        super(message, cause);
    }
}