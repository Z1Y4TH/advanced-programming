package com.megacitycab.controller;

import com.megacitycab.dao.BookingDAO;
import com.megacitycab.dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/addBooking")
public class AddBookingServlet extends HttpServlet {
    private BookingDAO bookingDAO;
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        bookingDAO = new BookingDAO();
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pickupLocation = request.getParameter("pickupLocation");
        String destination = request.getParameter("destination");
        String customerIdStr = request.getParameter("customerId");

        if (customerIdStr == null || customerIdStr.isEmpty()) {
            request.setAttribute("errorMessage", "Customer ID is missing.");
            request.getRequestDispatcher("addBooking.jsp").forward(request, response);
            return;
        }

        int customerId = Integer.parseInt(customerIdStr);

        // Add the booking
        boolean result = bookingDAO.addBooking(customerId, pickupLocation, destination);

        if (result) {
            // Add customer ID to the session
            HttpSession session = request.getSession();
            session.setAttribute("customerId", String.valueOf(customerId));

            // Redirect to bookings.jsp
            response.sendRedirect("bookings.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to add booking");
            request.getRequestDispatcher("addBooking.jsp").forward(request, response);
        }
    }
}