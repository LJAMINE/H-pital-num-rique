//package com.clinique.example;
//import com.clinique.example.model.Patient;
//import jakarta.persistence.*;
//
//public class TestHibernate {
//    public static void main(String[] args) {
//        EntityManagerFactory emf = Persistence.createEntityManagerFactory("cliniquePU");
//        EntityManager em = emf.createEntityManager();
//
//        em.getTransaction().begin();
//        Patient p = new Patient("Alice", "alice@ex.com");
//        em.persist(p);
//        em.getTransaction().commit();
//
//        em.close();
//        emf.close();
//    }
//}