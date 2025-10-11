package com.clinique.repository;

import com.clinique.model.Personne;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;

@Dependent
@Named
public class PersonneRepositoryImpl extends GenericRepositoryImpl<Personne, Long> implements PersonneRepository {
    @PersistenceContext
    private EntityManager entityManager;

    public PersonneRepositoryImpl() {
        super(Personne.class);
    }

    @Override
    public Personne findByEmail(String email) {
        try {
            return entityManager.createQuery(
                            "SELECT p FROM Personne p WHERE p.email = :email", Personne.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}