package com.clinique.repository;

import com.clinique.model.Doctor;
import com.clinique.model.Salle;

public interface SalleRepository extends GenericRepository<Salle, Integer> {


    Salle findById(Integer id);
}