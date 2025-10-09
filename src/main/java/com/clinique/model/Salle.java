package com.clinique.model;

import jakarta.persistence.*;

import java.util.List;

@Entity
class Salle{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idSalle;

    private String nomSalle;
    private Integer capacite;

    @OneToMany(mappedBy = "salle")
    private List<Consultation> consultations;



    //--------------------getter and setters-------------------


    public Integer getIdSalle() {
        return idSalle;
    }

    public void setIdSalle(Integer idSalle) {
        this.idSalle = idSalle;
    }

    public String getNomSalle() {
        return nomSalle;
    }

    public void setNomSalle(String nomSalle) {
        this.nomSalle = nomSalle;
    }

    public Integer getCapacite() {
        return capacite;
    }

    public void setCapacite(Integer capacite) {
        this.capacite = capacite;
    }

    public List<Consultation> getConsultations() {
        return consultations;
    }

    public void setConsultations(List<Consultation> consultations) {
        this.consultations = consultations;
    }
}