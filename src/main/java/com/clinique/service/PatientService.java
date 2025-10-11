package com.clinique.service;


import com.clinique.exception.PatientNotFoundException;
import com.clinique.model.Patient;
import com.clinique.model.Role;
import com.clinique.repository.PatientRepository;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Inject;
import jakarta.inject.Named;

import java.util.List;

@Dependent
@Named
public class PatientService {
    @Inject
    private PatientRepository patientRepository;


    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    public Patient getPatient(Long id) {

        Patient patient = patientRepository.findById(id);
        if (patient == null) {
            throw new PatientNotFoundException("patient not found ");
        }
        return patient;
    }

    public Patient addPatient(Patient patient) {
        if (patient == null || patient.getEmail() == null || patient.getMotDePasse() == null) {
            throw new IllegalArgumentException("Patient email and password are required.");
        }
        Patient existing = patientRepository.findByEmail(patient.getEmail());
        if (existing != null) {
            throw new IllegalStateException("Email already exists!");
        }
        patientRepository.save(patient);
        return patient;
    }

    public Patient updatePatient(Patient patient){
        if (patient==null ||  patient.getId()==null){
            throw new IllegalArgumentException("Patient and ID required for update.");

        }
        Patient existing =patientRepository.findById(patient.getId());

        if (existing == null) {
            throw new PatientNotFoundException("Patient not found for update.");
        }
        return patientRepository.update(patient);
    }

    public void deletePatient(Long id) {
        Patient existing = patientRepository.findById(id);
        if (existing == null) {
            throw new PatientNotFoundException("Patient not found for deletion.");
        }
        patientRepository.delete(id);
    }

    public boolean registerPatient(Patient patient){
        if (patientRepository.findByEmail(patient.getEmail())!=null){
            return false; // Email already existsin db
        }
        patient.setRole(Role.PATIENT);
        patientRepository.save(patient);
        return  true ;
    }

}
