package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL =
            System.getenv().getOrDefault(
                    "DB_URL",
                    "jdbc:mysql://localhost:3306/food_delivery_application"
            );

    private static final String USERNAME =
            System.getenv().getOrDefault(
                    "DB_USERNAME",
                    "root"
            );

    private static final String PASSWORD =
            System.getenv().getOrDefault(
                    "DB_PASSWORD",
                    "root"
            );

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("DB URL : " + URL);

            Connection connection =
                    DriverManager.getConnection(URL, USERNAME, PASSWORD);

            System.out.println("Database Connected Successfully");

            return connection;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}