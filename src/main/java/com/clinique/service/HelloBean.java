package com.clinique.service;

import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public  class HelloBean{
    public  String sayHello(){
        return "CDI is working";
     }
}