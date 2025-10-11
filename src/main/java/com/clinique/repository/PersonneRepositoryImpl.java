package com.clinique.repository;

import com.clinique.model.Personne;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.*;

@Dependent
@Named
public class PersonneRepositoryImpl extends GenericRepositoryImpl<Personne, Long> implements PersonneRepository {
//    @PersistenceContext
//    private EntityManager entityManager;

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("cliniquePU");
    private EntityManager entityManager = emf.createEntityManager();

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