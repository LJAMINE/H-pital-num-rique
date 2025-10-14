package com.clinique.controller;


import com.clinique.model.Personne;
import com.clinique.service.AuthService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
 public class AuthController extends HttpServlet {

    @Inject
    private AuthService authService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Personne user = authService.login(email, password);

        if (user != null) {
            // Store user in session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);

            // Forward based on role
            switch (user.getRole()) {
                case PATIENT:
                    // Redirect patients to homepage with login session
                    response.sendRedirect(request.getContextPath() + "/");
                    break;
                case DOCTOR:
                    request.getRequestDispatcher("/WEB-INF/jsp/doctor/dashboard.jsp").forward(request, response);
                    break;
                case ADMIN:
                    request.getRequestDispatcher("/WEB-INF/jsp/admin/dashboard.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("login.jsp?error=unknownrole");
            }
        } else {
            // Invalid login
            response.sendRedirect("login.jsp?error=invalid");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to login.jsp
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }


}
