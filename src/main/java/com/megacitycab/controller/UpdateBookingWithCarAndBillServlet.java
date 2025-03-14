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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/updateBookingWithBill")
public class UpdateBookingWithCarAndBillServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UpdateBookingWithCarAndBillServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int carId = Integer.parseInt(request.getParameter("carId"));
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            double tax = Double.parseDouble(request.getParameter("tax"));
            double discount = Double.parseDouble(request.getParameter("discount"));

            // Validation
            if (bookingId <= 0 || carId <= 0 || totalAmount < 0 || tax < 0 || discount < 0) {
                throw new IllegalArgumentException("Invalid input parameters.");
            }

            BookingDAO bookingDAO = new BookingDAO();
            BillDAO billDAO = new BillDAO();

            // Assign car to booking
            boolean carAssigned = bookingDAO.updateBookingWithCarAndBill(bookingId, carId);

            // Update or insert bill
            Bill bill = new Bill();
            bill.setBookingId(bookingId);
            bill.setTotalAmount(totalAmount);
            bill.setTax(tax);
            bill.setDiscount(discount); // finalAmount is calculated in Bill class
            boolean billUpdated = billDAO.updateBill(bill);

            if (carAssigned && billUpdated) {
                response.sendRedirect("manageBookings.jsp?success=true"); // Redirect with success message
            } else {
                request.setAttribute("errorMessage", "Failed to update booking or bill.");
                request.getRequestDispatcher("manageBookings.jsp").forward(request, response);
            }

        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.SEVERE, "Invalid request parameters", e);
            request.setAttribute("errorMessage", "Invalid input parameters.");
            request.getRequestDispatcher("manageBookings.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating booking or bill", e);
            request.setAttribute("errorMessage", "An error occurred while updating booking or bill.");
            request.getRequestDispatcher("manageBookings.jsp").forward(request, response);
        }
    }
}