package com.clinique.service;

import com.clinique.model.Consultation;
import com.clinique.model.StatusConsultation;
import com.clinique.repository.ConsultationRepository;
import com.clinique.repository.DepartementRepository;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Inject;
import jakarta.inject.Named;

import java.time.LocalDateTime;
import java.util.List;


@Dependent
@Named
public class ConsultationService {

    @Inject
    private ConsultationRepository consultationRepository;


     public void save(Consultation consultation) {
        consultationRepository.save(consultation);
    }

     public void update(Consultation consultation) {
        consultationRepository.update(consultation);
    }

    // Find consultations for a doctor between dates
    public List<Consultation> getConsultationsForDoctorBetween(Long doctorId, LocalDateTime start, LocalDateTime end) {
        return consultationRepository.findByDoctorIdAndDateTimeBetweenAndStatusNot(doctorId, start, end, StatusConsultation.ANNULEE);
    }

    // Find by ID
    public Consultation findById(Long id) {
        return consultationRepository.findById(id);
    }

    public List<Consultation> getConsultationsForPatient(Long patientId) {
        return consultationRepository.findByPatientId(patientId);
    }


    public List<Consultation> findByDoctorAndStatus(Long doctorId, StatusConsultation status) {
        return consultationRepository.findByDoctorIdAndStatus(doctorId, status);
    }



    public boolean isSalleAvailableForSlot(Integer salleId, java.time.LocalDateTime dateTime) {
         return consultationRepository.findBySalleIdAndDateTime(Long.valueOf(salleId), dateTime).isEmpty();
    }
}
