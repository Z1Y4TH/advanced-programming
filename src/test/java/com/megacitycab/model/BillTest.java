package com.megacitycab.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class BillTest {
    @Test
    public void testBillCalculation() {
        Bill bill = new Bill();
        bill.setTotalAmount(200.0);
        bill.setTax(10.0); // 10% tax
        bill.setDiscount(5.0); // 5% discount
        
        double expected = 200 + (200 * 0.10) - (200 * 0.05); // 210.0
        assertEquals(expected, bill.getFinalAmount(), 0.001);
    }
}