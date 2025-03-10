package com.megacitycab.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.megacitycab.dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/validateCustomer")
public class ValidateCustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String phoneNumber = request.getParameter("phoneNumber");
    String nic = request.getParameter("nic");

    boolean valid = customerDAO.validateCustomer(phoneNumber, nic);

    Map<String, Object> result = new HashMap<>();
    result.put("valid", valid);

    if (valid) {
        // Save customer ID in session and return it in the response
        int customerId = customerDAO.getCustomerIdByPhone(phoneNumber);
        HttpSession session = request.getSession();
        session.setAttribute("customerId", String.valueOf(customerId));

        result.put("customerId", customerId); // Add customerId to the response
    }

    ObjectMapper mapper = new ObjectMapper();
    String json = mapper.writeValueAsString(result);

    response.setContentType("application/json");
    response.getWriter().write(json);
}
}