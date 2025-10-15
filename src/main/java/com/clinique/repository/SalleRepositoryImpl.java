package com.clinique.repository;

import com.clinique.model.Doctor;
import com.clinique.model.Salle;
import com.clinique.util.JPAUtil;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;


@Dependent
@Named
public class SalleRepositoryImpl extends GenericRepositoryImpl<Salle, Integer> implements SalleRepository {
    private static EntityManager createEntityManager() {
        // Use the shared singleton factory
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }

    public SalleRepositoryImpl() {
        super(Salle.class, createEntityManager());
    }

    @Override
    public Salle findById(Integer id) {
        try {
            return em.createQuery(
                            "SELECT s FROM Salle s WHERE s.idSalle = :id", Salle.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }


}