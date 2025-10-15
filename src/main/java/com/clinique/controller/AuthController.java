package com.clinique.controller;


import com.clinique.model.Patient;
import com.clinique.model.Personne;
import com.clinique.model.Role;
import com.clinique.service.AuthService;
import com.clinique.service.PatientService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/logout", "/register"})
public class AuthController extends HttpServlet {

    @Inject
    private AuthService authService;

    @Inject
    private PatientService patientService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/login".equals(path)) {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Personne user = authService.login(email, password);

            if (user != null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);

                switch (user.getRole()) {
                    case PATIENT:
                        response.sendRedirect(request.getContextPath() + "/");
                        break;
                    case DOCTOR:
                        response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
                        break;
                    case ADMIN:
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                        break;
                    default:
                        response.sendRedirect(request.getContextPath() + "/login?error=unknownrole");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login?error=invalid");
            }

        } else if ("/register".equals(path)) {
            // Patient register
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");
            Double poids = null;
            Double taille = null;
            try {
                poids = Double.valueOf(request.getParameter("poids"));
                taille = Double.valueOf(request.getParameter("taille"));
            } catch (Exception e) {
                throw new RuntimeException("error");
            }

            Patient patient = new Patient();
            patient.setEmail(email);
            patient.setMotDePasse(password);
            patient.setNom(nom);
            patient.setPrenom(prenom);
            patient.setPoids(poids);
            patient.setTaille(taille);
            patient.setRole(Role.PATIENT);

            boolean success = patientService.registerPatient(patient);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/login?success=registered");
            } else {
                response.sendRedirect(request.getContextPath() + "/register?error=exists");
            }
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/login".equals(path)) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else if ("/register".equals(path)) {
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } else if ("/logout".equals(path)) {
            HttpSession session = request.getSession(false);

            if (session != null) {
                session.invalidate();
            }

            response.sendRedirect(request.getContextPath() + "/login?logout=success");

        }

    }


}