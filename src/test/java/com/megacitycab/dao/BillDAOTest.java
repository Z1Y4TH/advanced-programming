package com.megacitycab.dao;

import com.megacitycab.model.Bill;
import com.megacitycab.util.DBUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.*;

public class BillDAOTest {
    private BillDAO billDAO;
    private Connection testConnection;

    @BeforeEach
    public void setUp() throws Exception {
        testConnection = DriverManager.getConnection("jdbc:h2:mem:test;DB_CLOSE_DELAY=-1");
        DBUtil.setTestConnection(testConnection);
        billDAO = new BillDAO();

        try (Statement stmt = testConnection.createStatement()) {
            stmt.execute("CREATE TABLE bills (booking_id INT PRIMARY KEY, total_amount DECIMAL, tax DECIMAL, discount DECIMAL, final_amount DECIMAL)");
        }
    }

    @Test
    public void testUpdateBill() {
        Bill bill = new Bill();
        bill.setBookingId(1);
        bill.setTotalAmount(150.0);
        bill.setTax(18.0);
        bill.setDiscount(5.0);
        boolean success = billDAO.updateBill(bill);
        assertTrue(success);
    }
}