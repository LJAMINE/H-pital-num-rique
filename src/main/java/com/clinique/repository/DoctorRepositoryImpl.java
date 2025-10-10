package com.clinique.repository;

import com.clinique.model.Doctor;

public class DoctorRepositoryImpl extends GenericRepositoryImpl<Doctor, Long> implements DoctorRepository {
    public DoctorRepositoryImpl() {
        super(Doctor.class);
    }
}
