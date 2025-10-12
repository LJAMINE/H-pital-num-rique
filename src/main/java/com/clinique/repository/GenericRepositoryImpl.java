package com.clinique.repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

public class GenericRepositoryImpl<T, ID> implements GenericRepository<T, ID> {

//    @PersistenceContext
//    protected EntityManager em;


    protected EntityManager em;

    private final Class<T> entityClass;


    public GenericRepositoryImpl(Class<T> entityClass,EntityManager em) {
        this.entityClass = entityClass;
        this.em = em;

    }

    @Override
    public T findById(ID id) {
        return em.find(entityClass, id);
    }

    @Override
    public List<T> findAll() {
        return em.createQuery("SELECT e FROM "+entityClass.getSimpleName()+" e",entityClass).getResultList();
     }

    @Override
    public void save(T entity) {
        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();
    }

    @Override
    public T update(T entity) {
        em.getTransaction().begin();
        T merged = em.merge(entity);
        em.getTransaction().commit();
        return merged;
    }

    @Override
    public void delete(ID id) {
        em.getTransaction().begin();
        T entity = findById(id);
        if (entity != null) {
            em.remove(entity);
        }
        em.getTransaction().commit();
    }
}
