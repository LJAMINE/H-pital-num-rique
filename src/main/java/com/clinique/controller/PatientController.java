package com.clinique.controller;

import com.clinique.model.Doctor;
import com.clinique.model.Personne;
import com.clinique.model.Role;
import com.clinique.service.DoctorService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/patient/*")
public class PatientController extends HttpServlet {

    @Inject
    private DoctorService doctorService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
         HttpSession session = req.getSession();
        Personne user = (Personne) session.getAttribute("user");
        
        if (user == null || user.getRole() != Role.PATIENT) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            return;
        }

        String path = req.getPathInfo();

        if ("/doctors".equals(path) || "/rendez-vous".equals(path)) {

//            afficher all doctors

            List<Doctor> doctors = doctorService.getAllDoctors();
            req.setAttribute("doctors", doctors);
            req.setAttribute("patient", user);
            req.getRequestDispatcher("/WEB-INF/jsp/patient/doctors-list.jsp").forward(req, resp);
            
        } else {
            //   patient dashboard
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        

    }
}