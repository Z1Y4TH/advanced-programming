package com.megacitycab.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String URL = "jdbc:postgresql://localhost:5432/mega_city_cab";
    private static final String USER = "postgres";
    private static final String PASSWORD = "nim#MBI&ccr";

    private static Connection testConnection; // Add this

    static {
        try {
            // Explicitly load the PostgreSQL JDBC driver
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to load PostgreSQL JDBC driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (testConnection != null) { // Check if test connection is set
            return testConnection;
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    public static void setTestConnection(Connection conn) { // Add this method
        testConnection = conn;
    }

    public static void closeTestConnection() throws SQLException {
        if(testConnection != null){
            if(!testConnection.isClosed()){
                testConnection.close();
            }
            testConnection = null;
        }
    }
}