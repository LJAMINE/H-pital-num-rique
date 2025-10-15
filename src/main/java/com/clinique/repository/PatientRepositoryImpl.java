package com.clinique.repository;

import com.clinique.model.Patient;
import com.clinique.model.Personne;
import com.clinique.util.JPAUtil;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.*;

@Dependent
@Named
public class PatientRepositoryImpl extends GenericRepositoryImpl<Patient, Long> implements PatientRepository {

    private static EntityManager createEntityManager() {
        // Use the shared singleton factory
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }

    public PatientRepositoryImpl() {
        super(Patient.class, createEntityManager());
    }

    @Override
    public Patient findByEmail(String email) {

        try {

            return em.createQuery(
                            "SELECT p FROM Patient p WHERE p.email = :email", Patient.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
