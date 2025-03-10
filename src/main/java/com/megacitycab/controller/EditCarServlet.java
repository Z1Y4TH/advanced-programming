package com.megacitycab.controller;

import com.megacitycab.dao.CarDAO;
import com.megacitycab.model.Car;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editCar")
public class EditCarServlet extends HttpServlet {
    private CarDAO carDAO;

    @Override
    public void init() {
        carDAO = new CarDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("carId"));
        String model = request.getParameter("model");
        String registrationNumber = request.getParameter("registrationNumber");
        int driverId = Integer.parseInt(request.getParameter("driverId"));

        Car car = new Car();
        car.setCarId(carId);
        car.setModel(model);
        car.setRegistrationNumber(registrationNumber);
        car.setDriverId(driverId);

        boolean result = carDAO.updateCar(car);

        if (result) {
            response.sendRedirect("manageCars.jsp"); // Redirect to manage cars page
        } else {
            request.setAttribute("errorMessage", "Failed to update car.");
            request.getRequestDispatcher("manageCars.jsp").forward(request, response);
        }
    }
}