package com.clinique.repository;

import com.clinique.model.Consultation;

public class ConsultationRepositoryImpl extends GenericRepositoryImpl<Consultation, Long> implements ConsultationRepository {
    public ConsultationRepositoryImpl() {
        super(Consultation.class);
    }
}