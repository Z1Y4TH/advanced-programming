package com.megacitycab.controller;

import com.megacitycab.dao.CarDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteCar")
public class DeleteCarServlet extends HttpServlet {
    private CarDAO carDAO;

    @Override
    public void init() {
        carDAO = new CarDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int carId = Integer.parseInt(request.getParameter("id"));

        boolean result = carDAO.deleteCar(carId);

        if (result) {
            response.sendRedirect("manageCars.jsp"); // Redirect to manage cars page
        } else {
            request.setAttribute("errorMessage", "Failed to delete car.");
            request.getRequestDispatcher("manageCars.jsp").forward(request, response);
        }
    }
}