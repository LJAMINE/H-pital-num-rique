package com.clinique.repository;

import com.clinique.model.Consultation;
import com.clinique.model.Departement;
import com.clinique.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class ConsultationRepositoryImpl extends GenericRepositoryImpl<Consultation, Long> implements ConsultationRepository {
    private static EntityManager createEntityManager() {
        // Use the shared singleton factory
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }
    public ConsultationRepositoryImpl() {
        super(Consultation.class, createEntityManager());
    }

 }