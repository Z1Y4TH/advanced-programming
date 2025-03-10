<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mega City Cab - Home</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .navbar {
            background-color: #007bff;
        }

        .navbar-brand, .navbar-nav .nav-link {
            color: white !important;
        }

        .form-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 30px auto;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #343a40;
        }

        .form-container label {
            font-weight: 600;
            color: #495057;
        }

        .form-container input, .form-container select {
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .form-container button {
            padding: 12px 20px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }

        .form-container button:hover {
            background-color: #0056b3;
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
            padding: 30px;
            border-radius: 8px;
            width: 400px;
        }

        .modal-content label {
            font-weight: 600;
            color: #495057;
        }

        .modal-content input {
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .modal-content button {
            padding: 12px 20px;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }

        .modal-content button:hover {
            background-color: #0056b3;
        }

        .jumbotron {
            background-color: #007bff;
            color: white;
            padding: 100px 20px;
            text-align: center;
        }

        .jumbotron h1 {
            font-size: 48px;
            font-weight: bold;
        }

        .jumbotron p {
            font-size: 18px;
        }

        .features {
            padding: 50px 0;
            text-align: center;
        }

        .features h2 {
            margin-bottom: 50px;
        }

        .feature-item {
            padding: 20px;
        }

        .feature-item h3 {
            font-size: 24px;
            font-weight: bold;
        }

        .feature-item p {
            font-size: 16px;
            color: #666;
        }

        .footer {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: 50px;
        }

        .footer p {
            margin: 0;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <a class="navbar-brand" href="/MegaCityCab">Mega City Cab</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
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

    <div class="jumbotron">
        <h1>Welcome to Mega City Cab</h1>
        <p>Your reliable partner for safe and comfortable rides in Colombo City.</p>
    </div>
    
    <div class="form-container">
        <h2>Book Now</h2>
        <form id="bookingForm" action="addBooking" method="post">
            <div class="form-group">
                <label for="phoneNumber">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="pickupLocation">Pickup Location:</label>
                <input type="text" id="pickupLocation" name="pickupLocation" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="destination">Destination:</label>
                <input type="text" id="destination" name="destination" class="form-control" required>
            </div>
            <button type="button" onclick="submitBookingForm()" class="btn btn-primary btn-block">Add Booking</button>
        </form>
        <div class="error-message">
            ${errorMessage}
        </div>
    </div>

    <div class="container features">
        <h2>Why Choose Mega City Cab?</h2>
        <div class="row">
            <div class="col-md-4 feature-item">
                <h3>24/7 Availability</h3>
                <p>We are available round the clock to serve you anytime, anywhere.</p>
            </div>
            <div class="col-md-4 feature-item">
                <h3>Affordable Rates</h3>
                <p>Enjoy competitive pricing with no hidden charges.</p>
            </div>
            <div class="col-md-4 feature-item">
                <h3>Safe & Comfortable</h3>
                <p>Our well-maintained vehicles and professional drivers ensure a safe and comfortable ride.</p>
            </div>
        </div>
    </div>

    

    <div id="nicModal" class="modal">
        <div class="modal-content">
            <h3>Verify NIC</h3>
            <form id="nicForm">
                <div class="form-group">
                    <label for="enic">NIC:</label>
                    <input type="text" id="enic" name="enic" class="form-control" required>
                </div>
                <button type="button" onclick="verifyNic()" class="btn btn-primary">Verify</button>
                <button type="button" onclick="hideNicModal()" class="btn btn-secondary">Cancel</button>
            </form>
            <div id="nicErrorMessage" class="error-message"></div>
        </div>
    </div>

    <div id="customerModal" class="modal">
        <div class="modal-content">
            <h3>Enter Customer Details</h3>
            <form id="customerForm">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="nic">NIC:</label>
                    <input type="text" id="nic" name="nic" class="form-control" required>
                </div>
                <button type="button" onclick="submitCustomerForm()" class="btn btn-primary">Submit</button>
                <button type="button" onclick="hideCustomerForm()" class="btn btn-secondary">Cancel</button>
            </form>
            <div id="modalErrorMessage" class="error-message"></div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>All rights reserved &copy; 2025 Mega City Cab</p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function submitBookingForm() {
            const phoneNumber = document.getElementById("phoneNumber").value;
            const pickupLocation = document.getElementById("pickupLocation").value;
            const destination = document.getElementById("destination").value;

            // Validate required fields
            if (!phoneNumber || !pickupLocation || !destination) {
                alert("Please fill in all required fields.");
                return;
            }

            // Check if the customer exists
            fetch("checkCustomer?phoneNumber=" + encodeURIComponent(phoneNumber))
                    .then(response => response.json())
                    .then(data => {
                        if (data.exists) {
                            // If customer exists, show the NIC verification modal
                            showNicModal();
                        } else {
                            // If customer does not exist, show the customer details modal
                            showCustomerForm();
                        }
                    })
                    .catch(error => {
                        console.error("Error checking customer:", error);
                        alert("An error occurred while checking customer details. Please try again.");
                    });
        }

        function showNicModal() {
            document.getElementById("nicModal").style.display = "flex";
        }

        function hideNicModal() {
            document.getElementById("nicModal").style.display = "none";
        }

        function verifyNic() {
            const phoneNumber = document.getElementById("phoneNumber").value;
            const nic = document.getElementById("enic").value;

            fetch("validateCustomer", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: "phoneNumber=" + encodeURIComponent(phoneNumber)+"&nic=" + encodeURIComponent(nic),
            })
            .then(response => response.json())
            .then(data => {
                if (data.valid) {
                    // If NIC and phone number match, retrieve customerId and submit the booking form
                    const customerId = data.customerId;

                    const bookingForm = document.getElementById("bookingForm");
                    const customerIdInput = document.createElement("input");
                    customerIdInput.type = "hidden";
                    customerIdInput.name = "customerId";
                    customerIdInput.value = customerId;
                    bookingForm.appendChild(customerIdInput);

                    bookingForm.submit();
                } else {
                    // If NIC and phone number do not match, show error message
                    document.getElementById("nicErrorMessage").innerText = "Invalid NIC or phone number.";
                }
            })
            .catch(error => {
                console.error("Error verifying NIC:", error);
                alert("An error occurred while verifying NIC. Please try again.");
            });
        }

        function showCustomerForm() {
            document.getElementById("customerModal").style.display = "flex";
        }

        function hideCustomerForm() {
            document.getElementById("customerModal").style.display = "none";
        }

        function submitCustomerForm() {
            const phoneNumber = document.getElementById("phoneNumber").value;
            const name = document.getElementById("name").value;
            const address = document.getElementById("address").value;
            const nic = document.getElementById("nic").value;

            fetch("addCustomer", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: "name=" + encodeURIComponent(name) + "&address=" + encodeURIComponent(address) + "&nic=" + encodeURIComponent(nic) + "&phoneNumber=" + encodeURIComponent(phoneNumber),
            })
            .then(response => response.json())
            .then(data => {
                const customerId = data.customerId;

                const bookingForm = document.getElementById("bookingForm");

                const customerIdInput = document.createElement("input");
                customerIdInput.type = "hidden";
                customerIdInput.name = "customerId";
                customerIdInput.value = customerId;
                bookingForm.appendChild(customerIdInput);

                // Submit the booking form
                bookingForm.submit();
            })
            .catch(error => {
                console.error("Error adding customer:", error);
                alert("An error occurred while adding customer. Please try again.");
            });
        }
    </script>
</body>
</html>