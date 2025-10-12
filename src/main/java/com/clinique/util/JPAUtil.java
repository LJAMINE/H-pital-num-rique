package com.clinique.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {
    // Only ONE EntityManagerFactory instance for the entire application!
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("cliniquePU");

    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }
}