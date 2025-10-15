package com.clinique.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {
    // Only ONE EntityManagerFactory instance for the entire application (lazy init)
    private static volatile EntityManagerFactory emf;

    public static EntityManagerFactory getEntityManagerFactory() {
        if (emf == null || !emf.isOpen()) {
            synchronized (JPAUtil.class) {
                if (emf == null || !emf.isOpen()) {
                    emf = Persistence.createEntityManagerFactory("cliniquePU");
                }
            }
        }
        return emf;
    }

    // Gracefully close EMF on application shutdown
    public static void close() {
        try {
            if (emf != null && emf.isOpen()) {
                emf.close();
            }
        } catch (Exception ignored) {
        }
    }
}