package com.clinique.model;

import jakarta.persistence.*;

import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.List;
import java.util.Set;

@Entity

public class Doctor extends Personne{



     private String specialite;

    @ManyToOne
    private Departement departement;


    @OneToMany(mappedBy="doctor")
    private List<Consultation> planning;









    //--------------------getter and setters-------------------





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