package com.clinique.repository;

import com.clinique.model.Availability;
import java.util.List;

public interface AvailabilityRepository extends GenericRepository<Availability, Long> {
    List<Availability> findByDoctorId(Long doctorId);
}