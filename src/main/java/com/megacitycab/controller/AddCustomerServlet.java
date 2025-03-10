package com.megacitycab.controller;

import com.megacitycab.dao.CustomerDAO;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/addCustomer")
public class AddCustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String nic = request.getParameter("nic");
        String phoneNumber = request.getParameter("phoneNumber");

        int customerId = customerDAO.addCustomer(name, address, nic, phoneNumber);

        Map<String, Integer> result = new HashMap<>();
        result.put("customerId", customerId);

        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(result);

        response.setContentType("application/json");
        response.getWriter().write(json);
    }
}