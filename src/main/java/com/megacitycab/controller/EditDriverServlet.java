package com.megacitycab.controller;

import com.megacitycab.dao.DriverDAO;
import com.megacitycab.model.Driver;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editDriver")
public class EditDriverServlet extends HttpServlet {
    private DriverDAO driverDAO;

    @Override
    public void init() {
        driverDAO = new DriverDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("driverId"));
        String name = request.getParameter("name");
        String licenseNumber = request.getParameter("licenseNumber");
        String phoneNumber = request.getParameter("phoneNumber");

        Driver driver = new Driver();
        driver.setDriverId(driverId);
        driver.setName(name);
        driver.setLicenseNumber(licenseNumber);
        driver.setPhoneNumber(phoneNumber);

        boolean result = driverDAO.updateDriver(driver);

        if (result) {
            response.sendRedirect("manageDrivers.jsp"); // Redirect to manage drivers page
        } else {
            request.setAttribute("errorMessage", "Failed to update driver.");
            request.getRequestDispatcher("manageDrivers.jsp").forward(request, response);
        }
    }
}