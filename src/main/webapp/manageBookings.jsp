<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.megacitycab.dao.BookingDAO" %>
<%@ page import="com.megacitycab.model.Booking" %>
<%@ page import="java.util.List" %>
<%
    // Check if the user is logged in (for dashboard access)
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if not logged in
        return; // Stop further execution
    }

    // Fetch all bookings
    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> bookings = bookingDAO.getAllBookings();
%>
<html>
<head>
    <title>Manage Bookings - Mega City Cab</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #007bff;
            padding: 10px 20px;
        }

        .navbar-brand {
            color: white !important;
            font-size: 24px;
            font-weight: bold;
        }

        .sidebar {
            height: 100vh;
            width: 250px;
            background-color: #343a40;
            position: fixed;
            top: 0;
            left: 0;
            padding-top: 60px;
        }

        .sidebar a {
            padding: 10px 20px;
            text-decoration: none;
            font-size: 18px;
            color: #d1d1d1;
            display: block;
        }

        .sidebar a:hover {
            background-color: #007bff;
            color: white;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
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
            background-color: #007bff; /* Blue theme color */
            color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            color: white;
        }

        .btn-update {
            background-color: #007bff;
            padding: 5px;/* Blue theme color */
        }

        .btn-delete {
            background-color: #dc3545;
            padding: 5px;/* Red color for delete button */
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
            border-radius: 8px;
            width: 300px;
        }

        .modal-content label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .modal-content input, .modal-content select {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .modal-content button {
            width: 100%;
            padding: 10px;
            background-color: #007bff; /* Blue theme color */
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .modal-content button[type="button"] {
            background-color: #dc3545;
            margin-top: 10px;
        }

        .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 20px;
        }

        .footer p {
            margin: 0;
            font-size: 14px;
        }
        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            text-align: left;
        }

        .logout-btn:hover {
            background-color: #c82333;
        }
    </style>
    <script>
        // Open/Close Update Booking Modal
        function openUpdateBookingModal(bookingId, status) {
            document.getElementById("updateBookingId").value = bookingId;
            document.getElementById("updateStatus").value = status;
            document.getElementById("updateBookingModal").style.display = "flex";
        }
        function closeUpdateBookingModal() {
            document.getElementById("updateBookingModal").style.display = "none";
        }

        // Delete Booking
        function deleteBooking(bookingId) {
            if (confirm("Are you sure you want to delete this booking?")) {
                fetch("deleteBooking?id=" + bookingId, { method: "POST" })
                    .then(response => {
                        if (response.ok) {
                            location.reload(); // Reload the page to reflect changes
                        } else {
                            alert("Failed to delete booking.");
                        }
                    });
            }
        }
    </script>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand ml-auto" href="/MegaCityCab/">
            Mega City Cab
        </a>
    </nav>

    <!-- Sidebar -->
    <div class="sidebar">
        <a href="dashboard.jsp">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <a href="manageBookings.jsp">
            <i class="fas fa-calendar-alt"></i> Manage Bookings
        </a>
        <a href="manageDrivers.jsp">
            <i class="fas fa-users"></i> Manage Drivers
        </a>
        <a href="manageCars.jsp">
            <i class="fas fa-car"></i> Manage Cars
        </a>
        <a href="logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container">
            <h2>Manage Bookings</h2>
            <table>
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Customer Name</th>
                        <th>Phone Number</th>
                        <th>Pickup Location</th>
                        <th>Destination</th>
                        <th>Booking Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Booking booking : bookings) { %>
                    <tr>
                        <td><%= booking.getBookingId() %></td>
                        <td><%= booking.getCustomerName() %></td>
                        <td><%= booking.getPhoneNumber() %></td>
                        <td><%= booking.getPickupLocation() %></td>
                        <td><%= booking.getDestination() %></td>
                        <td><%= booking.getBookingDate() %></td>
                        <td><%= booking.getStatus() %></td>
                        <td>
                            <button class="btn btn-update" onclick="openUpdateBookingModal(<%= booking.getBookingId() %>, '<%= booking.getStatus() %>')">
                                <i class="fas fa-pencil-alt"></i> <!-- Pencil icon -->
                            </button>
                            <button class="btn btn-delete" onclick="deleteBooking(<%= booking.getBookingId() %>)">
                                <i class="fas fa-trash-alt"></i> <!-- Bin icon -->
                            </button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Update Booking Modal -->
    <div id="updateBookingModal" class="modal">
        <div class="modal-content">
            <h3>Update Booking Status</h3>
            <form id="updateBookingForm" action="updateBooking" method="post">
                <input type="hidden" id="updateBookingId" name="bookingId">
                <label for="updateStatus">Status:</label>
                <select id="updateStatus" name="status" required>
                    <option value="Pending">Pending</option>
                    <option value="Confirmed">Confirmed</option>
                    <option value="Completed">Completed</option>
                    <option value="Cancelled">Cancelled</option>
                </select>
                <button type="submit">Update</button>
                <button type="button" onclick="closeUpdateBookingModal()">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 Mega City Cab. All rights reserved.</p>
        <p>Contact: info@megacitycab.com | Follow us: 
            <a href="#" style="color: white;"><i class="fab fa-facebook"></i></a>
            <a href="#" style="color: white;"><i class="fab fa-twitter"></i></a>
            <a href="#" style="color: white;"><i class="fab fa-instagram"></i></a>
        </p>
    </footer>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>