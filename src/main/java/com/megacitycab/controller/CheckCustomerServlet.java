package com.megacitycab.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.megacitycab.dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/checkCustomer")
public class CheckCustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String phoneNumber = request.getParameter("phoneNumber");
        boolean exists = customerDAO.checkCustomerExists(phoneNumber);

        Map<String, Boolean> result = new HashMap<>();
        result.put("exists", exists);

        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(result);

        response.setContentType("application/json");
        response.getWriter().write(json);
    }
}