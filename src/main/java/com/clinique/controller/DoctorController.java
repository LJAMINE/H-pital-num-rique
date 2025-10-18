package com.clinique.controller;

import com.clinique.model.*;
import com.clinique.service.AvailabilityService;
import com.clinique.service.ConsultationService;
import com.clinique.service.SalleService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(urlPatterns = {
        "/doctor/dashboard",
        "/doctor/availabilities",
        "/doctor/availabilities/add",
        "/doctor/availabilities/delete",
        "/doctor/availabilities/edit",
        "/doctor/availabilities/update",
        "/doctor/consultations",                // list pending consultations
        "/doctor/consultation/action"           // handle valider / annuler
})
public class DoctorController extends HttpServlet {

    @Inject
    private AvailabilityService availabilityService;

    @Inject
    private ConsultationService consultationService;

    @Inject
    private SalleService salleService;

    // Dashboard + listing availabilities + consultations
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        Personne user = (Personne) request.getSession().getAttribute("user");
        if (user == null || user.getRole() != Role.DOCTOR) {
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }

        if ("/doctor/dashboard".equals(path)) {
            request.getRequestDispatcher("/WEB-INF/jsp/doctor/dashboard.jsp").forward(request, response);
            return;
        }

        if ("/doctor/availabilities".equals(path)) {
            Long doctorId = user.getId();
            List<Availability> availabilities = availabilityService.getAllAvailabiliytyForDoctor(doctorId);
            request.setAttribute("availabilities", availabilities);
            request.getRequestDispatcher("/WEB-INF/jsp/doctor/availabilities.jsp").forward(request, response);
            return;
        }

        if ("/doctor/availabilities/delete".equals(path)) {
            Long id = Long.valueOf(request.getParameter("id"));
            availabilityService.deleteAvailability(id);
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities");
            return;
        }

        if ("/doctor/availabilities/edit".equals(path)) {
            Long id = Long.valueOf(request.getParameter("id"));
            Availability availability = availabilityService.getAvailability(id);
            request.setAttribute("availability", availability);
            request.getRequestDispatcher("/WEB-INF/jsp/doctor/edit-availability.jsp").forward(request, response);
            return;
        }

        if ("/doctor/consultations".equals(path)) {
            // Show pending consultations (RESERVEE)
            Long doctorId = user.getId();
            List<Consultation> pending = consultationService.findByDoctorAndStatus(doctorId, StatusConsultation.RESERVEE);
            request.setAttribute("consultations", pending);

            // Build a map of departementId -> list<Salle> so JSP can populate salle dropdowns efficiently
            Map<Long, List<Salle>> sallesByDept = new HashMap<>();
            for (Consultation c : pending) {
                if (c.getDoctor() != null && c.getDoctor().getDepartement() != null) {
                    Long depId = c.getDoctor().getDepartement().getIdDepartement();
                    if (!sallesByDept.containsKey(depId)) {
                        List<Salle> salles = salleService.getSallesForDepartement(depId);

                        sallesByDept.put(depId, salles);
                    }
                }
            }
            request.setAttribute("sallesByDept", sallesByDept);
            request.getRequestDispatcher("/WEB-INF/jsp/doctor/consultations.jsp").forward(request, response);
            return;
        }

        // fallback
        response.sendRedirect(request.getContextPath() + "/");
    }

    // add/update availabilities + handle consultation actions (validate/cancel)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        Personne user = (Personne) request.getSession().getAttribute("user");
        if (user == null || user.getRole() != Role.DOCTOR) {
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }

        Long doctorId = user.getId();

        // --- availability add/update handlers (unchanged behavior) ---
        if ("/doctor/availabilities/add".equals(path)) {
            DayOfWeek day = DayOfWeek.valueOf(request.getParameter("dayOfWeek"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            availabilityService.addAvailabity(doctorId, day, startTime, endTime);
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities");
            return;
        }

        if ("/doctor/availabilities/update".equals(path)) {
            Long id = Long.valueOf(request.getParameter("id"));
            DayOfWeek day = DayOfWeek.valueOf(request.getParameter("dayOfWeek"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            availabilityService.updateAvailabity(id, day, startTime, endTime);
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities");
            return;
        }

        // --- consultation actions: validate / cancel ---
        if ("/doctor/consultation/action".equals(path)) {
            String action = request.getParameter("action"); // "valider" or "annuler"
            Long consultationId = Long.valueOf(request.getParameter("consultationId"));

            Consultation consultation = consultationService.findById(consultationId);
            if (consultation == null) {
                response.sendRedirect(request.getContextPath() + "/doctor/consultations?error=notfound");
                return;
            }

            if ("annuler".equals(action)) {
                consultation.setStatus(StatusConsultation.ANNULEE);
                consultationService.update(consultation);
                response.sendRedirect(request.getContextPath() + "/doctor/consultations?success=annule");
                return;
            } else if ("valider".equals(action)) {
                String salleIdParam = request.getParameter("salleId");
                if (salleIdParam != null && !salleIdParam.trim().isEmpty()) {
                    Integer salleId = Integer.valueOf(salleIdParam);
                    // check availability (no conflicting non-cancelled consultation for that salle and dateTime)
                    boolean available = consultationService.isSalleAvailableForSlot(salleId, consultation.getDateTime());
                    if (!available) {
                        response.sendRedirect(request.getContextPath() + "/doctor/consultations?error=salle-unavailable");
                        return;
                    } else {
                        // assign salle
                        Salle salle = salleService.getSalle(salleId);
                        consultation.setSalle(salle);
                    }
                }
                consultation.setStatus(StatusConsultation.VALIDEE);
                consultationService.update(consultation);
                response.sendRedirect(request.getContextPath() + "/doctor/consultations?success=valide");
                return;
            }

            // unknown action -> redirect
            response.sendRedirect(request.getContextPath() + "/doctor/consultations");
        }
    }
}