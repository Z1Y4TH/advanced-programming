package com.megacitycab.controller;

import com.megacitycab.dao.DriverDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteDriver")
public class DeleteDriverServlet extends HttpServlet {
    private DriverDAO driverDAO;

    @Override
    public void init() {
        driverDAO = new DriverDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("id"));

        boolean result = driverDAO.deleteDriver(driverId);

        if (result) {
            response.sendRedirect("manageDrivers.jsp"); // Redirect to manage drivers page
        } else {
            request.setAttribute("errorMessage", "Failed to delete driver.");
            request.getRequestDispatcher("manageDrivers.jsp").forward(request, response);
        }
    }
}