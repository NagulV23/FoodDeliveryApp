package com.tap.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

@WebServlet("/search")
public class MenuSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String query = request.getParameter("query");

            if (query == null || query.trim().isEmpty()) {

                response.sendRedirect("callRestaurantServlet");
                return;
            }

            query = query.trim();

            // Search menu items
            MenuDAOImpl menuDAO = new MenuDAOImpl();
            List<Menu> results = menuDAO.searchMenuItems(query);

            // Get restaurant names for each result
            RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
            Map<Integer, Restaurant> restaurantMap = new HashMap<>();

            for (Menu menu : results) {
                int restId = menu.getRestaurantId();
                if (!restaurantMap.containsKey(restId)) {
                    Restaurant restaurant = restaurantDAO.getRestaurant(restId);
                    restaurantMap.put(restId, restaurant);
                }
            }

            request.setAttribute("results", results);
            request.setAttribute("restaurantMap", restaurantMap);
            request.setAttribute("searchQuery", query);

            RequestDispatcher rd =
                    request.getRequestDispatcher("search-results.jsp");

            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("callRestaurantServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}
