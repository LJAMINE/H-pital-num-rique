package com.clinique.repository;

import com.clinique.model.Personne;

public interface PersonneRepository {
    Personne findByEmail(String email);

}
