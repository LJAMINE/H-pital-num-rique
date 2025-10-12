package com.clinique.controller;

import com.clinique.model.Departement;
import com.clinique.service.DepartementService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/departement")
public class DepartementController extends HttpServlet {

    @Inject
    private DepartementService departementService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle delete if requested
        String action = req.getParameter("action");
        String idParam = req.getParameter("idDepartement");

        if ("delete".equals(action) && idParam != null) {
            Long id = Long.valueOf(idParam);
            departementService.deleteDepartement(id);
            resp.sendRedirect("departement") ;
            return;
        }

        // List all departments
        List<Departement> departements = departementService.getAllDepartements();
        req.setAttribute("departements", departements);
        req.getRequestDispatcher("/WEB-INF/jsp/admin/admin-departements.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Handle add and update operations
        String action = req.getParameter("action");
        String nom = req.getParameter("nom");
        String idParam = req.getParameter("idDepartement");

        if ("update".equals(action) && idParam != null) {
            // Update department
            Long id = Long.valueOf(idParam);
            Departement dep = departementService.getDepartement(id);
            if (dep != null) {
                dep.setNom(nom);
                departementService.updateDepartement(dep);
            }
        } else {
            // Add new department
            Departement departement = new Departement();
            departement.setNom(nom);
            departementService.addDepartement(departement);
        }
        resp.sendRedirect("departement");
    }
}