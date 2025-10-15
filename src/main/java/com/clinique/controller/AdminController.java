package com.clinique.controller;

import com.clinique.model.Departement;
import com.clinique.model.Doctor;
import com.clinique.model.Role;
import com.clinique.model.Salle;
import com.clinique.service.DepartementService;
import com.clinique.service.DoctorService;
import com.clinique.service.SalleService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminController extends HttpServlet {

    @Inject
    private DepartementService departementService;
    @Inject
    private DoctorService doctorService;
    @Inject
    private SalleService salleService;





    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getPathInfo();

        if (path == null || "/dashboard".equals(path)) {
//           stats

            req.getRequestDispatcher("/WEB-INF/jsp/admin/dashboard.jsp").forward(req, resp);

        } else if ("/departement".equals(path)) {
            // List Departments
            List<Departement> departements = departementService.getAllDepartements();
            req.setAttribute("departements", departements);
            req.getRequestDispatcher("/WEB-INF/jsp/admin/admin-departements.jsp").forward(req, resp);

        } else if ("/doctor".equals(path)) {
            // Show Doctor Creation Form
            List<Departement> departements = departementService.getAllDepartements();
            req.setAttribute("departements", departements);
            req.getRequestDispatcher("/WEB-INF/jsp/admin/admin-doctors.jsp").forward(req, resp);

        } else if ("/doctor-list".equals(path)) {
            // List Doctors
            List<Doctor> doctors = doctorService.getAllDoctors();
            req.setAttribute("doctors", doctors);
            req.getRequestDispatcher("/WEB-INF/jsp/admin/doctors-list.jsp").forward(req, resp);

        }
        else if ("/salle".equals(path)) {
            List<Departement> departements = departementService.getAllDepartements();
            req.setAttribute("departements", departements);
            req.getRequestDispatcher("/WEB-INF/jsp/admin/admin-salles.jsp").forward(req, resp);

        }else if ("/salle-list".equals(path)) {
            List<Salle> salles = salleService.getAllSalle();
            List<Departement> departements = departementService.getAllDepartements();
            req.setAttribute("salles", salles);
            req.setAttribute("departements", departements);
            req.getRequestDispatcher("/WEB-INF/jsp/admin/salles-list.jsp").forward(req, resp);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String path = req.getPathInfo();

        if ("/departement".equals(path)) {
            // Department Add/Update/Delete
            String action = req.getParameter("action");
            String nom = req.getParameter("nom");
            String idParam = req.getParameter("idDepartement");

            if ("update".equals(action) && idParam != null) {
                Long id = Long.valueOf(idParam);
                Departement dep = departementService.getDepartement(id);
                if (dep != null) {
                    dep.setNom(nom);
                    departementService.updateDepartement(dep);
                }
            } else if ("delete".equals(action) && idParam != null) {
                Long id = Long.valueOf(idParam);
                departementService.deleteDepartement(id);
            } else if (nom != null) {
                Departement departement = new Departement();
                departement.setNom(nom);
                departementService.addDepartement(departement);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/departement");

        } else if ("/doctor".equals(path)) {
            // Doctor Creation------
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String prenom = req.getParameter("prenom");
            String nom = req.getParameter("nom");
            String specialite = req.getParameter("specialite");
            Long departementId = Long.valueOf(req.getParameter("departementId"));

            Departement departement = departementService.getDepartement(departementId);

            Doctor doctor = new Doctor();
            doctor.setEmail(email);
            doctor.setMotDePasse(password);
            doctor.setPrenom(prenom);
            doctor.setNom(nom);
            doctor.setSpecialite(specialite);
            doctor.setDepartement(departement);
            doctor.setRole(Role.DOCTOR);

            doctorService.addDoctor(doctor);

            resp.sendRedirect(req.getContextPath() + "/admin/doctor-list");
        }
        else if ("/salle".equals(path)) {
            String action = req.getParameter("action");
            String nomSalle = req.getParameter("nomSalle");
            String capaciteParam = req.getParameter("capacite");
            String idParam = req.getParameter("idSalle");
            String departementIdParam = req.getParameter("departementId");

            Integer capacite = capaciteParam != null ? Integer.valueOf(capaciteParam) : null;
            Integer idSalle = idParam != null ? Integer.valueOf(idParam) : null;
            Long departementId = departementIdParam != null ? Long.valueOf(departementIdParam) : null;
            Departement departement = departementId != null ? departementService.getDepartement(departementId) : null;

            if ("update".equals(action) && idSalle != null) {
                Salle salle = salleService.getSalle(idSalle);
                if (salle != null) {
                    salle.setNomSalle(nomSalle);
                    salle.setCapacite(capacite);
                    salle.setDepartement(departement);
                    salleService.updateSalle(salle);
                }
            } else if ("delete".equals(action) && idSalle != null) {
                salleService.deleteSalle(idSalle);
            } else if (nomSalle != null && capacite != null && departement != null) {
                Salle salle = new Salle();
                salle.setNomSalle(nomSalle);
                salle.setCapacite(capacite);
                salle.setDepartement(departement);
                salleService.addSalle(salle);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/salle-list");
        }
    }
}