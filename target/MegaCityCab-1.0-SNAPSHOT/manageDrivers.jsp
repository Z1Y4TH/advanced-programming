<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.megacitycab.dao.DriverDAO" %>
<%@ page import="com.megacitycab.model.Driver" %>
<%@ page import="java.util.List" %>

<%
    // Check if the user is logged in
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp"); // Redirect to login page if not logged in
        return; // Stop further execution
    }

    // Declare DriverDAO and drivers once at the top
    DriverDAO driverDAO = new DriverDAO();
    List<Driver> drivers = driverDAO.getAllDrivers();
%>
<html>
<head>
    <title>Manage Drivers - Mega City Cab</title>
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
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensure the body takes up at least the full viewport height */
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
            flex: 1; /* Allow the main content to grow and take up remaining space */
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
            background-color: #007bff; /* Blue theme color */
            padding: 5px;
        }

        .btn-delete {
            background-color: #dc3545; /* Red color for delete button */
            padding: 5px;
        }

        .btn-add {
            background-color: #28a745; /* Green color for add button */
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            color: white;
            cursor: pointer;
            margin-bottom: 20px;
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
            margin-top: auto; /* Push the footer to the bottom */
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
        // Open/Close Add Driver Modal
        function openAddDriverModal() {
            document.getElementById("addDriverModal").style.display = "flex";
        }
        function closeAddDriverModal() {
            document.getElementById("addDriverModal").style.display = "none";
        }

        // Open/Close Edit Driver Modal
        function openEditDriverModal(driverId) {
            fetch("getDriver?id=" + driverId)
                .then(response => response.json())
                .then(data => {
                    document.getElementById("editDriverId").value = data.driverId;
                    document.getElementById("editName").value = data.name;
                    document.getElementById("editLicenseNumber").value = data.licenseNumber;
                    document.getElementById("editPhoneNumber").value = data.phoneNumber;
                    document.getElementById("editDriverModal").style.display = "flex";
                });
        }
        function closeEditDriverModal() {
            document.getElementById("editDriverModal").style.display = "none";
        }

        // Delete Driver
        function deleteDriver(driverId) {
            if (confirm("Are you sure you want to delete this driver?")) {
                fetch("deleteDriver?id=" + driverId, { method: "POST" })
                    .then(response => {
                        if (response.ok) {
                            location.reload(); // Reload the page to reflect changes
                        } else {
                            alert("Failed to delete driver.");
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
            <h2>Manage Drivers</h2>
            <button class="btn btn-add" onclick="openAddDriverModal()">Add New Driver</button>
            <table>
                <thead>
                    <tr>
                        <th>Driver ID</th>
                        <th>Name</th>
                        <th>License Number</th>
                        <th>Phone Number</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Driver driver : drivers) { %>
                    <tr>
                        <td><%= driver.getDriverId() %></td>
                        <td><%= driver.getName() %></td>
                        <td><%= driver.getLicenseNumber() %></td>
                        <td><%= driver.getPhoneNumber() %></td>
                        <td>
                            <button class="btn btn-update" onclick="openEditDriverModal(<%= driver.getDriverId() %>)">
                                <i class="fas fa-pencil-alt"></i> <!-- Pencil icon -->
                            </button>
                            <button class="btn btn-delete" onclick="deleteDriver(<%= driver.getDriverId() %>)">
                                <i class="fas fa-trash-alt"></i> <!-- Bin icon -->
                            </button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Add Driver Modal -->
    <div id="addDriverModal" class="modal">
        <div class="modal-content">
            <h3>Add New Driver</h3>
            <form id="addDriverForm" action="addDriver" method="post">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required><br>

                <label for="licenseNumber">License Number:</label>
                <input type="text" id="licenseNumber" name="licenseNumber" required><br>

                <label for="phoneNumber">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phoneNumber" required><br>

                <button type="submit">Add Driver</button>
                <button type="button" onclick="closeAddDriverModal()">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Edit Driver Modal -->
    <div id="editDriverModal" class="modal">
        <div class="modal-content">
            <h3>Edit Driver</h3>
            <form id="editDriverForm" action="editDriver" method="post">
                <input type="hidden" id="editDriverId" name="driverId">
                <label for="editName">Name:</label>
                <input type="text" id="editName" name="name" required><br>

                <label for="editLicenseNumber">License Number:</label>
                <input type="text" id="editLicenseNumber" name="licenseNumber" required><br>

                <label for="editPhoneNumber">Phone Number:</label>
                <input type="text" id="editPhoneNumber" name="phoneNumber" required><br>

                <button type="submit">Save Changes</button>
                <button type="button" onclick="closeEditDriverModal()">Cancel</button>
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