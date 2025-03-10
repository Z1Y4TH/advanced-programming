package com.megacitycab.dao;

import com.megacitycab.model.Booking;
import com.megacitycab.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.sql.ResultSet;

public class BookingDAO {

    private static final String SELECT_ALL_BOOKINGS = "SELECT b.booking_id, c.name AS customer_name, c.phone_number, b.pickup_location, b.destination, b.booking_date, b.status " +
            "FROM bookings b " +
            "JOIN customers c ON b.customer_id = c.customer_id";

    private static final String SELECT_BOOKINGS_BY_PHONE = "SELECT b.booking_id, c.name AS customer_name, c.phone_number, b.pickup_location, b.destination, b.booking_date, b.status " +
            "FROM bookings b " +
            "JOIN customers c ON b.customer_id = c.customer_id " +
            "WHERE c.phone_number = ?";

    private static final String INSERT_BOOKING = "INSERT INTO bookings (customer_id, pickup_location, destination) VALUES (?, ?, ?)";

    private static final String UPDATE_BOOKING_STATUS = "UPDATE bookings SET status = ? WHERE booking_id = ?";

    private static final String DELETE_BOOKING = "DELETE FROM bookings WHERE booking_id = ?";

    private static final String SELECT_BOOKINGS_BY_CUSTOMER = "SELECT b.booking_id, c.name AS customer_name, c.phone_number, b.pickup_location, b.destination, b.booking_date, b.status " +
            "FROM bookings b " +
            "JOIN customers c ON b.customer_id = c.customer_id " +
            "WHERE b.customer_id = ?";

    private static final String SELECT_BOOKING_BY_CUSTOMER = "SELECT * FROM bookings WHERE booking_id = ? AND customer_id = ?";

    // Add a new booking
    public boolean addBooking(int customerId, String pickupLocation, String destination) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_BOOKING)) {
            stmt.setInt(1, customerId);
            stmt.setString(2, pickupLocation);
            stmt.setString(3, destination);
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_BOOKINGS)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setPhoneNumber(rs.getString("phone_number"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get bookings by phone number
    public List<Booking> getBookingsByPhoneNumber(String phoneNumber) {
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(SELECT_BOOKINGS_BY_PHONE)) {
            stmt.setString(1, phoneNumber);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setPhoneNumber(rs.getString("phone_number"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Get bookings by customer ID
    public List<Booking> getBookingsByCustomerId(int customerId) {
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(SELECT_BOOKINGS_BY_CUSTOMER)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setCustomerName(rs.getString("customer_name"));
                booking.setPhoneNumber(rs.getString("phone_number"));
                booking.setPickupLocation(rs.getString("pickup_location"));
                booking.setDestination(rs.getString("destination"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setStatus(rs.getString("status"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    // Check if a booking belongs to a specific customer
    public boolean isBookingValidForCustomer(int bookingId, int customerId) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BOOKING_BY_CUSTOMER)) {
            stmt.setInt(1, bookingId);
            stmt.setInt(2, customerId);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Returns true if the booking belongs to the customer
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update booking status
    public boolean updateBookingStatus(int bookingId, String status) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_BOOKING_STATUS)) {
            stmt.setString(1, status);
            stmt.setInt(2, bookingId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a booking
    public boolean deleteBooking(int bookingId) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_BOOKING)) {
            stmt.setInt(1, bookingId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}