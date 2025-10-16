package com.clinique.controller;

import com.clinique.model.Availability;
import com.clinique.model.Doctor;
import com.clinique.model.Personne;
import com.clinique.model.Role;
import com.clinique.service.AvailabilityService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.List;

@WebServlet(urlPatterns = {
        "/doctor/dashboard",
        "/doctor/availabilities",
        "/doctor/availabilities/add",
        "/doctor/availabilities/delete",
        "/doctor/availabilities/edit",
        "/doctor/availabilities/update"
})
public class DoctorController extends HttpServlet {

    @Inject
    private AvailabilityService availabilityService;

    // Dashboard
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

        } else if ("/doctor/availabilities".equals(path)) {
            Long doctorId = user.getId();
            List<Availability> availabilities = availabilityService.getAllAvailabiliytyForDoctor(doctorId);
            request.setAttribute("availabilities", availabilities);
            request.getRequestDispatcher("/WEB-INF/jsp/doctor/availabilities.jsp").forward(request, response);

        } else if ("/doctor/availabilities/delete".equals(path)) {
            Long id = Long.valueOf(request.getParameter("id"));
            availabilityService.deleteAvailability(id);
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities");

        } else if ("/doctor/availabilities/edit".equals(path)) {
            Long id = Long.valueOf(request.getParameter("id"));
            Availability availability = availabilityService.getAvailability(id);
            request.setAttribute("availability", availability);
            request.getRequestDispatcher("/WEB-INF/jsp/doctor/edit-availability.jsp").forward(request, response);
        }
    }

    // add and update
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

        if ("/doctor/availabilities/add".equals(path)) {
            DayOfWeek day = DayOfWeek.valueOf(request.getParameter("dayOfWeek"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            availabilityService.addAvailabity(doctorId, day, startTime, endTime);
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities");

        } else if ("/doctor/availabilities/update".equals(path)) {
            Long id = Long.valueOf(request.getParameter("id"));
            DayOfWeek day = DayOfWeek.valueOf(request.getParameter("dayOfWeek"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            availabilityService.updateAvailabity(id, day, startTime, endTime);
            response.sendRedirect(request.getContextPath() + "/doctor/availabilities");
        }
    }
}