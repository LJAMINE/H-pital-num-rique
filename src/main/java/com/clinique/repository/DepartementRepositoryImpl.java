package com.clinique.repository;

import com.clinique.model.Departement;
import com.clinique.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class DepartementRepositoryImpl extends GenericRepositoryImpl<Departement, Long> implements DepartementRepository {
    private static EntityManager createEntityManager() {
        // Use the shared singleton factory
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }
    public DepartementRepositoryImpl() {
        super(Departement.class, createEntityManager());
    }


}