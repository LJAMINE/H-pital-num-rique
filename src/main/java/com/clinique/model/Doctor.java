package com.clinique.model;

import jakarta.persistence.*;
import java.util.List;

@Entity

public class Doctor extends Personne{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private Long idDocteur;
    private String specialite;

    @ManyToOne
    private Departement departement;

    @OneToMany(mappedBy="doctor")
    private List<Consultation> planning;


    public Long getIdDocteur() {
        return idDocteur;
    }

    public void setIdDocteur(Long idDocteur) {
        this.idDocteur = idDocteur;
    }

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