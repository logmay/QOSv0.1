package com.qos.exception.io;

import com.qos.exception.QException;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 23/07/2017.
 */

public class updateQubitDatabaseError  extends QException{
    public updateQubitDatabaseError(){
        super("update qubit data base failed.", null);
    }
    public updateQubitDatabaseError(String message){
        super(message, null);
    }
    public updateQubitDatabaseError(String message, Throwable cause){
        super(message, cause);
    }
}