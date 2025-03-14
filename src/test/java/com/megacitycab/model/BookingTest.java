package com.megacitycab.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class BookingTest {
    @Test
    public void testBookingSettersAndGetters() {
        Booking booking = new Booking();
        booking.setBookingId(1);
        booking.setCustomerName("John Doe");
        booking.setCarId(101);
        
        assertEquals(1, booking.getBookingId());
        assertEquals("John Doe", booking.getCustomerName());
        assertEquals(101, booking.getCarId());
    }
}