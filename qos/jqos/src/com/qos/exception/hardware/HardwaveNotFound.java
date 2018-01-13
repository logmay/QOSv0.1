package com.qos.exception.hardware;
/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 26/05/2017.
 */
public class HardwaveNotFound extends HwException{
    public HardwaveNotFound(String message){super(message, null);}
    public HardwaveNotFound(String message, Throwable cause){super(message, cause);}
}
