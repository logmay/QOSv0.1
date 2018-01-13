package com.qos.exception;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 22/08/2017.
 */
public class changeFinalPropertyError extends QException {
    public changeFinalPropertyError(){
        super("trying to change a final property.", null);
    }
    public changeFinalPropertyError(String message){
        super(message, null);
    }
    public changeFinalPropertyError(String message, Throwable cause){
        super(message, cause);
    }
}
