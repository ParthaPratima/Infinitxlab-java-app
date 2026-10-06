package com.login;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        Connection con = null;

        try {

            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Read database configuration from environment variables
            String dbHost = System.getenv("DB_HOST");
            String dbPort = System.getenv("DB_PORT");
            String dbName = System.getenv("DB_NAME");
            String dbUsername = System.getenv("DB_USERNAME");
            String dbPassword = System.getenv("DB_PASSWORD");

            // Defaults useful for local development
            if (dbHost == null || dbHost.isEmpty()) {
                dbHost = "localhost";
            }

            if (dbPort == null || dbPort.isEmpty()) {
                dbPort = "3306";
            }

            if (dbName == null || dbName.isEmpty()) {
                dbName = "infinitx";
            }

            if (dbUsername == null || dbUsername.isEmpty()) {
                dbUsername = "root";
            }

            if (dbPassword == null) {
                dbPassword = "";
            }

            String jdbcUrl =
                    "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName
                    + "?useSSL=false"
                    + "&allowPublicKeyRetrieval=true"
                    + "&serverTimezone=UTC";

            con = DriverManager.getConnection(
                    jdbcUrl,
                    dbUsername,
                    dbPassword
            );

            System.out.println(
                    "Database connection successful: "
                    + dbHost + ":" + dbPort + "/" + dbName
            );

        } catch (Exception e) {

            System.err.println("Database connection failed.");
            e.printStackTrace();
        }

        return con;
    }
}
