package com.clinique.service;


import com.clinique.model.Departement;
import com.clinique.repository.DepartementRepository;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Inject;
import jakarta.inject.Named;

import java.util.List;

@Dependent
@Named
public class DepartementService {
    @Inject
    private DepartementRepository departementRepository;

    public Departement addDepartement(Departement departement) {
        departementRepository.save(departement);
        return departement;
    }

    public Departement getDepartement(Long id) {
        return departementRepository.findById(id);
    }

    public List<Departement> getAllDepartements() {
        return departementRepository.findAll();
    }

    public Departement updateDepartement(Departement departement) {
        return departementRepository.update(departement);
    }

    public void deleteDepartement(Long id) {
        departementRepository.delete(id);
    }

}
