package com.megacitycab.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.megacitycab.dao.CarDAO;
import com.megacitycab.model.Car;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/getCar")
public class GetCarServlet extends HttpServlet {
    private CarDAO carDAO;

    @Override
    public void init() {
        carDAO = new CarDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));

        Car car = carDAO.getCarById(carId);

        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(car);

        response.setContentType("application/json");
        response.getWriter().write(json);
    }
}