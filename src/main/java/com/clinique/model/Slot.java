package com.clinique.model;

import java.time.LocalDateTime;

public class Slot {

    private LocalDateTime start;
    private LocalDateTime end;

    public Slot(LocalDateTime start, LocalDateTime end) {
        this.start = start;
        this.end = end;
    }

    public LocalDateTime getStart() {
        return start;
    }

    public LocalDateTime getEnd() {
        return end;
    }

}
