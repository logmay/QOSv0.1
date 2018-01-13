package com.qos.sqc.qObject;

import java.util.HashMap;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 09/07/2017.
 */
public abstract class Qubit {
    private static volatile HashMap<Integer, Qubit> allQubits = new HashMap<>();
    private static synchronized void addQubit(int id, Qubit qubit){
        allQubits.put(id,qubit);
    }

    private final int id;  // id is loaded from the qubit database, the database guarantees its uniqueness
    public int getId(){return id;}
    public float f01;

    @Override
    public boolean equals(Object other) {
        return !((other == null) || (this.getClass() != other.getClass())) && this.id == ((Qubit) other).id;
    }

    public Qubit(int id){
        this.id = id;
        addQubit(id,this);
    }

}
