package com.clinique.model;

import jakarta.persistence.*;

import java.util.List;

@Entity

public class Patient extends Personne {




    private double poids;
    private double taille;

    @OneToMany(mappedBy = "patient")
//    @OneToMany(mappedBy = "patient"): One patient, many consultations; Consultation points back to Patient.
    private List<Consultation> consultations;


    //--------------------getter and setters-------------------



    public double getPoids() {
        return poids;
    }

    public void setPoids(double poids) {
        this.poids = poids;
    }

    public double getTaille() {
        return taille;
    }

    public void setTaille(double taille) {
        this.taille = taille;
    }

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}