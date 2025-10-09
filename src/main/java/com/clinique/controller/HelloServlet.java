package com.clinique.controller;

import com.clinique.service.HelloBean;
import jakarta.inject.Inject;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet {

    @Inject
    private HelloBean helloBean;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        try {
            resp.setContentType("text/plain");
            resp.getWriter().write(helloBean.sayHello());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}