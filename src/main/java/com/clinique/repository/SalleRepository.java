package com.clinique.repository;

import com.clinique.model.Doctor;
import com.clinique.model.Salle;

import java.util.List;

public interface SalleRepository extends GenericRepository<Salle, Integer> {


    Salle findById(Integer id);
    List<Salle> findByDepartementId(Long departementId);

}