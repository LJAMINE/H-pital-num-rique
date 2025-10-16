package com.clinique.service;


import com.clinique.exception.DoctorNotFoundException;
import com.clinique.exception.SalleNotFoundException;
import com.clinique.model.Doctor;
import com.clinique.model.Salle;
import com.clinique.repository.SalleRepository;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Inject;
import jakarta.inject.Named;

import java.time.LocalDateTime;
import java.util.List;

@Dependent
@Named
public class SalleService {


    @Inject
    private SalleRepository salleRepository;

    public List<Salle> getAllSalle() {
        return salleRepository.findAll();
    }

    public Salle getSalle(Integer id) {
        Salle salle = salleRepository.findById(id);
        if (salle == null) {
            throw new SalleNotFoundException("salle  not found.");
        }
        return salle;
    }



    public Salle addSalle(Salle salle) {
        if (salle == null || salle.getCapacite() == null || salle.getNomSalle() == null) {
            throw new IllegalArgumentException("salle inputs  are required.");
        }
        Salle existing = salleRepository.findById(salle.getIdSalle());
        if (existing != null) {
            throw new IllegalStateException("id  already exists!");
        }
        salleRepository.save(salle);
        return salle;
    }

    public Salle updateSalle(Salle salle) {
        if (salle == null || salle.getIdSalle() == null) {
            throw new IllegalArgumentException("salle and ID required for update.");
        }
        Salle existing = salleRepository.findById(salle.getIdSalle());
        if (existing == null) {
            throw new SalleNotFoundException("salle not found for update.");
        }
        return salleRepository.update(salle);
    }

    public void deleteSalle(Integer id) {
        Salle existing = salleRepository.findById(id);
        if (existing == null) {
            throw new SalleNotFoundException("Salle  not found for deletion.");
        }
        salleRepository.delete(id);
    }

    public Salle findAvailableSalle(Long departementId, LocalDateTime dateTime) {
        List<Salle> salles = salleRepository.findByDepartementId(departementId);
        for (Salle salle : salles) {
            boolean isFree = salle.getConsultations().stream()
                    .noneMatch(c -> c.getDateTime().equals(dateTime));
            if (isFree) {
                return salle;
            }
        }
        return null;
    }
}
