# Mega City Cab System

## Project Overview

The Mega City Cab System is a Java-based application designed to streamline cab service operations for Mega City Cab in Colombo. It replaces manual processes with a computerized system, enabling efficient customer booking management, bill calculation, and system administration. This application aims to improve customer experience and operational efficiency for Mega City Cab.

**Key Features:**

* User authentication (login with username and password)
* Customer registration and booking management
* Bill calculation with taxes and discounts
* Car and driver information management

**Technologies Used:**

* Java
* JUnit 5 (for testing)
* Maven (for build automation and dependency management)
* PostgreSQL (for DB)

## Installation and Setup

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Z1Y4TH/advanced-programming.git
    cd mega-city-cab
    ```

2.  **Build the project using Maven:**

    ```bash
    mvn clean install
    ```

3.  **Run the tests (optional):**

    ```bash
    mvn test
    ```

4.  **Run the application:**

    ```bash
    mvn exec:java -Dexec.mainClass="com.megacitycab.Main"
    ```


## Usage Guide

1.  **Login:**
    * Enter your username and password to access the system.
    * Default admin credentials : username `admin`, password `admin123`.
    

2.  **Customer Booking:**
    * Select the "Add new booking" option.
    * Enter customer details (name, address, phone, NIC) and destination details.


3.  **View Booking Details:**
    * Select the "Display booking details" option.
    * Enter the booking number to view details.


4.  **Calculate Bill:**
    * Select the "Calculate and print bill" option.
    * The system will calculate and display the bill amount.


5.  **Car and Driver Information:**
    * Use the appropriate menu options to manage car and driver details.


7.  **Exit:**
    * Select the "Log out" option to log out and close the application.

## Version Control and Workflow

**Branching Strategy:**

* We use feature branches for new features and bug fixes.
* The `main` branch is kept stable for releases.
* Example: `feature/bill-calculation`, `bugfix/login-error`.

**Committing:**

* Commit messages follow a descriptive format, including the feature or bug fix.
* Example: `feat: Added bill calculation feature` or `fix: Resolved login error`.

**Merging:**

* Pull requests are used to merge feature branches into the `main` branch.
* Code reviews are conducted before merging.

**Tagging:**

* Releases are tagged with version numbers (e.g., `v1.0`, `v1.1`).
* Example: `git tag -a v1.1 -m "Added bill calculation feature"`

**Workflow:**

1.  Create a new feature branch.
2.  Develop and test the feature.
3.  Commit changes with descriptive messages.
4.  Create a pull request to merge the feature branch into `main`.
5.  Conduct code reviews.
6.  Merge the pull request.
7.  Tag the release.

## Testing

* JUnit 5 is used for unit and integration testing.
* To run tests: `mvn test`
* Example test: `BillCalculatorTest` verifies bill calculation logic.
* TDD approach was used, tests were written before code implementation.



## GitHub Repository Link

https://github.com/Z1Y4TH/advanced-programming.git

## Contributions

Contributions are welcome! Please create a pull request with your changes.