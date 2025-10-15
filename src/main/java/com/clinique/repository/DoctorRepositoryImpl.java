package com.clinique.repository;

import com.clinique.model.Doctor;
import com.clinique.util.JPAUtil;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

@Dependent
@Named
public class DoctorRepositoryImpl extends GenericRepositoryImpl<Doctor, Long> implements DoctorRepository {
    private static EntityManager createEntityManager() {
        // Use the shared singleton factory
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }
    public DoctorRepositoryImpl() {
        super(Doctor.class, createEntityManager());
    }


    @Override
    public Doctor findByEmail(String email) {
        try {
            return em.createQuery(
                            "SELECT d FROM Doctor d WHERE d.email = :email", Doctor.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}