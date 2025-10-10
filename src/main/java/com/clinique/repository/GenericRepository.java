package com.clinique.repository;

import java.util.List;

public interface GenericRepository<T,ID> {
        T findById(ID id);
        List<T> findAll();
        void save(T entity);
        T update (T entity);
        void delete(ID id);

}
