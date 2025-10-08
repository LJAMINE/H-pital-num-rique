package com.clinique.model;

import jakarta.persistence.*;
import java.util.List;

@Entity

public class Patient extends Personne
{
    @Id
//    Marks a field as the primary key of the entity/table.

    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    Uses the database’s auto-increment feature (like MySQL’s AUTO_INCREMENT).

    private Long idPatient;
    private double poids;
    private double taille;

    @OneToMany(mappedBy = "patient")
//    @OneToMany(mappedBy = "patient"): One patient, many consultations; Consultation points back to Patient.
    private List<Consultation> consultations;


    public Long getIdPatient() {
        return idPatient;
    }

    public void setIdPatient(Long idPatient) {
        this.idPatient = idPatient;
    }

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