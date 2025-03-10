<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.megacitycab.dao.BookingDAO" %>
<%@ page import="com.megacitycab.model.Booking" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<html>
<head>
    <title>Bookings - Mega City Cab</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
       body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure the body takes up at least the full viewport height */
        }

        .navbar {
            background-color: #007bff;
        }

        .navbar-brand, .navbar-nav .nav-link {
            color: white !important;
        }

        .bookings-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%; /* Make the container responsive */
            margin: 20px auto; /* Center the container */
            flex: 1; /* Allow the container to grow and take up remaining space */
        }

        .bookings-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #0056b3;
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            width: 300px;
        }

        .modal-content label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .modal-content input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .modal-content button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            margin-bottom: 5px;
        }

        .modal-content button:hover {
            background-color: #0056b3;
        }

        .footer {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: auto; /* Push the footer to the bottom */
        }

        .footer p {
            margin: 0;
            font-size: 14px;
        }


        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            th {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }

            tr {
                border: 1px solid #ccc;
                margin-bottom: 10px;
            }

            td {
                border: none;
                border-bottom: 1px solid #eee;
                position: relative;
                padding-left: 50%;
            }

            td:before {
                position: absolute;
                top: 6px;
                left: 6px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                content: attr(data-label);
                font-weight: bold;
            }
        }
    </style>
    <script>
        function showCustomerForm() {
            document.getElementById("customerModal").style.display = "flex";
        }

        function hideCustomerForm() {
            document.getElementById("customerModal").style.display = "none";
        }

        function validateCustomer() {
            const phoneNumber = document.getElementById("phoneNumber").value;
            const nic = document.getElementById("nic").value;

            // Construct the URL and data for the POST request
            const url = "validateCustomer";
            const data = new URLSearchParams();
            data.append("phoneNumber", phoneNumber);
            data.append("nic", nic);

            // Clear any previous error message
            document.getElementById("modalErrorMessage").innerText = "";

            // Send a POST request to validate the customer
            fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: data,
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then(data => {
                if (data.valid) {
                    // If customer is valid, reload the page to display bookings
                    window.location.reload();
                } else {
                    // If customer is not valid, show error message inside the modal
                    document.getElementById("modalErrorMessage").innerText = "Invalid phone number or NIC.";
                }
            })
            .catch(error => {
                console.error("Error validating customer:", error);
                alert("An error occurred while validating customer details. Please try again.");
            });
        }
    </script>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <a class="navbar-brand" href="/MegaCityCab">Mega City Cab</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto"> <!-- Use ml-auto to push items to the right -->
                <li class="nav-item">
                    <a class="nav-link" href="/MegaCityCab/login.jsp">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                             class="bi bi-person-circle" viewBox="0 0 16 16">
                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                            <path fill-rule="evenodd"
                                  d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                        </svg>
                        Login
                    </a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Bookings Container -->
    <div class="bookings-container">
        <h2>Bookings</h2>

        <!-- Bookings Table -->
        <table>
            <thead>
                <tr>
                    <th>Booking ID</th>
                    <th>Pickup Location</th>
                    <th>Destination</th>
                    <th>Booking Date</th>
                    <th>Status</th>
                    <th>Bill</th> <!-- New column -->
                </tr>
            </thead>
            <tbody>
                <%
                    BookingDAO bookingDAO = new BookingDAO();
                    String customerId = (String) session.getAttribute("customerId");

                    if (customerId != null) {
                        // Get bookings for the logged-in customer
                        List<Booking> bookings = bookingDAO.getBookingsByCustomerId(Integer.parseInt(customerId));
                        for (Booking booking : bookings) {
                %>
                <%
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String formattedDate = dateFormat.format(booking.getBookingDate());
                %>
                
                <tr>
                    <td data-label="Booking ID"><%= booking.getBookingId()%></td>
                    <td data-label="Pickup Location"><%= booking.getPickupLocation()%></td>
                    <td data-label="Destination"><%= booking.getDestination()%></td>
                    <td data-label="Date"><%= formattedDate%></td>
                    <td data-label="Status"><%= booking.getStatus()%></td>
                    <td data-label="Bill">
                        <a href="calculateBill?bookingId=<%=booking.getBookingId()%>">View</a> <!-- View Bill link -->
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

        <!-- Error Message -->
        <div id="errorMessage" class="error-message">
            ${errorMessage}
        </div>
    </div>

    <!-- Customer Details Modal -->
    <div id="customerModal" class="modal">
        <div class="modal-content">
                <h3>Verification Details</h3>
            <form id="customerForm" onsubmit="event.preventDefault(); validateCustomer();">
                <label for="phoneNumber">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phoneNumber" required>

                <label for="nic">NIC:</label>
                <input type="text" id="nic" name="nic" required>

                <!-- Error message inside the modal -->
                <div id="modalErrorMessage" class="error-message"></div>

                <button type="submit" class="btn btn-primary">Submit</button>
                <button type="button" class="btn btn-secondary" onclick="hideCustomerForm()">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>All rights reserved &copy; 2025 Mega City Cab</p>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        // Show the customer details modal when the page loads
        window.onload = function() {
            const customerId = "<%= session.getAttribute("customerId") %>";
            if (customerId === 'null') {
                showCustomerForm();
            }
        };
    </script>
</body>
</html>