package com.clinique.repository;

import com.clinique.model.Salle;

public class SalleRepositoryImpl extends GenericRepositoryImpl<Salle, Integer> implements SalleRepository {
    public SalleRepositoryImpl() {
        super(Salle.class);
    }
}