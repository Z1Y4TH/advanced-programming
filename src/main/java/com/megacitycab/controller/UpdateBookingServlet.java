package com.megacitycab.controller;

import com.megacitycab.dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateBooking")
public class UpdateBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        String status = request.getParameter("status");

        BookingDAO bookingDAO = new BookingDAO();
        boolean success = bookingDAO.updateBookingStatus(bookingId, status);

        if (success) {
            response.sendRedirect("manageBookings.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to update booking status.");
            request.getRequestDispatcher("manageBookings.jsp").forward(request, response);
        }
    }
}