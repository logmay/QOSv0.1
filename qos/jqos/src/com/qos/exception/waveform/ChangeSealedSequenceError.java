package com.qos.exception.waveform;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 12/07/2017.
 */
public class ChangeSealedSequenceError extends WvException {
    public ChangeSealedSequenceError(){
        super("A sequence has its status sealed before launch, it is not allowed to be changed.", null);
    }
    public ChangeSealedSequenceError(String message){
        super(message, null);
    }
    public ChangeSealedSequenceError(String message, Throwable cause){
        super(message, cause);
    }
}