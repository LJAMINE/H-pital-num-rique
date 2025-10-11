package com.clinique.repository;

import com.clinique.model.Departement;

public class DepartementRepositoryImpl extends GenericRepositoryImpl<Departement, Long> implements DepartementRepository {
    public DepartementRepositoryImpl() {
        super(Departement.class);
    }
}