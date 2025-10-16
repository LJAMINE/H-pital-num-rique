package com.clinique.controller;

import com.clinique.model.*;
import com.clinique.service.DoctorService;
import com.clinique.service.SlotService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
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

        } else if ("/doctor".equals(path)) {
            Long doctorId = Long.valueOf(req.getParameter("id"));
            Doctor doctor = doctorService.getDoctor(doctorId);

//            get available for doctor
            List<Availability> availabilities = doctorService.getAvailabilitiesForDoctor(doctorId);
//            next 7 days
            LocalDate weekstart = LocalDate.now();
            LocalDate weekEnd = weekstart.plusDays(6);

            SlotService slotService=new SlotService();
            List<Slot>allSlots=new ArrayList<>();

            for (Availability a : availabilities){
                allSlots.addAll(slotService.generateSlotsForAvailability(a,weekstart,weekEnd));
            }

            // Get already booked consultations (not cancelled)
            List<Consultation> consultations = doctorService.getConsultationsForDoctorBetween(
                    doctorId, weekstart.atStartOfDay(), weekEnd.atTime(LocalTime.MAX)
            );
            List<Slot> availableSlots = slotService.filterBookedSlots(allSlots, consultations);

            req.setAttribute("doctor",doctor);
            req.setAttribute("slots",availableSlots);
            req.setAttribute("patient",user);
            req.getRequestDispatcher("/WEB-INF/jsp/patient/doctor-slots.jsp").forward(req, resp);

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