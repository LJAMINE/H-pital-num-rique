package com.clinique.repository;

import com.clinique.model.Admin;
import com.clinique.model.Doctor;

public class AdminRepositoryImpl extends GenericRepositoryImpl<Admin, Long> implements AdminRepository {
    public AdminRepositoryImpl() {
        super(Admin.class);
    }
}
