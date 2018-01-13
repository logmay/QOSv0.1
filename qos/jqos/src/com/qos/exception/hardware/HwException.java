package com.qos.exception.hardware;
import com.qos.exception.QException;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 26/05/2017.
 */
public class HwException extends QException {
    public HwException(String message){super(message, null);}
    public HwException(String message, Throwable cause){super(message, cause);}
}
