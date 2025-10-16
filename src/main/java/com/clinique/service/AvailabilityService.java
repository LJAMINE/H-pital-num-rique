package com.clinique.service;

import com.clinique.exception.AvailabilityNotFoundException;
import com.clinique.exception.DoctorNotFoundException;
import com.clinique.model.Availability;
import com.clinique.model.Doctor;
import com.clinique.repository.AvailabilityRepository;
import com.clinique.repository.DoctorRepository;
import jakarta.enterprise.context.Dependent;
import jakarta.inject.Inject;
import jakarta.inject.Named;

import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.List;

@Dependent
@Named
public class AvailabilityService {

    @Inject
    private AvailabilityRepository availabilityRepository;

    @Inject
    private DoctorRepository doctorRepository;

    public List<Availability> getAllAvailabiliytyForDoctor(Long doctorId) {
        return availabilityRepository.findByDoctorId(doctorId);
    }

    public Availability getAvailability(Long id) {
        Availability availability = availabilityRepository.findById(id);
        if (availability == null) {
            throw new AvailabilityNotFoundException("Availability not found.");
        }
        return availability;
    }

    public Availability addAvailabity(Long doctorId, DayOfWeek dayOfWeek, LocalTime startTime, LocalTime endTime) {
        Doctor doctor = doctorRepository.findById(doctorId);
        if (doctor == null) {
            throw new DoctorNotFoundException("doctor not found.");
        }
        Availability availability = new Availability();
        availability.setDoctor(doctor);
        availability.setDayOfWeek(dayOfWeek);
        availability.setStartTime(startTime);
        availability.setEndTime(endTime);
        availabilityRepository.save(availability);
        return availability;
    }

    public Availability updateAvailabity(Long availabilityId, DayOfWeek dayOfWeek, LocalTime startTime, LocalTime endTime) {
        Availability existingAvailability = availabilityRepository.findById(availabilityId);
        if (existingAvailability == null) {
            throw new AvailabilityNotFoundException("Availability not found.");
        }
        existingAvailability.setDayOfWeek(dayOfWeek);
        existingAvailability.setStartTime(startTime);
        existingAvailability.setEndTime(endTime);
        return availabilityRepository.update(existingAvailability);
    }

    public void deleteAvailability(Long id) {
        Availability existing = availabilityRepository.findById(id);
        if (existing == null) {
            throw new AvailabilityNotFoundException("Availability not found to delete.");
        }
        availabilityRepository.delete(id);
    }
}