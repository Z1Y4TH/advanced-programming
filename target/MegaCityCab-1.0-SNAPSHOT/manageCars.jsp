<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.megacitycab.dao.CarDAO" %>
<%@ page import="com.megacitycab.dao.DriverDAO" %>
<%@ page import="com.megacitycab.model.Car" %>
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
    <title>Manage Cars - Mega City Cab</title>
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
        // Open/Close Add Car Modal
        function openAddCarModal() {
            document.getElementById("addCarModal").style.display = "flex";
        }
        function closeAddCarModal() {
            document.getElementById("addCarModal").style.display = "none";
        }

        // Open/Close Edit Car Modal
        function openEditCarModal(carId) {
            fetch("getCar?id=" + carId)
                .then(response => response.json())
                .then(data => {
                    document.getElementById("editCarId").value = data.carId;
                    document.getElementById("editModel").value = data.model;
                    document.getElementById("editRegistrationNumber").value = data.registrationNumber;
                    document.getElementById("editDriverId").value = data.driverId;
                    document.getElementById("editCarModal").style.display = "flex";
                });
        }
        function closeEditCarModal() {
            document.getElementById("editCarModal").style.display = "none";
        }

        // Delete Car
        function deleteCar(carId) {
            if (confirm("Are you sure you want to delete this car?")) {
                fetch("deleteCar?id=" + carId, { method: "POST" })
                    .then(response => {
                        if (response.ok) {
                            location.reload(); // Reload the page to reflect changes
                        } else {
                            alert("Failed to delete car.");
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
            <h2>Manage Cars</h2>
            <button class="btn btn-add" onclick="openAddCarModal()">Add New Car</button>
            <table>
                <thead>
                    <tr>
                        <th>Car ID</th>
                        <th>Model</th>
                        <th>Registration Number</th>
                        <th>Driver Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        CarDAO carDAO = new CarDAO();
                        List<Car> cars = carDAO.getAllCars();
                        for (Car car : cars) {
                    %>
                    <tr>
                        <td><%= car.getCarId() %></td>
                        <td><%= car.getModel() %></td>
                        <td><%= car.getRegistrationNumber() %></td>
                        <td><%= car.getDriverName() != null ? car.getDriverName() : "No Driver" %></td>
                        <td>
                            <button class="btn btn-update" onclick="openEditCarModal(<%= car.getCarId() %>)">
                                <i class="fas fa-pencil-alt"></i> <!-- Pencil icon -->
                            </button>
                            <button class="btn btn-delete" onclick="deleteCar(<%= car.getCarId() %>)">
                                <i class="fas fa-trash-alt"></i> <!-- Bin icon -->
                            </button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Add Car Modal -->
    <div id="addCarModal" class="modal">
        <div class="modal-content">
            <h3>Add New Car</h3>
            <form id="addCarForm" action="addCar" method="post">
                <label for="model">Model:</label>
                <input type="text" id="model" name="model" required><br>

                <label for="registrationNumber">Registration Number:</label>
                <input type="text" id="registrationNumber" name="registrationNumber" required><br>

                <label for="driverId">Driver:</label>
                <select id="driverId" name="driverId" required>
                    <option value="">Select Driver</option>
                    <% for (Driver driver : drivers) { %>
                    <option value="<%= driver.getDriverId() %>"><%= driver.getName() %></option>
                    <% } %>
                </select><br>

                <button type="submit">Add Car</button>
                <button type="button" onclick="closeAddCarModal()">Cancel</button>
            </form>
        </div>
    </div>

    <!-- Edit Car Modal -->
    <div id="editCarModal" class="modal">
        <div class="modal-content">
            <h3>Edit Car</h3>
            <form id="editCarForm" action="editCar" method="post">
                <input type="hidden" id="editCarId" name="carId">
                <label for="editModel">Model:</label>
                <input type="text" id="editModel" name="model" required><br>

                <label for="editRegistrationNumber">Registration Number:</label>
                <input type="text" id="editRegistrationNumber" name="registrationNumber" required><br>

                <label for="editDriverId">Driver:</label>
                <select id="editDriverId" name="driverId" required>
                    <option value="">Select Driver</option>
                    <% for (Driver driver : drivers) { %>
                    <option value="<%= driver.getDriverId() %>"><%= driver.getName() %></option>
                    <% } %>
                </select><br>

                <button type="submit">Save Changes</button>
                <button type="button" onclick="closeEditCarModal()">Cancel</button>
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