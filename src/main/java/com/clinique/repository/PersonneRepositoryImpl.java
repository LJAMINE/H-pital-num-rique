package com.clinique.repository;

import com.clinique.model.Personne;
import com.clinique.util.JPAUtil;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.*;

@Dependent
@Named
public class PersonneRepositoryImpl extends GenericRepositoryImpl<Personne, Long> implements PersonneRepository {



    private static EntityManager createEntityManager() {
        // Use the shared singleton factory
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }
    public PersonneRepositoryImpl() {
        super(Personne.class, createEntityManager());
    }

    @Override
    public Personne findByEmail(String email) {
        try {
            return em.createQuery(
                            "SELECT p FROM Personne p WHERE p.email = :email", Personne.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}