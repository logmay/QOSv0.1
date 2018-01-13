package com.qos.exception;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 26/05/2017.
 */
public class QException extends Exception{
    public QException(String message){
        super(message, null);
    }
    public QException(String message, Throwable cause){
        super(message, cause);
    }
}
