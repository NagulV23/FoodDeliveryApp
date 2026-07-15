package com.tap.servlet;

import java.io.IOException;
import java.util.List;

import com.tap.daoimplementation.MenuDAOImpl;
import com.tap.daoimplementation.OrderItemDAOImpl;
import com.tap.daoimplementation.OrderTableDAOImpl;
import com.tap.daoimplementation.RestaurantDAOImpl;
import com.tap.model.Menu;
import com.tap.model.OrderItem;
import com.tap.model.OrderTable;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/trackorder")
public class TrackOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String orderIdParam = request.getParameter("orderId");

            if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
                response.sendRedirect("orderhistory");
                return;
            }

            int orderId = Integer.parseInt(orderIdParam);

            OrderTableDAOImpl orderDAO = new OrderTableDAOImpl();
            OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
            RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
            MenuDAOImpl menuDAO = new MenuDAOImpl();

            OrderTable order = orderDAO.getOrder(orderId);

            if (order == null) {
                response.sendRedirect("orderhistory");
                return;
            }

            List<OrderItem> items = orderItemDAO.getOrderItemsByOrderId(orderId);
            Restaurant restaurant = restaurantDAO.getRestaurant(order.getRestaurantId());

            // Get menu names for each item
            java.util.Map<Integer, String> menuNames = new java.util.HashMap<>();
            for (OrderItem item : items) {
                if (!menuNames.containsKey(item.getMenuId())) {
                    Menu menu = menuDAO.getMenu(item.getMenuId());
                    menuNames.put(item.getMenuId(), menu != null ? menu.getItemName() : "Food Item");
                }
            }

            request.setAttribute("order", order);
            request.setAttribute("items", items);
            request.setAttribute("restaurant", restaurant);
            request.setAttribute("menuNames", menuNames);

            RequestDispatcher rd = request.getRequestDispatcher("trackOrder.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("orderhistory");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
