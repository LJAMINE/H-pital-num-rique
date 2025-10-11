package com.clinique.service;

import com.clinique.model.Doctor;
import com.clinique.repository.DoctorRepository;
import com.clinique.exception.DoctorNotFoundException;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import java.util.List;

@Dependent
@Named
public class DoctorService {
    @Inject
    private DoctorRepository doctorRepository;

    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    public Doctor getDoctor(Long id) {
        Doctor doctor = doctorRepository.findById(id);
        if (doctor == null) {
            throw new DoctorNotFoundException("Doctor      not found.");
        }
        return doctor;
    }

     public Doctor addDoctor(Doctor doctor) {
        if (doctor == null || doctor.getEmail() == null || doctor.getMotDePasse() == null) {
            throw new IllegalArgumentException("Doctor email and password are required.");
        }
         Doctor existing = doctorRepository.findByEmail(doctor.getEmail());
        if (existing != null) {
            throw new IllegalStateException("Email already exists!");
        }
        doctorRepository.save(doctor);
        return doctor;
    }

     public Doctor updateDoctor(Doctor doctor) {
        if (doctor == null || doctor.getId() == null) {
            throw new IllegalArgumentException("Doctor and ID required for update.");
        }
        Doctor existing = doctorRepository.findById(doctor.getId());
        if (existing == null) {
            throw new DoctorNotFoundException("Doctor not found for update.");
        }
        return doctorRepository.update(doctor);
    }

     public void deleteDoctor(Long id) {
        Doctor existing = doctorRepository.findById(id);
        if (existing == null) {
            throw new DoctorNotFoundException("Doctor not found for deletion.");
        }
        doctorRepository.delete(id);
    }
}