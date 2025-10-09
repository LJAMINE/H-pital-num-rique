package com.clinique.listener;

import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class JpaInitListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // This will force Hibernate/JPA to initialize and create tables
        Persistence.createEntityManagerFactory("cliniquePU");
    }
}