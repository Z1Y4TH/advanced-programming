package com.megacitycab.dao;

import com.megacitycab.model.Bill;
import com.megacitycab.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BillDAO {
    private static final String SELECT_BILL_BY_BOOKING_ID = "SELECT * FROM bills WHERE booking_id = ?";
    private static final String UPDATE_BILL = "UPDATE bills SET total_amount = ?, tax = ?, discount = ?, final_amount = ? WHERE booking_id = ?";
    private static final String INSERT_BILL = "INSERT INTO bills (booking_id, total_amount, tax, discount, final_amount) VALUES (?, ?, ?, ?, ?)";

    public boolean updateBill(Bill bill) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_BILL)) {
            stmt.setDouble(1, bill.getTotalAmount());
            stmt.setDouble(2, bill.getTax());
            stmt.setDouble(3, bill.getDiscount());
            stmt.setDouble(4, bill.getFinalAmount());
            stmt.setInt(5, bill.getBookingId());
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated == 0) {
                // If no rows were updated, insert a new bill
                try (PreparedStatement insertStmt = conn.prepareStatement(INSERT_BILL)) {
                    insertStmt.setInt(1, bill.getBookingId());
                    insertStmt.setDouble(2, bill.getTotalAmount());
                    insertStmt.setDouble(3, bill.getTax());
                    insertStmt.setDouble(4, bill.getDiscount());
                    insertStmt.setDouble(5, bill.getFinalAmount());
                    insertStmt.executeUpdate();
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Bill getBillByBookingId(int bookingId) {
        Bill bill = null;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_BILL_BY_BOOKING_ID)) {
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                bill = new Bill();
                bill.setBookingId(rs.getInt("booking_id"));
                bill.setTotalAmount(rs.getDouble("total_amount"));
                bill.setTax(rs.getDouble("tax"));
                bill.setDiscount(rs.getDouble("discount"));
                bill.setFinalAmount(rs.getDouble("final_amount"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bill;
    }
}