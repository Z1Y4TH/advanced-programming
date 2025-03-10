<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.megacitycab.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Dashboard - Mega City Cab</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <!-- Chart.js for Charts -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

        .welcome-message {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .welcome-message h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        .welcome-message p {
            font-size: 18px;
            color: #666;
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

        .card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .card h3 {
            font-size: 22px;
            margin-bottom: 15px;
        }

        .card p {
            font-size: 16px;
            color: #666;
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
    </style>
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
        <!-- Welcome Message -->
        <div class="welcome-message">
            <h1>Welcome, <%= user.getUsername() %>!</h1>
            <p>Your role is: <strong><%= user.getRole() %></strong></p>
        </div>

        <!-- Quick Stats Cards -->
        <div class="row">
            <div class="col-md-3">
                <div class="card">
                    <h3>Total Bookings</h3>
                    <p>1,234</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <h3>Active Drivers</h3>
                    <p>56</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <h3>Available Cars</h3>
                    <p>24</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <h3>Revenue</h3>
                    <p>$12,345</p>
                </div>
            </div>
        </div>

        <!-- Recent Activities -->
        <div class="card">
            <h3>Recent Activities</h3>
            <ul>
                <li>Booking #1234 created by John Doe</li>
                <li>Driver #56 assigned to Booking #1234</li>
                <li>Car #24 assigned to Driver #56</li>
            </ul>
        </div>

        <!-- Upcoming Bookings -->
        <div class="card">
            <h3>Upcoming Bookings</h3>
            <ul>
                <li>Booking #1235 - 2025-03-10 - John Doe</li>
                <li>Booking #1236 - 2025-03-11 - Jane Smith</li>
                <li>Booking #1237 - 2025-03-12 - Alice Johnson</li>
            </ul>
        </div>

        <!-- Chart -->
        <div class="card">
            <h3>Booking Trends</h3>
            <canvas id="bookingChart" width="400" height="200"></canvas>
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

    <!-- Chart.js Script -->
    <script>
        const ctx = document.getElementById('bookingChart').getContext('2d');
        const bookingChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Bookings',
                    data: [120, 190, 300, 250, 200, 300],
                    backgroundColor: 'rgba(0, 123, 255, 0.5)',
                    borderColor: 'rgba(0, 123, 255, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>