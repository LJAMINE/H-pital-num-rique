package com.clinique.repository;

import com.clinique.model.Patient;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;

@Dependent
@Named
public class PatientRepositoryImpl extends GenericRepositoryImpl<Patient, Long> implements PatientRepository {
    @PersistenceContext
    private EntityManager entityManager;

    public PatientRepositoryImpl() {
        super(Patient.class);
    }

    @Override
    public Patient findByEmail(String email) {

        try {

            return entityManager.createQuery(
                            "SELECT p FROM Patient p WHERE p.email = :email", Patient.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
