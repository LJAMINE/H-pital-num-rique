package com.clinique.controller;

import com.clinique.service.TestService;
import jakarta.inject.Inject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/test-inject")
public class InjectServlet extends HttpServlet {

    @Inject
    private TestService testService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        try {
            resp.setContentType("text/plain");
            resp.getWriter().write(testService.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}