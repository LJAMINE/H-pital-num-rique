package com.clinique.repository;

import com.clinique.model.Patient;

public class PatientRepositoryImpl extends GenericRepositoryImpl<Patient,Long> implements PatientRepository {
    public PatientRepositoryImpl() {
        super(Patient.class);
    }
}
