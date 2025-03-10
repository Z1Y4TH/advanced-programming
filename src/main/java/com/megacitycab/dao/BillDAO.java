package com.megacitycab.dao;

import com.megacitycab.model.Bill;
import com.megacitycab.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BillDAO {
    private static final String SELECT_BILL_BY_BOOKING_ID = "SELECT * FROM bills WHERE booking_id = ?";

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