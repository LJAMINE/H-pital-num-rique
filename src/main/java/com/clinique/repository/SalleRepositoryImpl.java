package com.clinique.repository;

import com.clinique.model.Salle;
import com.clinique.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class SalleRepositoryImpl extends GenericRepositoryImpl<Salle, Integer> implements SalleRepository {
    private static EntityManager createEntityManager() {
        // Use the shared singleton factory
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }
    public SalleRepositoryImpl() {
        super(Salle.class, createEntityManager());
    }


    // Add Salle-specific methods here
}