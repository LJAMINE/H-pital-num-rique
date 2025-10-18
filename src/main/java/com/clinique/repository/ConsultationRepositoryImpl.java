package com.clinique.repository;

import com.clinique.model.Consultation;
import com.clinique.model.Departement;
import com.clinique.model.Doctor;
import com.clinique.model.StatusConsultation;
import com.clinique.util.JPAUtil;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Persistence;

import java.time.LocalDateTime;
import java.util.List;


@Dependent
@Named
public class ConsultationRepositoryImpl extends GenericRepositoryImpl<Consultation, Long> implements ConsultationRepository {
    private static EntityManager createEntityManager() {
        // Use the shared singleton factory
        return JPAUtil.getEntityManagerFactory().createEntityManager();
    }

    public ConsultationRepositoryImpl() {
        super(Consultation.class, createEntityManager());
    }

    @Override
    public List<Consultation> findByDoctorIdAndDateTimeBetweenAndStatusNot(Long doctorId, LocalDateTime start, LocalDateTime end, StatusConsultation status) {
        return em.createQuery(
                        "SELECT c FROM Consultation c WHERE c.doctor.id = :doctorId AND c.dateTime BETWEEN :start AND :end AND c.status <> :status",
                        Consultation.class)
                .setParameter("doctorId", doctorId)
                .setParameter("start", start)
                .setParameter("end", end)
                .setParameter("status", status)
                .getResultList();
    }

    @Override
    public List<Consultation> findByPatientId(Long patientId) {
        return em.createQuery(
                        "SELECT c FROM Consultation c WHERE c.patient.id = :patientId ORDER BY c.dateTime DESC",
                        Consultation.class)
                .setParameter("patientId", patientId)
                .getResultList();
    }


    @Override
    public List<Consultation> findByDoctorIdAndStatus(Long doctorId, StatusConsultation status) {
        return em.createQuery("SELECT c FROM Consultation c WHERE c.doctor.id = :docId AND c.status = :status ORDER BY c.dateTime ASC", Consultation.class)
                .setParameter("docId", doctorId)
                .setParameter("status", status)
                .getResultList();
    }


    @Override
    public List<Consultation> findBySalleIdAndDateTime(Long salleId, LocalDateTime dateTime) {
        return em.createQuery("SELECT c FROM Consultation c WHERE c.salle.idSalle = :salleId AND c.dateTime = :dt AND c.status <> :annule", Consultation.class)
                .setParameter("salleId", salleId)
                .setParameter("dt", dateTime)
                .setParameter("annule", StatusConsultation.ANNULEE)
                .getResultList();
    }

}