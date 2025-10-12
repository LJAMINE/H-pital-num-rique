package com.clinique.controller;


import com.clinique.model.Patient;
import com.clinique.model.Role;
import com.clinique.service.PatientService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register-patient")
public class RegisterPatientController extends HttpServlet {

    @Inject
    private PatientService patientService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email=req.getParameter("email");
        String password=req.getParameter("password");
        String nom=req.getParameter("nom");
        String prenom=req.getParameter("prenom");
        Double poids= Double.valueOf(req.getParameter("poids"));
        Double taille= Double.valueOf(req.getParameter("taille"));

        Patient patient=new Patient();
        patient.setEmail(email);
        patient.setMotDePasse(password);
        patient.setNom(nom);
        patient.setPrenom(prenom);
        patient.setPoids(poids);
        patient.setTaille(taille);

        patient.setRole(Role.PATIENT);


        patientService.registerPatient(patient);
        resp.sendRedirect("login.jsp?success=registered");

     }
}
