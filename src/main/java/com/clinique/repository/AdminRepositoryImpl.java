package com.clinique.repository;

import com.clinique.model.Admin;
import com.clinique.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;

@Dependent
@Named
public class AdminRepositoryImpl extends GenericRepositoryImpl<Admin, Long> implements AdminRepository {
    private static EntityManager createEntityManager() {
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }

    public AdminRepositoryImpl() {
        super(Admin.class, createEntityManager());
    }

    // Add Admin-specific methods here
}