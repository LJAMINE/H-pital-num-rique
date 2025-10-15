package com.clinique.repository;

import com.clinique.model.Availability;
import com.clinique.model.Departement;

import java.util.List;

public interface AvailabilityRepository  extends GenericRepository<Availability, Long>  {
    List<Availability> findByDoctorId(Long doctorId);

}
