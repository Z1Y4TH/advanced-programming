package com.megacitycab.controller;

import com.megacitycab.dao.BillDAO;
import com.megacitycab.dao.BookingDAO;
import com.megacitycab.model.Bill;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/calculateBill")
public class CalculateBillServlet extends HttpServlet {
    private BillDAO billDAO;
    private BookingDAO bookingDAO;

    @Override
    public void init() {
        billDAO = new BillDAO();
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String customerId = (String) session.getAttribute("customerId");

        if (customerId == null) {
            // Redirect to login if the user is not logged in
            response.sendRedirect("login.jsp");
            return;
        }

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        // Check if the booking belongs to the logged-in user
        boolean isBookingValid = bookingDAO.isBookingValidForCustomer(bookingId, Integer.parseInt(customerId));

        if (!isBookingValid) {
            request.setAttribute("errorMessage", "You do not have permission to view this bill.");
            request.getRequestDispatcher("calculateBill.jsp").forward(request, response);
            return;
        }

        // Fetch the bill details
        Bill bill = billDAO.getBillByBookingId(bookingId);

        if (bill != null) {
            request.setAttribute("bill", bill);
        } else {
            request.setAttribute("errorMessage", "No bill found for the given booking ID.");
        }

        request.getRequestDispatcher("calculateBill.jsp").forward(request, response);
    }
}