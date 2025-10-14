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



    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


    }
}
