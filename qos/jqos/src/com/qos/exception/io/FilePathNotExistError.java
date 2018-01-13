package com.qos.exception.io;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 16/07/2017.
 */
public class FilePathNotExistError  extends Exception{
    public FilePathNotExistError(){
        super("file path not exist.", null);
    }
    public FilePathNotExistError(String message){
        super(message, null);
    }
    public FilePathNotExistError(String message, Throwable cause){
        super(message, cause);
    }
}
