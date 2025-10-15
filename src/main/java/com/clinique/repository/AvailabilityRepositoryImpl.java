package com.clinique.repository;

import com.clinique.model.Availability;
import com.clinique.util.JPAUtil;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;

import java.util.List;

@Dependent
@Named
public class AvailabilityRepositoryImpl extends GenericRepositoryImpl<Availability, Long> implements AvailabilityRepository {

    private static EntityManager createEntityManager() {
        // Use the shared singleton factory
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }

    public AvailabilityRepositoryImpl() {
        super(Availability.class, createEntityManager());
    }
    @Override
    public List<Availability> findByDoctorId(Long doctorId) {
        return em.createQuery("SELECT a FROM Availability a WHERE a.doctor.id = :doctorId", Availability.class)
                .setParameter("doctorId", doctorId)
                .getResultList();
    }


}
