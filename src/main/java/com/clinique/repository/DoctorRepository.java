package com.clinique.repository;

import com.clinique.model.Doctor;
import com.clinique.model.Patient;

public interface DoctorRepository extends GenericRepository<Doctor,Long> {
//    doc methdo

    Doctor findByEmail(String email);





}
