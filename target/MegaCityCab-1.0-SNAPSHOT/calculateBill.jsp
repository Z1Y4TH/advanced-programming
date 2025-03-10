<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.megacitycab.dao.BillDAO" %>
<%@ page import="com.megacitycab.model.Bill" %>
<html>
<head>
    <title>Calculate Bill - Mega City Cab</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .bill-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 0 auto;
        }
        .bill-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .bill-details {
            margin-top: 20px;
        }
        .bill-details table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .bill-details table, .bill-details th, .bill-details td {
            border: 1px solid #ccc;
        }
        .bill-details th, .bill-details td {
            padding: 10px;
            text-align: left;
        }
        .bill-details th {
            background-color: #28a745;
            color: #fff;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="bill-container">
        <h2>Bill Details</h2>

        <!-- Error Message -->
        <div class="error-message">
            ${errorMessage}
        </div>

        <!-- Bill Details -->
        <div class="bill-details">
            <%
                Bill bill = (Bill) request.getAttribute("bill");
                if (bill != null) {
            %>
            <table>
                <thead>
                    <tr>
                        <th>Field</th>
                        <th>Value</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Booking ID</td>
                        <td><%= bill.getBookingId()%></td>
                    </tr>
                    <tr>
                        <td>Total Amount</td>
                        <td><%= bill.getTotalAmount()%></td>
                    </tr>
                    <tr>
                        <td>Tax</td>
                        <td><%= bill.getTax()%></td>
                    </tr>
                    <tr>
                        <td>Discount</td>
                        <td><%= bill.getDiscount()%></td>
                    </tr>
                    <tr>
                        <td>Final Amount</td>
                        <td><%= bill.getFinalAmount()%></td>
                    </tr>
                </tbody>
            </table>
            <button onclick="window.print()">Print Bill</button>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>