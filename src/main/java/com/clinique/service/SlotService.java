package com.clinique.service;

import com.clinique.model.Availability;
import com.clinique.model.Consultation;
import com.clinique.model.Slot;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public class SlotService {

    public List<Slot> generateSlotsForAvailability(Availability availability, LocalDate weekStart,LocalDate weekEnd){
        List<Slot>slots =new ArrayList<>();

        for(LocalDate date=weekStart;!date.isAfter(weekEnd);date=date.plusDays(1)){
            if (date.getDayOfWeek()==availability.getDayOfWeek()){
                LocalTime slotStart = availability.getStartTime();
                LocalTime slotEnd = availability.getEndTime();

                LocalDateTime start = date.atTime(slotStart);
                LocalDateTime end = date.atTime(slotEnd);

                LocalDateTime current = start;
                while(current.plusMinutes(30).isBefore(end)|| current.plusMinutes(30).equals(end)){
                    slots.add(new Slot(current, current.plusMinutes(30)));
                    current = current.plusMinutes(30);
                }
            }
        }
        return slots;

    }

    public List<Slot> filterBookedSlots(List<Slot> slots, List<Consultation> consultations) {
        Set<LocalDateTime> bookedTimes = consultations.stream()
                .map(Consultation::getDateTime)
                .collect(Collectors.toSet());

        return slots.stream()
                .filter(slot -> !bookedTimes.contains(slot.getStart()))
                .collect(Collectors.toList());
    }
}
