package com.clinique.model;

import jakarta.persistence.*;

@Entity

public class Admin extends Personne{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private long idAdmin;

    public long getIdAdmin() {
        return idAdmin;
    }

    public void setIdAdmin(long idAdmin) {
        this.idAdmin = idAdmin;
    }
}