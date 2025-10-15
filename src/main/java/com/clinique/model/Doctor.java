package com.clinique.model;

import jakarta.persistence.*;
import java.util.List;

@Entity

public class Doctor extends Personne{



     private String specialite;

    @ManyToOne
    private Departement departement;


    @OneToMany(mappedBy="doctor")
    private List<Consultation> planning;

    @OneToMany(mappedBy = "doctor")
    private List<Availability> availabilities;



    //--------------------getter and setters-------------------

     public List<Availability> getAvailabilities() { return availabilities; }
    public void setAvailabilities(List<Availability> availabilities) { this.availabilities = availabilities; }



    public String getSpecialite() {
        return specialite;
    }

    public void setSpecialite(String specialite) {
        this.specialite = specialite;
    }

    public Departement getDepartement() {
        return departement;
    }

    public void setDepartement(Departement departement) {
        this.departement = departement;
    }

    public List<Consultation> getPlanning() {
        return planning;
    }

    public void setPlanning(List<Consultation> planning) {
        this.planning = planning;
    }
}