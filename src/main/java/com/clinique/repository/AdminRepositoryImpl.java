package com.clinique.repository;

import com.clinique.model.Admin;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class AdminRepositoryImpl extends GenericRepositoryImpl<Admin, Long> implements AdminRepository {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("cliniquePU");
    private static EntityManager createEntityManager() {
        return emf.createEntityManager();
    }

    public AdminRepositoryImpl() {
        super(Admin.class, createEntityManager());
    }

    // Add Admin-specific methods here
}