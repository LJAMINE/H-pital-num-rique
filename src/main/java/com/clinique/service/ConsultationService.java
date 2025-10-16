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

}
