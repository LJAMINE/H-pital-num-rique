package com.clinique.model;

import jakarta.persistence.*;

@MappedSuperclass

public  abstract class Personne{

    @Column(nullable = false)
    protected String nom;
    @Column(nullable = false)
    protected String prenom;
    @Column(nullable = false, unique = true)
    protected String email;
    @Column(nullable = false)
    protected String motDePasse;


    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }
}
