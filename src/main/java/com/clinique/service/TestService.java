package com.clinique.service;

import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class TestService {
    public String getMessage() {
        return "Injected Service is working!";
    }
}