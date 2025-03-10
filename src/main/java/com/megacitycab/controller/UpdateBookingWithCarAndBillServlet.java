package com.megacitycab.controller;

import com.megacitycab.dao.BillDAO;
import com.megacitycab.dao.BookingDAO;
import com.megacitycab.model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateBookingWithBill")
public class UpdateBookingWithCarAndBillServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int carId = Integer.parseInt(request.getParameter("carId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        double tax = Double.parseDouble(request.getParameter("tax"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        double finalAmount = Double.parseDouble(request.getParameter("finalAmount"));

        BookingDAO bookingDAO = new BookingDAO();
        BillDAO billDAO = new BillDAO();

        // Assign car to booking
        boolean carAssigned = bookingDAO.updateBookingWithCarAndBill(bookingId, carId);

        // Update or insert bill
        Bill bill = new Bill();
        bill.setBookingId(bookingId);
        bill.setTotalAmount(totalAmount);
        bill.setTax(tax);
        bill.setDiscount(discount);
        bill.setFinalAmount(finalAmount);
        boolean billUpdated = billDAO.updateBill(bill);

        if (carAssigned && billUpdated) {
            response.sendRedirect("manageBookings.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to update booking or bill.");
            request.getRequestDispatcher("manageBookings.jsp").forward(request, response);
        }
    }
}