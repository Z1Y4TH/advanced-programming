package com.megacitycab.dao;

import com.megacitycab.model.Car;
import com.megacitycab.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CarDAO {
    private static final String INSERT_CAR = "INSERT INTO cars (model, registration_number, driver_id) VALUES (?, ?, ?)";
    private static final String SELECT_ALL_CARS = "SELECT * FROM cars";
    private static final String SELECT_CAR_BY_ID = "SELECT * FROM cars WHERE car_id = ?";
    private static final String UPDATE_CAR = "UPDATE cars SET model = ?, registration_number = ?, driver_id = ? WHERE car_id = ?";
    private static final String DELETE_CAR = "DELETE FROM cars WHERE car_id = ?";

    public boolean addCar(Car car) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_CAR)) {
            stmt.setString(1, car.getModel());
            stmt.setString(2, car.getRegistrationNumber());
            stmt.setInt(3, car.getDriverId());
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Car> getAllCars() {
    List<Car> cars = new ArrayList<>();
    String SELECT_ALL_CARS = "SELECT c.car_id, c.model, c.registration_number, c.driver_id, d.name AS driver_name " +
                             "FROM cars c " +
                             "LEFT JOIN drivers d ON c.driver_id = d.driver_id";
    try (Connection conn = DBUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_CARS)) {
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Car car = new Car();
            car.setCarId(rs.getInt("car_id"));
            car.setModel(rs.getString("model"));
            car.setRegistrationNumber(rs.getString("registration_number"));
            car.setDriverId(rs.getInt("driver_id"));
            car.setDriverName(rs.getString("driver_name")); // Set driver name
            cars.add(car);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return cars;
}

    public Car getCarById(int carId) {
        Car car = null;
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CAR_BY_ID)) {
            stmt.setInt(1, carId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                car = new Car();
                car.setCarId(rs.getInt("car_id"));
                car.setModel(rs.getString("model"));
                car.setRegistrationNumber(rs.getString("registration_number"));
                car.setDriverId(rs.getInt("driver_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return car;
    }

    public boolean updateCar(Car car) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_CAR)) {
            stmt.setString(1, car.getModel());
            stmt.setString(2, car.getRegistrationNumber());
            stmt.setInt(3, car.getDriverId());
            stmt.setInt(4, car.getCarId());
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCar(int carId) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_CAR)) {
            stmt.setInt(1, carId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}