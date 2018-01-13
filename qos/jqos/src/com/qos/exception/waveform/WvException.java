package com.qos.exception.waveform;
import com.qos.exception.QException;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 26/05/2017.
 */
public class WvException extends QException {
    public WvException(String message){
        super(message, null);
    }
    public WvException(String message, Throwable cause){
        super(message, cause);
    }
}
