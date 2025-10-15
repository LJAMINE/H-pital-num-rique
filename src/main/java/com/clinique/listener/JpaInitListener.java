package com.clinique.listener;

import com.clinique.util.JPAUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class JpaInitListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Initialize EMF via JPAUtil; guard to avoid crashing startup.
        // Retry a few times in case DB isn't ready yet (Docker race).
        int attempts = 0;
        int maxAttempts = 15; // ~30 seconds total
        while (attempts < maxAttempts) {
            attempts++;
            try {
                // Ensure a fresh EMF attempt each time until success
                if (attempts > 1) {
                    JPAUtil.close();
                }
                var emf = JPAUtil.getEntityManagerFactory();
                // Touch the EM to force schema generation when hbm2ddl.auto=create
                var em = emf.createEntityManager();
                em.getTransaction().begin();
                em.createNativeQuery("SELECT 1").getSingleResult();
                em.getTransaction().commit();
                em.close();
                break; // success
            } catch (Exception e) {
                // Log and retry shortly
                try { Thread.sleep(2000); } catch (InterruptedException ignored) {}
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Close EMF gracefully
        JPAUtil.close();
    }
}