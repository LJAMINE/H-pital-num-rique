package com.clinique.repository;

import com.clinique.model.Doctor;
import com.clinique.model.Patient;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;


@Dependent
@Named
public class DoctorRepositoryImpl extends GenericRepositoryImpl<Doctor, Long> implements DoctorRepository {
    @PersistenceContext
    private EntityManager entityManager;

    public DoctorRepositoryImpl() {
        super(Doctor.class);
    }



    @Override
    public Doctor findByEmail(String email) {

        try {

            return entityManager.createQuery(
                            "SELECT p FROM Doctor p WHERE p.email = :email", Doctor.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
