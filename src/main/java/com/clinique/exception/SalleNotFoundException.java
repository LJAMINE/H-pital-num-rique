package com.clinique.exception;

public class SalleNotFoundException extends RuntimeException {
    public SalleNotFoundException(String message) {
        super(message);
    }
}
