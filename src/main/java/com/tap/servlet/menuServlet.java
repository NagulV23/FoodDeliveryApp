package com.tap.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.tap.daoimplementation.MenuDAOImpl;
import com.tap.daoimplementation.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/menu")
public class menuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // Get Restaurant ID
            String restaurantIdParam =
                    request.getParameter("restaurantId");

            if (restaurantIdParam == null ||
                restaurantIdParam.trim().isEmpty()) {

                response.sendRedirect("callRestaurantServlet");
                return;
            }

            int restaurantId =
                    Integer.parseInt(restaurantIdParam);

            // ==============================
            // Fetch Restaurant
            // ==============================

            RestaurantDAOImpl restaurantDAO =
                    new RestaurantDAOImpl();

            Restaurant restaurant =
                    restaurantDAO.getRestaurantById(restaurantId);

            // ==============================
            // Fetch Menu Items
            // ==============================

            MenuDAOImpl menuDAO =
                    new MenuDAOImpl();

            List<Menu> allMenusByRestaurant =
                    menuDAO.getAllMenusByRestaurant(restaurantId);

            // ==============================
            // Send Data to JSP
            // ==============================

            request.setAttribute(
                    "restaurant",
                    restaurant);

            request.setAttribute(
                    "allMenusByRestaurant",
                    allMenusByRestaurant);

            RequestDispatcher rd =
                    request.getRequestDispatcher("menu.jsp");

            rd.forward(request, response);

        }

        catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "restaurant",
                    null);

            request.setAttribute(
                    "allMenusByRestaurant",
                    new ArrayList<Menu>());

            RequestDispatcher rd =
                    request.getRequestDispatcher("menu.jsp");

            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}