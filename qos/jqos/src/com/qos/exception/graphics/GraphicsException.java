package com.qos.exception.graphics;

import com.qos.exception.QException;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 26/05/2017.
 */
public class GraphicsException extends QException {
    public GraphicsException(String message){super(message, null);}
    public GraphicsException(String message, Throwable cause){super(message, cause);}
}
