package com.megacitycab.dao;

import com.megacitycab.model.Booking;
import com.megacitycab.util.DBUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.*;

public class BookingDAOTest {
    private BookingDAO bookingDAO;
    private Connection testConnection;

    @BeforeEach
    public void setUp() throws Exception {
        // Initialize test database (e.g., H2 in-memory DB)
        testConnection = DriverManager.getConnection("jdbc:h2:mem:test;DB_CLOSE_DELAY=-1");
        DBUtil.setTestConnection(testConnection); // Override production DB
        bookingDAO = new BookingDAO();
        
        // Drop the table if it exists, then create it
        try (Statement stmt = testConnection.createStatement()) {
            stmt.execute("DROP TABLE IF EXISTS bookings"); // Drop table if it exists
            stmt.execute("CREATE TABLE bookings (booking_id INT PRIMARY KEY, car_id INT)");
            stmt.execute("INSERT INTO bookings (booking_id, car_id) VALUES (1, 101)");
        }
    }

    @Test
    public void testAssignCarToBooking() {
        boolean success = bookingDAO.updateBookingWithCarAndBill(1, 102);
        assertTrue(success);
    }

    @Test
    public void testDeleteBooking() {
        boolean success = bookingDAO.deleteBooking(1);
        assertTrue(success);
    }
}