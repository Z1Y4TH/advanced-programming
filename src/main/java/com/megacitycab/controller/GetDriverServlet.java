package com.megacitycab.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.megacitycab.dao.DriverDAO;
import com.megacitycab.model.Driver;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/getDriver")
public class GetDriverServlet extends HttpServlet {
    private DriverDAO driverDAO;

    @Override
    public void init() {
        driverDAO = new DriverDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int driverId = Integer.parseInt(request.getParameter("id"));

        Driver driver = driverDAO.getDriverById(driverId);

        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(driver);

        response.setContentType("application/json");
        response.getWriter().write(json);
    }
}