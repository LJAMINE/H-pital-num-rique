package com.clinique.repository;

import com.clinique.model.Consultation;
import com.clinique.model.StatusConsultation;

import java.time.LocalDateTime;
import java.util.List;

public interface ConsultationRepository extends GenericRepository<Consultation, Long> {
    List<Consultation> findByDoctorIdAndDateTimeBetweenAndStatusNot(Long doctorId, LocalDateTime start, LocalDateTime end, StatusConsultation status);
    List<Consultation> findByPatientId(Long patientId);

    List<Consultation> findBySalleIdAndDateTime(Long salleId, LocalDateTime dateTime);
    List<Consultation> findByDoctorIdAndStatus(Long doctorId, StatusConsultation status);

}