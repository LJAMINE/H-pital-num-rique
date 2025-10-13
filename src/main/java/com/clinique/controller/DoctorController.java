package com.clinique.controller;

import com.clinique.model.Departement;
import com.clinique.model.Doctor;
import com.clinique.model.Role;
import com.clinique.service.DepartementService;
import com.clinique.service.DoctorService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


@WebServlet("/doctor")
public class DoctorController extends HttpServlet {

    @Inject
    private DepartementService departementService;

    @Inject
    private DoctorService doctorService;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        List<Departement> departements = departementService.getAllDepartements();
//        req.setAttribute("departements", departements);
//        req.getRequestDispatcher("/WEB-INF/jsp/admin/admin-doctors.jsp").forward(req, resp);


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

//        String email=req.getParameter("email");
//        String password=req.getParameter("password");
//        String prenom=req.getParameter("prenom");
//        String nom=req.getParameter("nom");
//        String specialite=req.getParameter("specialite");
//
//        Long departementId = Long.valueOf(req.getParameter("departementId"));
//
//        Departement departement = departementService.getDepartement(departementId);
//
//        Doctor doctor=new Doctor();
//        doctor.setEmail(email);
//        doctor.setMotDePasse(password);
//        doctor.setPrenom(prenom);
//        doctor.setNom(nom);
//        doctor.setSpecialite(specialite);
//        doctor.setDepartement(departement);
//
//        doctor.setRole(Role.DOCTOR);
//        doctorService.addDoctor(doctor);
//
//        resp.sendRedirect("doctor");

    }
}
