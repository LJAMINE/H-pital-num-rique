//package com.clinique.example.model;
//
//import jakarta.persistence.*;
//
//@Entity
//public class Patient {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    private String name;
//    private String email;
//
//     public Patient() {}
//    public Patient(String name, String email) {
//        this.name = name;
//        this.email = email;
//    }
//
//     public Long getId() { return id; }
//    public String getName() { return name; }
//    public void setName(String name) { this.name = name; }
//    public String getEmail() { return email; }
//    public void setEmail(String email) { this.email = email; }
//}