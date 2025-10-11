package com.clinique.service;

import com.clinique.model.Personne;
import com.clinique.model.Role;
import com.clinique.repository.PersonneRepository;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Inject;
import jakarta.inject.Named;

@Dependent
@Named
public class AuthService {

    @Inject
    private PersonneRepository personneRepository;

//    login-------------------------------

    public Personne login (String email,String password){

        if (email==null || password ==null){
            return null;
        }

        Personne user =personneRepository.findByEmail(email);
        if (user!=null && user.getMotDePasse().equals(password) ){
            return user ;
        }
        return null;
    }

//    role check-----------------------------

    public boolean isPatient(Personne user){
        return user!=null && user.getRole()== Role.PATIENT;
    }

    public boolean isDoctor(Personne user) {
        return user != null && user.getRole() == Role.DOCTOR;
    }

    public boolean isAdmin(Personne user) {
        return user != null && user.getRole() == Role.ADMIN;
    }




}
