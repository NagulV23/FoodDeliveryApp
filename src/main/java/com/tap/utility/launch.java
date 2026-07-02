package com.tap.utility;

import java.sql.Connection;
import java.util.List;

import com.tap.daoimplementation.MenuDAOImpl;
import com.tap.model.Menu;

public class launch {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if(con != null) {
            System.out.println("Database Connected Successfully");
        } else {
            System.out.println("Database Connection Failed");
        }
    }
}