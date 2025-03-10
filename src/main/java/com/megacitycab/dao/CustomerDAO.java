package com.megacitycab.dao;

import com.megacitycab.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.postgresql.util.PSQLException;

public class CustomerDAO {
    private static final String SELECT_CUSTOMER_BY_PHONE = "SELECT * FROM customers WHERE phone_number = ?";

    public boolean checkCustomerExists(String phoneNumber) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMER_BY_PHONE)) {
            stmt.setString(1, phoneNumber);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int addCustomer(String name, String address, String nic, String phoneNumber) {
        String INSERT_CUSTOMER = "INSERT INTO customers (name, address, nic, phone_number) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(INSERT_CUSTOMER, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, name);
            stmt.setString(2, address);
            stmt.setString(3, nic);
            stmt.setString(4, phoneNumber);
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Return the generated customer ID
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if the customer could not be added
    }
    
    public boolean validateCustomer(String phoneNumber, String nic) {
        String SELECT_CUSTOMER = "SELECT * FROM customers WHERE phone_number = ? AND nic = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMER)) {
            stmt.setString(1, phoneNumber);
            stmt.setString(2, nic);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Returns true if the customer exists
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getCustomerIdByPhone(String phoneNumber) {
        String SELECT_CUSTOMER_ID = "SELECT customer_id FROM customers WHERE phone_number = ?";
        try (Connection conn = DBUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMER_ID)) {
            stmt.setString(1, phoneNumber);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("customer_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if the customer is not found
    }
    
    
}